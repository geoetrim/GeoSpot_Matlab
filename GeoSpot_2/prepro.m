% PREPROCESSING OF GCPs and METADATA
% Recoded by Huseyin TOPAN (ZKU), July 2009

function [appval, gcp, meta] = prepro(gcp, meta, satpv, atti, lookang)

%===== (x, y) - (xo, yo) =====
for i = 2 : 3
    gcp(:, i + 5) = gcp(:, i) - meta(i - 1); 
end

%===== (h + m + s) => s =====
satpv(:, 10)    = hms2s (satpv);
atti (:,  7)    = hms2s (atti);

%===== time of each line, from 0th hour of the date =====
ti = meta(4) + gcp(:, 7) * meta(3);

%===== Calculation of position and velocity for each line =====
for i = 1 : length(gcp(:,1))
    for k = 1 : 3
        gcp(i, k +  8) = lagr (satpv(:, 10), satpv(:, k + 3), ti(i)); %position
        gcp(i, k + 11) = lagr (satpv(:, 10), satpv(:, k + 6), ti(i)); %velocity
    
        %===== Calculation of attitude angles for each line =====
        gcp(i, k + 14) = arpy (atti(:, k + 3), atti(:, 7), ti(i));
    end
    
    %===== Calculation of look angles for each column of GCP ======
     for k = 1 : 2
        gcp (i, k + 17) = angy (gcp(i, 3), lookang(:, k + 1));
     end
end

%===== Calculation of approximate values and statisticaly validation for Position, Velocity, and Attitude angles =====
for k = 1 : 9
    appval(k, :) = appvalue(gcp, k); % 2nd order poly.
end

