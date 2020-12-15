%Calculation of attitude angle for each line
%Case for SPOT-5
%Reference: SPOT Handbook, page 36.
%Edited January 2009

function a = arpy (attia, attit, t)

dt = attit (:) - t;

for i = 1 : length(attia(:, 1));
    if dt(i) <= 0;
    dtn(i) = dt(i);
    end
end
 
nti = length(dtn);

a = attia (nti) + (attia(nti + 1) - attia(nti)) * ((t - attit(nti)) / (attit(nti + 1) - attit(nti)));