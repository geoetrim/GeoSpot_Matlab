GCP file

 1 nn     <= input values
 2 x      <= input values (line)
 3 y      <= input values (column)
 4 X      <= input values
 5 Y      <= input values
 6 Z      <= input values
 7 x-xo   <= added by program
 8 y-yo   <= added by program
 9 Xs     <= added by program (Approx. position of principle point for each line)
10 Ys     <= added by program (				"			) 
11 Zs     <= added by program (				"			)
12 Vxs	  <= added by program (Approx. velocity of principle point for each line)
13 Vys    <= added by program (				"			)																																																																																				)
14 Vzs    <= added by program (				"			)																																																																																				)
15 ar     <= added by program (Approx. attiude angle (roll)  for each line)
16 ap     <= added by program (Approx. attiude angle (pitch) for each line)
17 ay     <= added by program (Approx. attiude angle (yaw)   for each line)
18 PSI X  <= added by program (Look angle for the for each line)
19 PSI Y  <= added by program (Look angle for the for each line)
20 ~X and X <= added by program (~X for bundle adjustment in first iteration, X: corrected value)
21 ~Y and Y <= added by program (~Y for bundle adjustment in first iteration, Y: corrected value)
22 ~Z and Z <= added by program (~Z for bundle adjustment in first iteration, Z: corrected value)
23 Vpsix    <= added by program (residual for psix) 
24 Vpsiy    <= added by program (residual for psiy)

Meta file:
 1 xo	 görüntünün merkez satiri
 2 yo	 görüntünün merkez sütunu
 3 dt    imaging time for a line (second)                   
 4 UT	 <= added by program (imaging time starting 0th hour for image center)

Satellite position & velocity file:
 1 hour
 2 minute
 3 second
 4 X
 5 Y
 6 Z
 7 Vx 
 8 Vy
 9 Vz
10 time (second)<= added by program

Satellite attitude file
 1 hour
 2 minute
 3 second
 4 roll
 5 pitch
 6 yaw
 7 time (second) <= added by program
 
Look angle file
 1 column
 2 PSI X 	Radian
 3 PSI Y	Radian

Approximately values file <= added by program
 1 Xo dXo * t
 2 Y
 3 Z
 4 Vx
 5 Vy
 6 Vz
 7 Roll
 8 Pitch
 9 Yaw