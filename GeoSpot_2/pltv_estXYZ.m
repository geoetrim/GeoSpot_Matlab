%Plot residuals of GCPs from stereo images using given look angles and parameters
%d in pixel unit

function plt_estXYZ(gcp, d)
figure

hold on

olc = input('Scale: ');

% m --> pixel
p = 5;
d = d / p;

nn1 = int2str(gcp(:, 1));

box on
set(gca,'XGrid','off','YGrid','off');                                                                                                                                                                            
set(gca,'XDir','normal','YDir','reverse');
set(gca,'XColor','black','YColor','black');
set(gca,'FontSize',14);
set(gca,'DataAspectRatio',[1 1 1]);
title('Residuals of GCPs from stereo images using given look angles and parameters');

xlabel('y (pixel)','FontSize',16);
ylabel('x (pixel)','FontSize',16);

% ylim([0 12000]);
% xlim([0 12000]);

hndl1 = quiver(gcp(:, 3), gcp(:, 2), olc * d(:, 1), olc * d(:, 2), 0, 'o');
set(hndl1,'MarkerSize',1.5);
set(hndl1,'Color','black');
set(hndl1,'LineWidth',1.5);

hndl2 = quiver(gcp(:, 3), gcp(:, 2), 0   * d(:, 1), olc * d(:, 3), 0, 'o');
set(hndl2,'MarkerSize',1.5);
set(hndl2,'Color','black');
set(hndl2,'LineWidth',1.5);

% hndl3 = quiver(min(gcp(:,3)), min(gcp(:,2)) + 500, 750, 0, 0, 'o');
hndl3 = quiver(300, 0, 200 * olc, 0, 0, 'o');
set(hndl3,'LineWidth',1.5);
set(hndl3,'MarkerSize',1.5);
set(hndl3,'Color','black');
text(750, 0,' 1000 m', 'FontSize',15);