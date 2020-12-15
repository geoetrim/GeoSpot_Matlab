%Approximate XYZ calc. for the check/tie points
%Formulation by Serge Riazanoff, 2004
%Recoded by Hüseyin TOPAN (ZKÜ), August 2009

function gcp = calcXYZ(gcp1, gcp2)

for i = 1 : length(gcp1(:,1))  
    
    %===== for 1st image =====
    
    u11 (1) = - tan(gcp1(i, 19)); %psiy
    u11 (2) =   tan(gcp1(i, 18)); %psix
    u11 (3) = - 1;
    u1      =   u11' / norm(u11);
    
    RA1 = Ra (gcp1(i, 15 : 17));
    u12 = (RA1 * u1) / norm(RA1 * u1);
    
    RS1 = Rs (gcp1(i, 9 : 14));
    u13 = RS1 * u12;
      
    %===== for 2nd image =====    
    u21 (1) = - tan(gcp2(i, 19)); %psiy
    u21 (2) =   tan(gcp2(i, 18)); %psix
    u21 (3) = - 1;
    u2      =   u21' / norm(u21);
    
    RA2 = Ra (gcp2(i, 15 : 17));
    u22 = (RA2 * u2) / norm(RA2 * u2);
    
    RS2 = Rs (gcp2(i, 9 : 14));
    u23 = RS2 * u22;
     
    %===== Estimation of XYZ by Poli (2005), page 74 =====
    A = [u13, -u23];
    b = gcp2(i, 9 : 11) - gcp1(i, 9 : 11);
    b = b';

    m = inv(A' * A) * A' * b;

    gcp(i, :) = 1 / 2 * ((gcp1(i, 9 : 11)' + m(1) * u13) + (gcp2(i, 9 : 11)' + m(2) * u23));
    
%See older versions for "Estimation of XYZ by Kraus (1993), page 115"
end