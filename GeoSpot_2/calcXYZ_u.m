%Approximate XYZ calc. for the check/tie points
%Formulation by SPOT Image, SPOT Satellite Geometry Handbook
%Recoded by Hüseyin TOPAN (ZKÜ), August 2009

function gcp = calcXYZ_u (unknwn1, unknwn2, gcp1, gcp2, strApp, stnApp)

for i = 1 : length(gcp1(:,1))  

    %===== for 1st image =====
    unknwni1 = funk_u(strApp, stnApp, unknwn1, gcp1(i, 7)); %Unknowns's function
    
    u11 (1) = - tan(gcp1(i, 19)); %psiy
    u11 (2) =   tan(gcp1(i, 18)); %psix
    u11 (3) = - 1;
    u1      =   u11' / norm(u11);
    
    RA1 = Ra (unknwni1(7 : 9));
    u12 = (RA1 * u1) / norm(RA1 * u1);
    
    RS1 = Rs (unknwni1(1 : 6));
    u13 = RS1 * u12;
      
    %===== for 2nd image =====
    unknwni2 = funk_u(strApp, stnApp, unknwn2, gcp2(i, 7)); %Unknowns's function
    
    u21 (1) = - tan(gcp2(i, 19)); %psiy
    u21 (2) =   tan(gcp2(i, 18)); %psix
    u21 (3) = - 1;
    u2      =   u21' / norm(u21);
    
    RA2 = Ra (unknwni2(7 : 9));
    u22 = (RA2 * u2) / norm(RA2 * u2);
    
    RS2 = Rs (unknwni2(1 : 6));
    u23 = RS2 * u22;
     
    %===== Estimation of XYZ by Poli (2005), page 74 =====
    A = [u13, -u23];
    b = gcp2(i, 9 : 11) - gcp1(i, 9 : 11);
    b = b';

    m = inv(A' * A) * A' * b;

    gcp(i, :) = 1 / 2 * ((gcp1(i, 9 : 11)' + m(1) * u13) + (gcp2(i, 9 : 11)' + m(2) * u23));
    
%     %===== Estimation of XYZ by Kraus (1993), page 115 =====
%     kx1 = u13(1) / u13(3);
%     ky1 = u13(2) / u13(3);
%     
%     kx2 = u23(1) / u23(3);
%     ky2 = u23(2) / u23(3);
    
%     %===== Estimation Z =====
%     gcp(i, 3) = (gcp2(i, 9) - gcp2(i, 11) * kx2 + gcp1(i, 11) * kx1 - gcp1(i, 9)) / (kx1 - kx2);
%     
%     %===== Estimation X =====
%     X1 = gcp1(i, 9) + (gcp(i, 3) - gcp1(i, 11)) * kx1;
%     X2 = gcp2(i, 9) + (gcp(i, 3) - gcp2(i, 11)) * kx2;
%     
%     gcp(i, 1) = (X1 + X2) / 2;
%     
%     %===== Estimation Y =====
%     Y1 = gcp1(i, 10) + (gcp(i, 3) - gcp1(i, 11)) * ky1;
%     Y2 = gcp2(i, 10) + (gcp(i, 3) - gcp2(i, 11)) * ky2;
%     
%     
%     gcp(i, 2) = (Y1 + Y2) / 2;
end