
CLEARSCREEN.
sas off.
print "STS Landing Guidance Computer" at (12,0).
set mythrottle to 0.0.
set pitchcommand to 0.
set closing to 0.
set inrange to 0.
set retrodist to 1140000.
SET MYSTEER TO HEADING(270,pitchcommand,0).
set runwayWest to latlng( -0.048597000539, -74.72335052490).
set lastdistance to runwayWest:DISTANCE.
LOCK THROTTLE TO mythrottle.   // 1.0 is the max, 0.0 is idle.
bays off.
LOCK STEERING TO MYSTEER. 

	print " -----------------------------------" at (0,18).
	print "|     Telemetry    |                |" at (0,19).
	print "|------------------|----------|-----|" at (0,20).
	print "|          Apoapsis| " at (0,21). 
	print "|         Periapsis| " at (0,22). 
	print "|               Alt| " at (0,23). 
	print "|             Speed| " at (0,24).
	print "|         CMD Pitch| " at (0,25).
	print "|          Throttle| " at (0,26).
	print "|Distance to Runway| " at (0,27).
	print " -----------------------------------" at (0,28).
print "| KM  |" at (30,21).
print "| KM  |" at (30,22).
print "|Meter|" at (30,23).
print "| M/S |" at (30,24).
print "| DEG |" at (30,25).
print "| %   |" at (30,26).
print "| KM  |" at (30,27).
rcs on.
print round((apoapsis/1000),2) at (21,21).
print round((periapsis/1000),2) at (21,22).
print round(altitude,0)+ "  " at (21,23).
print round(airspeed,0) + "  " at (21,24).
print round(pitchcommand,2) + "  " at (21,25).
print (round(mythrottle,2)*100) + "  " at (21,26).
print round((runwayWest:DISTANCE/1000),0)+ "  " at (21,27).
set tempalt to altitude.


if periapsis > 72000{clearscreen. run stspreretro. }.
set warp to 0.
set warpmode to "RAILS".
set warp to 3.
	
print "Waiting until re-entry maneuver start" at (0,4).
until periapsis < 500 {
	SET MYSTEER TO HEADING(270, pitchcommand, 0).
	
	if (runwayWest:DISTANCE - lastdistance ) < 0{
	set closing to 1.}. else {set closing to 0.}.


	if runwaywest:distance < (retrodist + 50000) and runwaywest:distance > retrodist {
		set inrange to 1. }. else {set inrange to 0.}.

	if inrange = 1 and closing = 1 {set OMSArmed to 1.} else {set OMSArmed to 0.}.


	set lastdistance to runwayWest:DISTANCE.
	print round((apoapsis/1000),2) at (21,21).
	print round((periapsis/1000),2) at (21,22).
	print round(altitude,0)+ "  " at (21,23).
	print round(airspeed,0) + "  " at (21,24).
	print round(pitchcommand,2) + "  " at (21,25).
	print (round(mythrottle,2)*100) + "  " at (21,26).
	print round((runwayWest:DISTANCE/1000),0)+ "  " at (21,27).




	
	If OMSArmed = 1 {
	set warp to 0.	
	set warpmode to "physics".
	set warp to 3.
	print "Maneuvering to retrofire attitude" at (0, 5).
	print "OMS Armed     " at (0,6).}. else {print "                        " at (0,6).}.
	
	if OMSArmed = 1 and runwaywest:distance < (retrodist +3000){	
	set mythrottle to 1.0.
	print "Firing OMS     " at (0,6).	
	}. 




}.



until altitude < 70000 {
	set mythrottle to 0.
	print "De-orbit burn complete" at (0, 7).
	print "Awaiting entry interface" at (0,8).
	set pitchcommand to 0.
	SET MYSTEER TO HEADING(90,pitchcommand,0).
print "| KM  |" at (30,21).
print "| KM  |" at (30,22).
print "|Meter|" at (30,23).
print "| M/S |" at (30,24).
print "| DEG |" at (30,25).
print "| %   |" at (30,26).
print "| KM  |" at (30,27).
	}.
set warp to 0.
set warpmode to "PHYSICS".
set warp to 4.
until altitude < 10000 {

	if altitude < 70000 and altitude > 24000 {set pitchcommand to 0.}.
	if altitude < 24000 and altitude > 22000 {set pitchcommand to -2.
						  set warp to 0.}.
	if altitude < 22000 and altitude > 20000 {set pitchcommand to -3.}.
	if altitude < 20000 and altitude > 18000 {set pitchcommand to -4.}.
	if altitude < 18000 and altitude > 16000 {set pitchcommand to -5.}.
	if altitude < 16000 and altitude > 14000 {set pitchcommand to -6.}.
	if altitude < 14000 and altitude > 12000 {set pitchcommand to -7.}.
	if altitude < 12000 and altitude > 10000 {set pitchcommand to -8.
						print "Preparing to disconnect autopilot" at (0,8).}.
       


	SET MYSTEER TO HEADING(90,pitchcommand,0).
	LOCK STEERING TO MYSTEER. 
	print "Beginning re-entry" at (0, 9).


	print round((apoapsis/1000),2) at (21,21).
	print round((periapsis/1000),2) at (21,22).
	print round(altitude,0)+ "  " at (21,23).
	print round(airspeed,0) + "  " at (21,24).
	print round(pitchcommand,2) + "  " at (21,25).
	print (round(mythrottle,2)*100) + "  " at (21,26).
	print round((runwayWest:DISTANCE/1000),0)+ "  " at (21,27).


}.

Until altitude < 75 {
print "AUTOPILOT DISCONNECTED" at (0,10).
print "AUTOPILOT DISCONNECTED" at (0,11).
print "AUTOPILOT DISCONNECTED" at (0,12).
unlock steering.
unlock throttle.
rcs off.
sas on.
	print round((apoapsis/1000),2) at (21,21).
	print round((periapsis/1000),2) at (21,22).
	print round(altitude,0)+ "  " at (21,23).
	print round(airspeed,0) + "  " at (21,24).
	print "MANUAL" at (21,25).
	print "MANUAL" at (21,26).
	print round((runwayWest:DISTANCE/1000),0) + " "at (21,27).
if ALT:RADAR<500 {Gear on.}.

}.
print "Landing guidance complete." at (0,13).