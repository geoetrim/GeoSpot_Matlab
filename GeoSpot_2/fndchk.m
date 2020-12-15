%Finding the line-number of check point
%Example gcp: point ID, Sc: check point ID
%gcp = [23 56 78 90 67 27]'
%Sc  = [56 78 67]
%fc  = [2 3 5]
%Coded by Hüseyin TOPAN (ZKÜ) July 2009

function fc = fndchk (Sc, gcp)

if Sc == 0
    fc = 0;
else
    for i = 1 : length(Sc)
        for j = 1 : length(gcp)
            if Sc(i) == gcp(j)
                fc(i) = j;
            end
        end
    end
end