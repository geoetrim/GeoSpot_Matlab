%Loading of data (GCP, header, Satellite's Position and Velocity vectors, attitude angles, and look angles )

function [gcp, meta, satpv, atti, lookang] = loading;

%===== Loading of GCP file ======
% gcpi= input('GCP file: ','s');
% gcp = load(gcpi);
gcp = load('spot5_1a_sol_wgs84_xyz_47.txt');
gcp = sortrows(gcp, 1); %GCPs are shorting according to their ID.

%===== Loading of Metadata file =====
% metai=input('Image metadata file: ','s');
% meta =load(metai);
meta = load('spot5_1a_sol_hdr.txt');

%===== Loading of Satellite Position and Velocity file =====
% satpvi = input('Satellite's Position and Velocity file: ','s');
% satpv  = load(satpvi);
satpv = load('spot5_1a_sol_sat_pos.txt');

%===== Loading of attitude angle file (angles in radian) =====
% satpvi = input('Satellite's Position and Velocity file: ','s');
% satpv  = load(satpvi);
atti = load('spot5_1a_sol_attitude_angles_corrected.txt');

%===== Loading of look angle file (angles in radian) =====
% lookang = input('Look angle file: ','s');
% lookang  = load(lookang);
lookang = load('spot5_1a_sol_look_angle.txt');