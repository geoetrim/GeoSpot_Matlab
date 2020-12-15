%Hour + Minute + second = second

function s = hms2s(t)

s = t(:, 1) * 3600 + t(:, 2) * 60 + t(:, 3);