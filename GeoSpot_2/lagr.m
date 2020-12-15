%LAGRANGE INTERPOLATION
%Recoded by Hüseyin TOPAN, Zonguldak Karaelmas University, Zonguldak,
%Turkey, 3th April 2008
%Source: SPOT Satellite Geometry Handbook, 2002. Reference S-NT-73-12-SI, Edition 1, Revision 0,
%Date 2002-01-15. 
%http://www.cayenne.ird.fr/laboratoires/teledetection/BDSIG/Spot_Handbook.p
%df, Page 27
%Checked by Nümerik Analiz, Doç.Dr. Nurettin UMURKAN, YTU, Turkey.
function P2 = lagr(t, P, tg)

for j = 1 : length(t)
    for i = 1 : length(t)
        if i == j
            tn(i) = 1;
            td(i) = 1;
        else
        tn(i) = tg  - t(i);
        td(i) = t(j)- t(i);
        end
        tn2 = prod(tn');
        td2 = prod(td');
        Pt  = P(j) * tn2 / td2;
    end
    Pt2(j) = Pt;
end
    P2 = sum(Pt2);