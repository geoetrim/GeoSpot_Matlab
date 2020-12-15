%Loading of data (GCP, meta and Satellite Position and Velocity vectors)

function [gcp, meta, satpv, atti, lookang] = loading;

%===== Loading of GCP file ======
% gcpi= input('GCP file: ','s');
% gcp = load(gcpi);
gcp = load('spot5_1a_sag_wgs84_xyz_47.txt');
gcp = sortrows(gcp, 1); %GCPs are shorting according to their ID.

%===== Loading of Metadata file =====
% metai=input('Image metadata file: ','s');
% meta =load(metai);
meta = load('spot5_1a_sag_hdr.txt');

%===== Loading of Satellite Position and Velocity file =====
% satpvi = input('Satellite's Position and Velocity file: ','s');
% satpv  = load(satpvi);
satpv = load('spot5_1a_sag_sat_pos.txt');

%===== Loading of attitude angle file =====
% satpvi = input('Satellite's Position and Velocity file: ','s');
% satpv  = load(satpvi);
atti = load('spot5_1a_sag_attitude_angles_corrected.txt');

%===== Loading of look angle file =====
% lookang = input('Look angle file: ','s');
% lookang  = load(lookang);
lookang = load('spot5_1a_sag_look_angle.txt');