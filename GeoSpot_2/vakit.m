function vakit(time1)

time2 = clock;

t1 = hms2s(time1(4 : 6));
t2 = hms2s(time2(4 : 6));

dt = t2 - t1;

fprintf('Son iþlem zamaný: Yýl  Ay   Gün  Saat  Dakika Saniye\n');
fprintf('                 ----  ---  ---  ----  ------ ------\n');
fprintf('                 %4d  %2d    %2d   %2d     %2d     %2.1f\n\n',time2);

fprintf('Toplam iþlem zamaný: %5.1f sn\n\n', dt);