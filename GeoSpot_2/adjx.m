% Adjustment of parameters for each mono image using only GCPs
% Coded by Hüseyin TOPAN (ZKÜ), July 2009

function [unknwn, gcp] = adjx(unknwn, gcp, strApp, stnApp, Sp)

%===== D E F I N A T I O N S =====
%===== Number of iteration =====
nj = 1E3;

%===== Threshold definition =====
if Sp(1) < 19
    ts = 10;
elseif Sp(1) > 18
    ts = 10 / (180 * 3600 / pi); %i.e. 10"
end

%===== I T E R A T I O N =====
for j = 1 : nj
    
    if j == 1    
    %===== Absolute term vectors =====
    w = atv_p(gcp, 0);
    else
        %===== Absolute term vectors =====
        w = atv(unknwn, gcp, 0, strApp, stnApp);
    end
       
    %===== Design matrix =====
    A = A_EOP(Sp, unknwn, gcp);
    [S V D] = svd(A' * A);
    assignin('base', 'Vsvd', V)
    
    %===== Calculation of dx =====
    [mm nn] = size(A' * A);
    eig(A' * A)
    pause
    lamda = input('lamda= ');
    
    dx = -pinv(A' * A + lamda * eye(mm , nn)) * A' * w;
    
    %===== Correction =====
    for k = 1 : length(Sp)
        unknwn(Sp(k)) = unknwn(Sp(k)) + dx(k);
    end

    %===== Checking =====
    f = atv(unknwn, gcp, 0, strApp, stnApp);

    fprintf('Difference = %10.3f\n', max(abs(f)));

    %===== Termination =====
    %===== Linear dependency =====
    if rank(A) < length(dx);
        disperror(26);
        fprintf(' Rank of A:          %5d\n Number of unknowns: %5d\n', rank(A), length(dx));
        fprintf('-------------------------\n\n');
        break 
    end

    %===== Termination by the threshold =====
    if max(abs(dx)) <= ts
        endthr(24)
        break
    end
    fprintf(' Iteration number: %3d\n',j);
    fprintf(' Rank of A:         %2d\n', rank(A));
    fprintf(' ---------------------\n\n');
end