%Arrangement approximate value matrix (n,m) into unknown vector (n*m)
%[Xo  a1 b1]      [Xo]
%[Yo  a2 b2]      [a1]
%[........ ] -->  [..]
%[ayo a9 b9]      [b9]
%Recoded by Hüseyin TOPAN (ZKÜ), August 2009

function unknwn = ap2unk(appval)

[strApp stnApp] = size(appval);

%===== Unknown vector from approximately unknown matrix [Xo a1 b1, Yo a2 b2, ...]' =====
unknwn = reshape(appval', strApp*stnApp, 1);