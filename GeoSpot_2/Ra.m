%Rotation (from payload to orbit) matrix with attitude angles.
%See: Fotev et al., 2005 and SPOT Hand Book, 2002, page: 37
%Recoded by Hüseyin TOPAN (ZKÜ), October 2008. 

function RA = Ra (unknwni)

ar = unknwni(1);
ap = unknwni(2);
ay = unknwni(3);

% Fotev et al., 2005
RA = [1  -ay  ar ;
      ay  1  -ap ;
     -ar  ap  1 ];

% SPOT Hand Book, 2002, page: 37. Note: The roll and pitch angles taken
% from the header file must be multiplied by -1 for this matrix.
% RA(1,1) = cos(ar) * cos(ay);
% RA(1,2) = -cos(ar) * sin(ay);
% RA(1,3) = -sin(ar);
% 
% RA(2,1) = sin(ap) * sin(ar) * cos(ay) + cos(ap) * sin(ay);
% RA(2,2) = -sin(ap) * sin(ar) * sin(ay) + cos(ap) * cos(ay);
% RA(2,3) = sin(ap) * cos(ar);
% 
% RA(3,1) = cos(ap) * sin(ar) * cos(ay) - sin(ap) * sin(ay);
% RA(3,2) = -cos(ap) * sin(ar) * sin(ay) - sin(ap) * cos(ay);
% RA(3,3) = cos(ap) * cos(ar);