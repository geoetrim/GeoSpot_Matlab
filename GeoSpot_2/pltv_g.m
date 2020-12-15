%Plot residuals of GCPs from stereo images using given look angles and parameters
%dg in pixel unit

function plt_g(gcp, dg, j)
figure

hold on

olc = 3E3;

nn1 = int2str(gcp(:, 1));

% m --> pixel
p = 5;
dg = dg / p;

box on
set(gca,'XGrid','off','YGrid','off');                                                                                                                                                                            
set(gca,'XDir','normal','YDir','reverse');
set(gca,'XColor','black','YColor','black');
set(gca,'FontSize',14);
set(gca,'DataAspectRatio',[1 1 1]);

if j == 1
    title('Residuals of estimated XYZ from stereo image with adjusted look angles for GCPs');
elseif j == 3
    title('Residuals of estimated XYZ from stereo image with adjusted look angles and parameters for GCPs');
else
    title('Residuals of GCPs after bundle adjustment');
end

xlabel('y (pixel)','FontSize',16);
ylabel('x (pixel)','FontSize',16);

% ylim([0 12000]);
% xlim([0 12000]);

%===== Plotting for GCPs =====
hndl1 = quiver(gcp(:, 3), gcp(:, 2), olc * dg(:, 1), olc * dg(:, 2), 0, 'o');
set(hndl1,'MarkerSize',3);
set(hndl1,'Color','black');
set(hndl1,'LineWidth',1.5);

hndl2 = quiver(gcp(:, 3), gcp(:, 2), 0   * dg(:, 1), olc * dg(:, 3), 0, 'o');
set(hndl2,'MarkerSize',3);
set(hndl2,'Color','black');
set(hndl2,'LineWidth',1.5);

%--------------------------

hndl5 = quiver(500, 500, olc / p, 0, 0, 'o');
set(hndl5,'LineWidth',1.5);
set(hndl5,'MarkerSize',1.5);
set(hndl5,'Color','black');
text(600 + olc / p, 500,' 1 m', 'FontSize',15);