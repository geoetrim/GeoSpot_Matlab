 % Unknwons' function
 % Coded by Hüseyin TOPAN (ZKÜ), August 2009
 % Note: Differences between funk_12 and funk_u is that "punk" estimation is
 % included in funk_u.
 % Example:
 % punk = [Xo a1
 %         Yo a2
 %         .....]
 % p    = [a1 Xo
 %         a2 Yo
 %         .....]
 % unknwni(1) = Xs = Xo + a1 * x
 
function unknwni = funk_u(strApp, stnApp, unknwn, dx);

%===== Reordering unknown for parameter calc. =====
%[Xo a1 Yo a2 ...]' --> [Xo a1; Yo a2; ...]'
punk = reshape(unknwn, stnApp, strApp); 
punk = punk';

for k = 1 : strApp
    for t = 1 : stnApp
        p (k, t) = punk(k, 4 - t);
    end
    unknwni (k) = polyval( p(k , :) , dx);
end