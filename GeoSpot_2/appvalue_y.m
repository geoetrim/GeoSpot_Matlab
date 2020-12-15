%Determination approximate values of unknowns with 2nd order polynomial
%Coded by Hüseyin TOPAN (ZKÜ) July 2009

function dx = appvalue_18 (gcp, k)

y = gcp (:, 8);

L  = gcp (:, k + 17); 

%-------------------------------
for i = 1 : length (gcp(:, 1))
    for j = 0 : 2
        A(i, j+1) = y(i)^j;
    end
end

dx = inv(A' * A) * A' * L;