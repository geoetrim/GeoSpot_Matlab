%Plot residuals of GCPs from stereo images using given look angles and parameters
%d in pixel unit

function plt_gc(gcp, icp, dg, dc, j)
figure

hold on

o2 = 1;

olc = 3e3 / o2;

if o2 > 1
    olc2 = olc;
else
    olc2 = olc / 10 ;
end

nn1 = int2str(gcp(:, 1));

p = 5; %1 pixel = 5 m for SPOT-5 HRG level 1A
dg = dg / p;
dc = dc / p;

box on
set(gca,'XGrid','off','YGrid','off');                                                                                                                                                                            
set(gca,'XDir','normal','YDir','reverse');
set(gca,'XColor','black','YColor','black');
set(gca,'FontSize',14);
set(gca,'DataAspectRatio',[1 1 1]);

if j == 1
    title('Residuals of estimated XYZ from stereo image with adjusted look angles for GCPs and ICPs');
elseif j == 3
    title('Residuals of estimated XYZ from stereo image with adjusted look angles and parameters for GCPs and ICPs');
else
    title('Residuals of GCPs and ICPs after bundle adjustment');
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

hold on

%===== Plotting for ICPs =====
hndl3 = quiver(icp(:, 3), icp(:, 2), olc2 * dc(:, 1), olc2 * dc(:, 2), 0, 'o');
set(hndl3,'MarkerSize',6);
set(hndl3,'Color','black');
set(hndl3,'LineWidth',1.5);

hndl4 = quiver(icp(:, 3), icp(:, 2), 0   * dc(:, 1), olc2 * dc(:, 3), 0, 'o');
set(hndl4,'MarkerSize',6);
set(hndl4,'Color','black');
set(hndl4,'LineWidth',1.5);

%===== Scale plotting =====
hndl5 = quiver(500, 500,   o2 * olc / p, 0, 0, 'o');
set(hndl5,'LineWidth',1.5);
set(hndl5,'MarkerSize',1.5);
set(hndl5,'Color','black');
text(600 +  o2 * olc / p, 500,' 1 m for GCPs', 'FontSize',15);

hndl6 = quiver(500, 1500,  o2 * olc / p, 0, 0, 'o');
set(hndl6,'LineWidth',1.5);
set(hndl6,'MarkerSize',6);
set(hndl6,'Color','black');
text(600 +  o2 * olc / p, 1500,' 10 m for ICPs', 'FontSize',15);