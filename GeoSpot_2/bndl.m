% Block adjustment for SPOT-5 HRG stereoimages
% A.x + B.v + w = 0
% Coded by Hüseyin TOPAN (ZKÜ), September 2009

function [gcp1 gcp2] = bndl(unknwn1, unknwn2, gcp1, gcp2, appval1, Sp, Sc, fid1)

%===== D E F I N A T I O N S =====
%===== Number of iteration =====
nj = 1;

if nj == 1
    display(' Attention! Total iteration: 1')
end

if Sp == 0
    lsp =  0;
else
    lsp = length(Sp);
end

%===== Threshold definition =====
if Sc > 0
    ts = 10;
elseif Sp(1) < 19
    ts = 5;
elseif Sp(1) > 18
    ts = 0 / (180 * 3600 / pi); %i.e. 10"
end

ths = 10 / (180 * 3600 / pi); %i.e. 10"

%===== Finding line-number of check point =====
fc = fndchk (Sc, gcp1);

[strApp stnApp] = size(appval1);
    
%===== I T E R A T I O N =====
for j = 1 : nj
    
    fprintf(' Bundle Adj. Iteration: %5d \n',j)
    display(' ============================= ')
    
    if j == 1
    %===== Calculation ~XYZ =====
    gcp1(:, 20 : 22) = calcXYZ(gcp1, gcp2);
    gcp2(:, 20 : 22) = gcp1(:, 20 : 22);
    
    %===== Absolute term vectors =====
    w1 = atv_p(gcp1, Sc);
    w2 = atv_p(gcp2, Sc);
    else
        %===== Absolute term vectors =====
        w1 = atv_18(unknwn1, gcp1, Sc, strApp, stnApp);
        w2 = atv_18(unknwn2, gcp2, Sc, strApp, stnApp);
    end
    w = [w1 ; w2];
    
    %===== Design matrix of EOPs =====
    if Sp > 0
        AEOP1 = A_EOP_u(Sp, Sc, unknwn1, gcp1); %using 1st image
        AEOP2 = A_EOP_u(Sp, Sc, unknwn2, gcp2); %using 2nd image

        AEOP = [AEOP1              zeros(size(AEOP1));
                zeros(size(AEOP1)) AEOP2            ];
    end
    
    if Sc > 0
        %===== Design matrix of dXYZ =====
        AXYZ1 = A_dXYZ(unknwn1, gcp1, fc);
        AXYZ2 = A_dXYZ(unknwn2, gcp2, fc);
    
        AXYZ  = [AXYZ1; AXYZ2];
    end
    
    if (min(Sp) > 0) & (min(Sc) == 0)
        A = AEOP;
    elseif (min(Sp) == 0) & (min(Sc) > 0)
        A = AXYZ;
    elseif (min(Sp) > 0) & (min(Sc) > 0)
        A = [AEOP AXYZ];
    end
    rank(A)
    if Sp > 0; assignin('base', 'AEOP', AEOP); end
    
    assignin('base', 'AXYZ', AXYZ);

    %===== Design matrix of look angles =====
    B1 = Bb(gcp1(:, 18 : 19));
    B2 = Bb(gcp2(:, 18 : 19));
    
    B = [B1                zeros(size(B1));
         zeros(size(B1))   B2            ];
    
    %===== Calculation of dx, k, v =====
    [mm nn] = size(A' * inv(B * B') * A);
    
    eig(AEOP' * AEOP)
    pause
    lamda = input('lamda: ');
%     assignin('base','lamda',lamda)
    
    dx  = - pinv(A' * inv(B * B') * A + lamda * eye(mm , nn)) * A' * inv(B * B') * w;
    size(dx);
   
    Qxx =  inv(A' * inv(B * B') * A);
    size(Qxx);
    
    korlp = Qlv(A, B, Qxx);
    
    k = - inv(B * B') * (A * dx + w);
    
    v = B' * k;
    
    %===== Correction of EOPs =====
    if Sp > 0
        for k = 1 : lsp
            subunknwn1 (k) = unknwn1(Sp(k));
            subunknwn2 (k) = unknwn2(Sp(k));
        end
    
        tunknwn1 = [subunknwn1'; subunknwn2'];
        tunknwn2 = tunknwn1 + dx(1 : 2 * lsp);
    
        %===== Corrected EOPs are reloaded =====
        for k = 1 : lsp
            unknwn1(Sp(k)) = tunknwn2(k);
            unknwn2(Sp(k)) = tunknwn2(lsp + k);
        end
    end
    
    %===== Correction of look angles =====
    for i = 1 : length(gcp1(:,1))
        gcp1(i, 18) = gcp1(i, 18) + v(2 * i);      %vpsix
        gcp1(i, 19) = gcp1(i, 19) + v(2 * i - 1);  %vpsiy
        
        gcp2(i, 18) = gcp2(i, 18) + v(2 * (i + length(gcp2(:,1))));      %vpsix
        gcp2(i, 19) = gcp2(i, 19) + v(2 * (i + length(gcp2(:,1))) - 1);  %vpsiy
    end
    
    %===== Calculation of dg on GCPs =====
    if Sc > 0
        [gcp11, icp1, fc] = fndicp(gcp1, Sc);
        [gcp22, icp2, fc] = fndicp(gcp2, Sc);
        else
        gcp11 = gcp1;
        gcp22 = gcp2;
    end
        estgr = calcXYZ_u(unknwn1, unknwn2, gcp11, gcp22, strApp, stnApp);
        dg = gcp11(:, 4 : 6) - estgr;
        for k = 1 : 3
            mg(k) = sqrt((dg(:, k)' * dg(:, k)) / length(gcp11(:, 1)));
        end
        
        fprintf(fid1,' Results about bundle adjustment for GCPs\n');
        fprintf(fid1,' mX = +/- %15.3f (m)\n mY = +/- %15.3f (m)\n mZ = +/- %15.3f (m)\n\n', mg');
        
    if Sc > 0
        %===== Correction of ~XYZ =====
        dxc = reshape(dx(2 * lsp + 1 : length(dx)), 3, length(Sc));
        dxc = dxc';

        for k = 1 : length(fc)
            gcp1(fc(k), 20 : 22) = gcp1(fc(k), 20 : 22) + dxc(k, :);
        end
        gcp2(:, 20 : 22) = gcp1(:, 20 : 22);

        %===== Calculation of dc on check points =====
        for  k = 1 : length(fc)
            dc(k, :) = gcp1(fc(k), 4 : 6) - gcp1(fc(k), 20 : 22);
        end

        for k = 1 : 3
            mc(k) = sqrt((dc(:, k)' * dc(:, k)) / length(Sc));
        end
        
        fprintf(fid1,' Results about bundle adjustment for ICPs\n');
        fprintf(fid1,' mX = +/- %15.3f (m)\n mY = +/- %15.3f (m)\n mZ = +/- %15.3f (m)\n', mc');
    end
    
    if Sp > 0
        %===== Parameter validation =====
        [tsnc, kor] = par_valid(A, v, dx, Qxx, Sc);
    end
    
    %===== Checking =====
    f1 = atv(unknwn1, gcp1, 0, strApp, stnApp);
    f2 = atv(unknwn2, gcp2, 0, strApp, stnApp);
    f = [f1; f2];
    
    fprintf('Difference = %10.3f "\n', max(abs(f)) * (180 * 3600 / pi));
    
    %===== Program's termination =====
    %===== Termination by checking =====
    if max(abs(f)) < ths
        endthr(26)
        break
    end

    %===== Termination by linear dependency =====
    if rank(A) < length(dx)
        disperror(26);
        fprintf(' Rank of A:        %5d\n Number of unknowns: %5d\n', rank(A), length(dx));
        fprintf('-------------------------\n\n');
        break 
    end
    
%     %===== Termination by rmse of check points =====
%     if Sc > 0
%         if abs(max(mc)) <= ts
%             endthr()
%             break
%         end
%     elseif abs(max(dx)) <= ts
%         endthr()
%         break
%     end
    
    fprintf(' Iteration number: %3d\n', j);
    fprintf(' ---------------------\n\n');
end

%===== Plotting =====
% GCP - ICP separation
if Sc > 0
    pltv_gc(gcp11, icp1, dg, dc, 0);  
else
    pltv_g(gcp1, dg, 0);
end

% %===== Clossing file =====
fclose(fid1);