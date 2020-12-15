% Parameter validation test
% Confirmed by Adjustment Computations, Charles D. GHILANI and Paul R.
% WOLF

function [tsnc, kor] = par_valid (A, v, dx, Qxx, Sc)

if Sc == 0
    nSc = 0;
elseif Sc > 0
    nSc = length(Sc);
end

% Q = inv(A' * A); %Bilinmeyenlerin ters aðýrlýk matrisi

f = length (A (: , 1)) - length (dx); %degree of freedom

mo = sqrt ((v' * v) / f);

for i = 1 : length (Qxx)
    m (i) = mo * sqrt (Qxx (i , i));
end

T = tinv (0.975, f); %Test value from table

for i = 1 : length (dx)
    t (i) = abs (dx(i)) / m(i);
    if t (i) <= T
        tsnc (i) = 0; %unvalid
    else
        tsnc (i) = 1; %valid
    end
end

%Showing the validation of EOPs
tsnc (1 : (length (dx) - 3 * nSc));

for i = 1 : (length(Qxx) - 3 * nSc)
    for j = 1 : (length(Qxx) - 3 * nSc)
        kor(i , j) = Qxx(i , j) / sqrt(Qxx(i , i) * Qxx(j, j));
    end
end