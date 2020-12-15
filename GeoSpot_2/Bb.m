function B = Bb(psi)

psix = psi(:, 1);
psiy = psi(:, 2);

for i = 1 : length(psix)

% Orhan Hocanýn çözümüne göre
% B (2 * i - 1, 2 * i - 1) =   1 / (cos(psiy(i)))^2;
% B (2 * i,     2 * i)     = - 1 / (cos(psix(i)))^2;

B (2 * i - 1, 2 * i - 1) = - (1 + (tan(psiy(i)))^2);
B (2 * i,     2 * i)     =    1 + (tan(psix(i)))^2 ;

end