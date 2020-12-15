% Superimposing line plots on an existing plot
n = [47 27 7];

x = [0.984 1.006 0.973
0.196 0.213 0.242
1.370 1.405 1.575
];

y = [0 4.834 6.599
0 5.378 7.054
0 5.540 5.735
];

set(gca, 'XColor', 'black', 'YColor', 'black');
xlabel('# GCP');
ylabel('RMSE');

plot(n, x (1 , :), 'k-o', 'MarkerFaceColor', [0 0 0]);
set(gca, 'XDir', 'reverse', 'YDir', 'normal');
hold on
plot(n, x (2 , :), 'k-s', 'MarkerFaceColor', [0 0 0]);
hold on
plot(n, x (3 , :), 'k-d', 'MarkerFaceColor', [0 0 0]);
%legend('mx GCP', 'my', 'mz')

hold on
plot(n (2 : 3), y (1, 2 : 3), 'k:o', 'MarkerFaceColor', [1 1 1]);
hold on
plot(n (2 : 3), y (2, 2 : 3), 'k:s', 'MarkerFaceColor', [1 1 1]);
hold on
plot(n (2 : 3), y (3, 2 : 3), 'k:d', 'MarkerFaceColor', [1 1 1]);