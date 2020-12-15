%Rotation (from orbit to ground) matrix with position and velocity vectors.
%See: SPOT Hand Book, 2002, page: 33
%Recoded by Hüseyin TOPAN (ZKÜ), October 2008.

function RS = Rs (PV)

RS(:, 3) = PV(1:3) / norm(PV(1:3));

RS(:, 1) = cross((PV(4:6) / norm(PV(4:6)))', RS(:, 3));

RS(:, 2) = cross(RS(1:3, 3), RS(:, 1));