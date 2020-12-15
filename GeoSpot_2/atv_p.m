% Estimation misclosure vector (w)
% Recoded by Hüseyin TOPAN (ZKÜ), July 2009

function w = atv_p(gcp, Sc)

for i = 1 : length(gcp(:, 1))
    
    %===== Rotation matrixes =====
    RS = Rs (gcp(i, 9 : 14));
    RS = RS';
    RA = Ra (gcp(i, 15 : 17));
    RA = RA';
    R  = RA * RS;
    
    %===== XYZi - XYZs =====
    %===== Checking whether point is a check point =====
    if Sc == 0
        c = 0;
    else c = cp (gcp(i, 1), Sc);
    end
    
    if c == 1 %i.e. if point is a check point
        ki = 19;
        else ki = 3;
    end
    
    for k = 1 : 3
        DX(k) = gcp(i, k + ki) - gcp(i, k + 8);
    end
    
    for k = 1 : 3
        for t = 1 : 3
            xyi(t) = R(k , t) * DX(t);
        end
        xy(k) = sum(xyi);
    end
    
    %Kapanmalar
    w(2 * i - 1) = (xy(1) / xy(3)) - tan(gcp(i, 19));   
    w(2 * i)     = (xy(2) / xy(3)) + tan(gcp(i, 18));
end

w = w';