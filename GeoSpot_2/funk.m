 % Unknwons' function
 % Coded by Hüseyin TOPAN (ZKÜ), August 2009
 % Example:
 % punk = [Xo a1
 %         Yo a2
 %         .....]
 % p    = [a1 Xo
 %         a2 Yo
 %         .....]
 % unknwni(1) = Xs = Xo + a1 * x
 
function unknwni = funk(str, stn, punk, dx);

for k = 1 : str
    for t = 1 : stn
        p (k, t) = punk(k, 4 - t);
    end
    unknwni (k) = polyval( p(k , :) , dx);
end