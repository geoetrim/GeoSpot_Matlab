% Design matrix for EOPs
% Calculates A matrix for all EOPs, and re-arranges it for selected EOPs
%
% Please check the version of the desing matrix (dm).
% Recoded by Hüseyin TOPAN (ZKÜ), July 2009.

function A = A_EOP(Sp, unknwn, gcp)

for i = 1 : length(gcp(:, 1))   
    
    %===== Desing matrix related to all EOPs =====
    A1 = dmEOP(unknwn, gcp(i, :));
    
    %===== Re-arrangement A considering Sp =====
    for g = 1 : 2
        for k = 1 : length(Sp)
            A2(g, k) = A1(g, Sp(k));
        end
    end
    
    A(2*i-1,:) = A2(1,:);
    A(2*i,  :) = A2(2,:);
end