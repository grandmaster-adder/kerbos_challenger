
CLEARSCREEN.
print "STS Ascent Guidance Computer" at (12,0).
set mythrottle to 0.7.
LOCK THROTTLE TO mythrottle.   // 1.0 is the max, 0.0 is idle.
set startmass to mass.
set startthrust to maxthrust.
set srbsepmass to mass - 280.
set srbsep to 0.
set etsep to 0.
set ap to 100000.
set inclination to 0.
set roundout to 35000.
set pitchcommand to 90.

	print " -----------------------------------" at (0,10).
	print "|Launch  Parameters|          |" at (0,11).
	print "|------------------|----------|" at (0,12).
	print "|    Circular Orbit| " + round((ap/1000),1) at (0,13).
	print "|       Inclination| " + inclination at (0,14).
	print "| Roundout Altitude| " + round((roundout/1000),3) at (0,15).
	print "|        Start Mass| "  + round(startmass,1) at (0,16).
	print "|      SRB SEP Mass| " + round(srbsepmass,1) at (0,17).
	print "|------------------|----------|" at (0,18).
	print "|     Telemetry    | " at (0,19).
	print "|------------------|----------|" at (0,20).
	print "|              Mass| " at (0,21).
	print "|           Curr AP| " at (0,22).
	print "|               Alt| " at (0,23). 
	print "|           Curr PE| " at (0,24). 
	print "|          Curr Inc| " at (0,25).
	print "|         CMD Pitch| " at (0,26).
	print "|          Throttle| " at (0,27).
	print " -----------------------------------" at (0,28).
print "|     |" at (30,11).
print "|-----|" at (30,12).
print "| KM  |" at (30,13).
print "| DEG |" at (30,14).
print "| KM  |" at (30,15).
print "| MT  |" at (30,16).
print "| MT  |" at (30,17).
print "|-----|" at (30,18).
print "|     |" at (30,19).
print "|-----|" at (30,20).
print "| MT  |" at (30,21).
print "| KM  |" at (30,22).
print "| KM  |" at (30,23).
print "| KM  |" at (30,24).
print "| DEG |" at (30,25).
print "| DEG |" at (30,26).
print "| %   |" at (30,27).
print round(mass,2) at (21,21).
print round((apoapsis/1000),3) + "  " at (21,22).
print round((altitude/1000),3)  + "  " at (21,23).
print round((periapsis/1000),3) + "  "  at (21,24).
print round(orbit:inclination,3) + "  " at (21,25).
print pitchcommand + "  " at (21,26).
print (mythrottle * 100) at (21,27).

PRINT "T-:" at (0,1).
FROM {local countdown is 3.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT countdown at (3,1).
    WAIT 1. // pauses the script here for 1 second.
}

print "SRB and Main Engine Ignition" at (0,1).
stage.


SET MYSTEER TO HEADING(90,pitchcommand,180).
LOCK STEERING TO MYSTEER. 
wait 2.
print "Cleared the tower" at (0,2).
SET MYSTEER TO HEADING((90 + inclination),pitchcommand,180).
wait 5.



UNTIL SHIP:APOAPSIS > (ap) { 
	set massratio to mass/startmass.
	set srbsepratio to mass/srbsepmass.
	SET MYSTEER TO HEADING((90 + inclination),pitchcommand,180).
	
	//Curve control
	if altitude < roundout {set pitchcommand to (90 - (altitude / roundout) * 90).}.
       if apoapsis > 70000  {set pitchcommand to -18.000.}.

	//Set Throttle as an increasing function of decreasing mass due to CG shift
	if srbsep = 0{
		set mythrottle to ((1/massratio-1)*0.3+0.6).
		if mythrottle > 1 {
			set mythrottle to 1.}.
	}.
        else	
	{set mythrottle to ((1/srbsepratio-1)*0.5+0.4).
		if mythrottle > 1 {
			set mythrottle to 1.}.
	}.
	//Jettison SRBs							//IF maxthrust < 3500 and srbsep = 0 {
	if mass < srbsepmass and srbsep = 0{
 
		RCS ON.
		lock throttle to .5.
                wait 1.
		STAGE.
		set SRBSEP to 1.
		print "SRB Jettison" at (0,3).
		lock throttle to mythrottle.
		rcs off.
		}

	//Jettison external tank
	if SRBSEP = 1 and maxthrust < 2000 {
		RCS ON.
		set mythrottle to 1.
		stage.
		print "External tank separation" at (0,4).
		set etsep to 1.
		}.
print round(mass,2) at (21,21).
print round((apoapsis/1000),3) + " " at (21,22).
print round((altitude/1000),3) + " " at (21,23).
print round((periapsis/1000),3) + " " at (21,24).
print round(orbit:inclination,3) + " " at (21,25).
print round(pitchcommand,0)  + " " at (21,26).
print (round(mythrottle,3)*100)  + " "at (21,27).


}.

print "    " at (21,26).
print "    " at (21,27).
rcs on.
SET MYSTEER TO HEADING((90 + inclination),pitchcommand,180).
set mythrottle to 0.
		if etsep = 0 {
                stage.
		print "External tank separation" AT (0,4).
		.//Jettison external tank
set warp to 4.
}.

until altitude > (apoapsis -1000){
print "Coasting to " + round(((apoapsis-50)/1000),3) + "km" at (0,5).
	if altitude > 70000 {set warp to 2.}.
	SET MYSTEER TO HEADING((90 + inclination),pitchcommand,180).
print round(mass,2) at (21,21).
print round((apoapsis/1000),3) + " " at (21,22).
print round((altitude/1000),3) + " " at (21,23).
print round((periapsis/1000),3) + " " at (21,24).
print round(orbit:inclination,3) + " " at (21,25).
print round(pitchcommand,0) + " " at (21,26).
print (round(mythrottle,3)*100) + " " at (21,27).
	
}.
set warpmode to "PHYSICS".
set warp to 3.
set pitchcommand to -0.
print "    " at (21,26).
print "    " at (21,27).
SET MYSTEER TO HEADING((90 + inclination),pitchcommand,180).
print round(mass,2) at (21,21).
print round((apoapsis/1000),3) + " " at (21,22).
print round((altitude/1000),3) + " " at (21,23).
print round((periapsis/1000),3) + " " at (21,24).
print round(orbit:inclination,3)  + " " at (21,25).
print round(pitchcommand,0)   + " " at (21,26).
print (round(mythrottle,3)*100) at (21,27).
wait until altitude >= (apoapsis-50).
	print "Circularizing" at (0,6).

Until periapsis >= (ap-500) { 

set mythrottle to 1.
	SET MYSTEER TO HEADING((90 + inclination),pitchcommand,180).

	if apoapsis > (ap+50) {
		if pitchcommand > -5 {set pitchcommand to pitchcommand - 1.}.
		wait .2.}.
        if apoapsis < (ap-50) {
		if pitchcommand <= 5 {set pitchcommand to pitchcommand + 1.}.
                wait.2.}.

print round(mass,2)  + "  "at (21,21).
print round((apoapsis/1000),3) + " " at (21,22).
print round((altitude/1000),3)  + " "at (21,23).
print round((periapsis/1000),3) + " " at (21,24).
print round(orbit:inclination,3) + " " at (21,25).
print round(pitchcommand,0)  + " " at (21,26).
print (round(mythrottle,3)*100) + " " at (21,27).

}.

Lock throttle to 0.

//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
unlock steering.
unlock throttle.
rcs off.
sas on.

print "AP: " + round(apoapsis,0) at (0,7).
print "PE: " + round(periapsis,0) at (0,8).
print "Ascent guidance complete." at (0,9).