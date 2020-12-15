%Generation GCP and ICP files from given GCP file

function [gcp, icp, fc] = fndicp(gcp1, Sc)

%===== Line-number of check points =====
fc = fndchk (Sc, gcp1);

%===== Line-number of ground points =====
fg = [1 : length(gcp1)];
fg(:, fc)=[];

for i = 1 : (length(gcp1) - length(Sc))
    gcp(i, :) = gcp1(fg(i), :);
end

for i = 1 : length(Sc)
    icp(i, :) = gcp1(fc(i), :);
end