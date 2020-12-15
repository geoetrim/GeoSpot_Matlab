% Estimation XYZ from stereo images using given look angles and parameters
function estXYZ(gcp1, gcp2)

estXYZ = calcXYZ(gcp1, gcp2);

d = gcp1(:, 4 : 6) - estXYZ;

for k = 1 : 3
    m(k) = sqrt((d(:, k)' * d(:, k)) / (length(gcp1(:, 1))));
end
    
fprintf(' mX = %5.2f (m)\n mY = %5.2f (m)\n mZ = %5.2f (m)\n\n', m);

% pltv_g(gcp1, d, 0);

% pltv_estXYZ(gcp1, d);