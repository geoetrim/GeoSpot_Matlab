% Adjustment of look angles for SPOT-5 HRG level 1A images
% Coded by Hüseyin TOPAN (ZKÜ), July 2009

function [gcp, icp] = adjv(gcp, icp, Sc)

%===== D E F I N A T I O N S =====

roD = 180 /pi;

%===== Number of iteration =====
nj = 1E3;

%===== Threshold definition =====
ths = 0.1 / (roD * 3600); %i.e. 1"

%===== I T E R A T I O N =====
for j = 1 : nj
    
    %===== Adjustment for GCPs =====
    %===== Absolute term vectors ===
    w = atv_p(gcp, 0);
       
    %===== Design matrix =====
    B = Bb (gcp(:,18 : 19));
    
    %===== Correlates =====
    k = - inv (B * B') * w;
    
    %===== Residuals =====
    v = B' * k;
    
    for i = 1 : length(gcp(:, 1))
        vpsix(i) = v(2 * i);
        vpsiy(i) = v(2 * i - 1);
    end
    
    %===== Correction of look angles =====
    gcp(:, 18) = gcp(:, 18) + vpsix';
    gcp(:, 19) = gcp(:, 19) + vpsiy';
    
    %===== RMSE =====
    mpsix = sqrt ((vpsix * vpsix') / length(vpsix));
    mpsiy = sqrt ((vpsiy * vpsiy') / length(vpsiy));
    
    %===== Checking =====
    f = atv_p(gcp, 0);
    
    %===== Display =====
    fprintf('===== Results for GCPs =====\n');
    fprintf('mpsix = %15.3f (degree)\n',  mpsix * roD);
    fprintf('mpsiy = %15.3f (degree)\n',  mpsiy * roD);
    fprintf('Difference = %10.3f\n', max(abs(f)));
    fprintf('Iteration =         %3d\n', j);
    fprintf('==================================\n');
        
    if max(abs(f)) < ths
        endthr(26)
        break
    end
end

%===== Correction of look angles of ICPs =====
if Sc > 0
    for k = 1 : 2
        polylook(k, :) = appvalue_y(gcp, k); % 2nd order poly.
    end
    
    [str, stn] = size(polylook);
    
    for i = 1 : length(Sc)
        icp(i, 18 : 19) = funk(str, stn, polylook, icp(i, 8));
    end
end