% Calculation of look angle for each y

function ang = angy (y, angle)

ypre = y - mod(y, 1);

ang = angle (ypre) + (angle (ypre + 1) - angle (ypre)) * ( y - ypre);