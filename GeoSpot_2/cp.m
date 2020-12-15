%Checking whether the point "i" is a check point.
%Coded by Hüseyin TOPAN (ZKÜ) July 2009 Zonguldak
% NN : Point ID
function c = cp_13 (NN, Sc)

c = 0;

for k = 1 : length(Sc)
    if Sc(k) == NN
        h(k) = 1;
    else h(k) = 0;
    end
end

c = sum(h);