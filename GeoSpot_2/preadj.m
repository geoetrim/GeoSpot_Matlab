%Pre-adjustment of look angles and parameters
%A.x + B.v + w = 0

function [gcp1, gcp2, unknwn1, unknwn2, fid1] = preadj(gcp1, gcp2, appval1, appval2, Sc, Sp)

%===== Adjust parameter: ap = 1 =====
ap = 1;
if Sp == 0;
    ap = 0;
end

if ap == 1
    nj = 1;
else
    nj = 1;
end

%===== GCP - ICP separation =====
if Sc > 0
    [gcp11, icp1, fc] = fndicp(gcp1, Sc);
    [gcp22, icp2, fc] = fndicp(gcp2, Sc);
   else
    gcp11 = gcp1;
    gcp22 = gcp2;
    icp1 = [];
    icp2 = [];
end

[strApp stnApp] = size(appval1);

% See older versions for "Estimation XYZ from mono image using given look angles and parameters on GCPs"

display('===== Estimation XYZ from stereo images using given look angles and parameters on GCPs =====')
    estXYZ(gcp11, gcp22);
if Sc > 0
    display('===== Estimation XYZ from stereo images using given look angles and parameters on ICPs =====')
    estXYZ(icp1, icp2);
end
    
for j = 1 : nj
    
    if j == 1
        %===== approximately unknown matrix --> unknown vector =====
        unknwn1 = ap2unk(appval1);
        unknwn2 = ap2unk(appval2);
    end
    
    display('===== Pre-adjustment of look angles =====')
    display('-----------------------------------------')
    display('===== For 1st image =====')
    [gcp11, icp1] = adjv (gcp11, icp1, Sc);
    display('===== For 2nd image =====')
    [gcp22, icp2] = adjv (gcp22, icp2, Sc);
    
% See older versions for "Estimated XYZ from mono image with adjusted look angles and parameters for GCPs"
    
    if j == 1
        display('===== Estimation XYZ from stereo images using adjusted look angles for GCPs =====')
        fprintf('Iteration: %1d\n', j);
        estgr = calcXYZ(gcp11, gcp22);
        dg = gcp11(:, 4 : 6) - estgr;
    else
        display('===== Estimation XYZ from stereo images using adjusted look angles and parameters for GCPs =====')
        fprintf('Iteration: %1d\n', j);
        estgr = calcXYZ_u(unknwn1, unknwn2, gcp11, gcp22, strApp, stnApp);
        dg = gcp11(:, 4 : 6) - estgr;
    end
    
    for k = 1 : 3
        mg(k) = sqrt((dg(:, k)' * dg(:, k)) / (length(gcp11(:, 1))));
    end
    
    fprintf(' mX = +/- %10.3f (m)\n mY = +/- %10.3f (m)\n mZ = +/- %10.3f (m)\n\n', mg);
    
    if Sc > 0
% See older versions for "Estimated XYZ from mono image with adjusted look angles for ICPs"

        if j == 1
            display('===== Estimation XYZ from stereo images using adjusted look angles for ICPs =====')
            fprintf('Iteration: %1d\n', j);
            estgr = calcXYZ(icp1, icp2);
            dc = icp1(:, 4 : 6) - estgr;
        else
            display('===== Estimation XYZ from stereo images using adjusted look angles and parameters for ICPs =====')
            fprintf('Iteration: %1d\n', j);
            estgr = calcXYZ_u(unknwn1, unknwn2, icp1, icp2, strApp, stnApp);
            dc = icp1(:, 4 : 6) - estgr;
        end
        
        for k = 1 : 3
            mc(k) = sqrt((dc(:, k)' * dc(:, k)) / (length(icp1(:, 1))));
        end
        fprintf(' mX = +/- %10.3f (m)\n mY = +/- %10.3f (m)\n mZ = +/- %10.3f (m)\n\n', mc);
    end

    if ap == 1
        display('===== Pre-adjustment of parameters =====')
        display('----------------------------------------')
        display('===== For 1st image =====')
        [unknwn1, gcp11] = adjx(unknwn1, gcp11, strApp, stnApp, Sp);
        display('===== For 2nd image =====')
        [unknwn2, gcp22] = adjx(unknwn2, gcp22, strApp, stnApp, Sp);
% [unknwn2 gcp22]=[0 0];
    end
    
    fprintf(' Dongu sayisi = %2d\n', j);
    fprintf('========================================\n\n')

    %===== Plotting GCPs and ICPs =====
    if (j == 1) || (j == 3)
        if Sc > 0
            pltv_gc(gcp11, icp1, dg, dc, j);
        else
            pltv_g(gcp1, dg, j);
        end
    end
end

%===== Combination of GCPs and ICPs =====
gcp1 = [gcp11; icp1];
gcp1 = sortrows(gcp1, 1);

gcp2 = [gcp22; icp2];
gcp2 = sortrows(gcp2, 1);

%===== Writting into file =====
cikis = ('cikis.txt');
fid1 = fopen(cikis,'w+');
fprintf(fid1,' Results about pre-adjustment of look angles \n');
fprintf(fid1,' At GCPs \n');
fprintf(fid1,' mX = +/- %10.3f (m)\n mY = +/- %10.3f (m)\n mZ = +/- %10.3f (m)\n\n', mg);
if Sc > 0
    fprintf(fid1,' At ICPs \n');
    fprintf(fid1,' mX = +/- %10.3f (m)\n mY = +/- %10.3f (m)\n mZ = +/- %10.3f (m)\n\n', mc);
end
% if Sp == 0
%     fclose(fid1);
% end