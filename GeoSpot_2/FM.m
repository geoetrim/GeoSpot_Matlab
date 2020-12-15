% Functional (Orbit Attitude) Model with look angle for SPOT-5 HRG
% Reference: Serge Raizanoff, 2004
% Orhan Hocanýn önerdiði þekilde düzenlenmiþtir.
clear; clc;

syms X  Y  Z ...
     Xo Yo Zo Vxo Vyo Vzo aro apo ayo...
     a1 a2 a3 a4  a5  a6  a7  a8  a9...
     b1 b2 b3 b4  b5  b6  b7  b8  b9...
     dx...
     psiy psix
     
Xs = Xo  + a1 * dx + b1 * dx^2;
Ys = Yo  + a2 * dx + b2 * dx^2;
Zs = Zo  + a3 * dx + b3 * dx^2;

Vx = Vxo + a4 * dx + b4 * dx^2;
Vy = Vyo + a5 * dx + b5 * dx^2;
Vz = Vzo + a6 * dx + b6 * dx^2;

ar = aro + a7 * dx + b7 * dx^2;
ap = apo + a8 * dx + b8 * dx^2;
ay = ayo + a9 * dx + b9 * dx^2;

P = sqrt(Xs^2 + Ys^2 + Zs^2);

V = sqrt(Vx^2 + Vy^2 + Vz^2);

RS(3, 1) = Xs / P;
RS(3, 2) = Ys / P;
RS(3, 3) = Zs / P;

RS(1, 1) = Vy / V * RS(3, 3) - Vz / V * RS(3, 2);
RS(1, 2) = Vz / V * RS(3, 1) - Vx / V * RS(3, 3);
RS(1, 3) = Vx / V * RS(3, 2) - Vy / V * RS(3, 1);

RS(2, 1) = RS(3, 2) * RS(1, 3) - RS(1, 2) * RS(3, 3);
RS(2, 2) = RS(3, 3) * RS(1, 1) - RS(1, 3) * RS(3, 1);
RS(2, 3) = RS(3, 1) * RS(1, 2) - RS(1, 1) * RS(3, 2);
%--------------
%Similar like one in R_matris_7.m since the attitude angles are very small.
% RA(1, 1) =   1;
% RA(1, 2) =  ay;
% RA(1, 3) = -ar;
% 
% RA(2, 1) = -ay;
% RA(2, 2) =   1;
% RA(2, 3) =  ap;
% 
% RA(3, 1) =  ar;
% RA(3, 2) = -ap;
% RA(3, 3) =   1;

RA = [ 1  ay -ar;
     -ay   1  ap;
      ar -ap   1];

R = RA * RS;

pay1  = R(1,1) * (X-Xs) + R(1,2) * (Y-Ys) + R(1,3) * (Z-Zs);
pay2  = R(2,1) * (X-Xs) + R(2,2) * (Y-Ys) + R(2,3) * (Z-Zs);
payda = R(3,1) * (X-Xs) + R(3,2) * (Y-Ys) + R(3,3) * (Z-Zs);

%A.x + B.v + w = 0 <-- Bilinmeyenli koþullu ölçüler dengelemesi
% fpsiy = pay1 / payda - tan(psiy)
% fpsix = pay2 / payda + tan(psix)

A(1,  1) = (1 / payda) * ( diff(pay1, Xo ) - diff(payda, Xo  ) * tan(psiy));
A(1,  2) = (1 / payda) * ( diff(pay1, a1 ) - diff(payda, a1  ) * tan(psiy));
A(1,  3) = (1 / payda) * ( diff(pay1, b1 ) - diff(payda, b1  ) * tan(psiy));
A(1,  4) = (1 / payda) * ( diff(pay1, Yo ) - diff(payda, Yo  ) * tan(psiy));
A(1,  5) = (1 / payda) * ( diff(pay1, a2 ) - diff(payda, a2  ) * tan(psiy));
A(1,  6) = (1 / payda) * ( diff(pay1, b2 ) - diff(payda, b2  ) * tan(psiy));
A(1,  7) = (1 / payda) * ( diff(pay1, Zo ) - diff(payda, Zo  ) * tan(psiy));
A(1,  8) = (1 / payda) * ( diff(pay1, a3 ) - diff(payda, a3  ) * tan(psiy));
A(1,  9) = (1 / payda) * ( diff(pay1, b3 ) - diff(payda, b3  ) * tan(psiy));
A(1, 10) = (1 / payda) * ( diff(pay1, Vxo) - diff(payda, Vxo ) * tan(psiy));
A(1, 11) = (1 / payda) * ( diff(pay1, a4 ) - diff(payda, a4  ) * tan(psiy));
A(1, 12) = (1 / payda) * ( diff(pay1, b4 ) - diff(payda, b4  ) * tan(psiy));
A(1, 13) = (1 / payda) * ( diff(pay1, Vyo) - diff(payda, Vyo ) * tan(psiy));
A(1, 14) = (1 / payda) * ( diff(pay1, a5 ) - diff(payda, a5  ) * tan(psiy));
A(1, 15) = (1 / payda) * ( diff(pay1, b5 ) - diff(payda, b5  ) * tan(psiy));
A(1, 16) = (1 / payda) * ( diff(pay1, Vzo) - diff(payda, Vzo ) * tan(psiy));
A(1, 17) = (1 / payda) * ( diff(pay1, a6 ) - diff(payda, a6  ) * tan(psiy));
A(1, 18) = (1 / payda) * ( diff(pay1, b6 ) - diff(payda, b6  ) * tan(psiy));
A(1, 19) = (1 / payda) * ( diff(pay1, aro) - diff(payda, aro ) * tan(psiy));
A(1, 20) = (1 / payda) * ( diff(pay1, a7 ) - diff(payda, a7  ) * tan(psiy));
A(1, 21) = (1 / payda) * ( diff(pay1, b7 ) - diff(payda, b7  ) * tan(psiy));
A(1, 22) = (1 / payda) * ( diff(pay1, apo) - diff(payda, apo ) * tan(psiy));
A(1, 23) = (1 / payda) * ( diff(pay1, a8 ) - diff(payda, a8  ) * tan(psiy));
A(1, 24) = (1 / payda) * ( diff(pay1, b8 ) - diff(payda, b8  ) * tan(psiy));
A(1, 25) = (1 / payda) * ( diff(pay1, ayo) - diff(payda, ayo ) * tan(psiy));
A(1, 26) = (1 / payda) * ( diff(pay1, a9 ) - diff(payda, a9  ) * tan(psiy));
A(1, 27) = (1 / payda) * ( diff(pay1, b9 ) - diff(payda, b9  ) * tan(psiy));
A(1, 28) = (1 / payda) * ( diff(pay1, X  ) - diff(payda, X   ) * tan(psiy));
A(1, 29) = (1 / payda) * ( diff(pay1, Y  ) - diff(payda, Y   ) * tan(psiy));
A(1, 30) = (1 / payda) * ( diff(pay1, Z  ) - diff(payda, Z   ) * tan(psiy));                                      

A(2,  1) = (1 / payda) * ( diff(pay2, Xo ) + diff(payda, Xo  ) * tan(psix));
A(2,  2) = (1 / payda) * ( diff(pay2, a1 ) + diff(payda, a1  ) * tan(psix));
A(2,  3) = (1 / payda) * ( diff(pay2, b1 ) + diff(payda, b1  ) * tan(psix));
A(2,  4) = (1 / payda) * ( diff(pay2, Yo ) + diff(payda, Yo  ) * tan(psix));
A(2,  5) = (1 / payda) * ( diff(pay2, a2 ) + diff(payda, a2  ) * tan(psix));
A(2,  6) = (1 / payda) * ( diff(pay2, b2 ) + diff(payda, b2  ) * tan(psix));
A(2,  7) = (1 / payda) * ( diff(pay2, Zo ) + diff(payda, Zo  ) * tan(psix));
A(2,  8) = (1 / payda) * ( diff(pay2, a3 ) + diff(payda, a3  ) * tan(psix));
A(2,  9) = (1 / payda) * ( diff(pay2, b3 ) + diff(payda, b3  ) * tan(psix));
A(2, 10) = (1 / payda) * ( diff(pay2, Vxo) + diff(payda, Vxo ) * tan(psix));
A(2, 11) = (1 / payda) * ( diff(pay2, a4 ) + diff(payda, a4  ) * tan(psix));
A(2, 12) = (1 / payda) * ( diff(pay2, b4 ) + diff(payda, b4  ) * tan(psix));
A(2, 13) = (1 / payda) * ( diff(pay2, Vyo) + diff(payda, Vyo ) * tan(psix));
A(2, 14) = (1 / payda) * ( diff(pay2, a5 ) + diff(payda, a5  ) * tan(psix));
A(2, 15) = (1 / payda) * ( diff(pay2, b5 ) + diff(payda, b5  ) * tan(psix));
A(2, 16) = (1 / payda) * ( diff(pay2, Vzo) + diff(payda, Vzo ) * tan(psix));
A(2, 17) = (1 / payda) * ( diff(pay2, a6 ) + diff(payda, a6  ) * tan(psix));
A(2, 18) = (1 / payda) * ( diff(pay2, b6 ) + diff(payda, b6  ) * tan(psix));
A(2, 19) = (1 / payda) * ( diff(pay2, aro) + diff(payda, aro ) * tan(psix));
A(2, 20) = (1 / payda) * ( diff(pay2, a7 ) + diff(payda, a7  ) * tan(psix));
A(2, 21) = (1 / payda) * ( diff(pay2, b7 ) + diff(payda, b7  ) * tan(psix));
A(2, 22) = (1 / payda) * ( diff(pay2, apo) + diff(payda, apo ) * tan(psix));
A(2, 23) = (1 / payda) * ( diff(pay2, a8 ) + diff(payda, a8  ) * tan(psix));
A(2, 24) = (1 / payda) * ( diff(pay2, b8 ) + diff(payda, b8  ) * tan(psix));
A(2, 25) = (1 / payda) * ( diff(pay2, ayo) + diff(payda, ayo ) * tan(psix));
A(2, 26) = (1 / payda) * ( diff(pay2, a9 ) + diff(payda, a9  ) * tan(psix));
A(2, 27) = (1 / payda) * ( diff(pay2, b9 ) + diff(payda, b9  ) * tan(psix));
A(2, 28) = (1 / payda) * ( diff(pay2, X  ) + diff(payda, X   ) * tan(psix));
A(2, 29) = (1 / payda) * ( diff(pay2, Y  ) + diff(payda, Y   ) * tan(psix));
A(2, 30) = (1 / payda) * ( diff(pay2, Z  ) + diff(payda, Z   ) * tan(psix));

% B (1, 1) =   1 / (cos(psiy))^2;
% B (1, 2) = 0;
% B (2, 1) = 0;
% B (2, 2) = - 1 / (cos(psix))^2;

B (1, 1) = - ( 1 + (tan(psiy))^2);
B (1, 2) =     0;
B (2, 1) =     0;
B (2, 2) =     1 + (tan(psix))^2;

% A = Ainv * B;

display('FM bitti!');