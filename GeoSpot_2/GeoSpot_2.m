%Geopositioning of SPOT-5 HRG Level 1A stereopairs
%Recoded and modified by Hüseyin TOPAN, Zonguldak Karaelmas University, August 2011, Zonguldak.
%Reference: Serger Riazanoff, 2004, SPOT 123-4-5 Geometry Handbook, issue 1 revision 4
%For more information: htopan[at]karaelmas.edu.tr, htopan[at]yahoo.com

clear; clc; close all
time1 = clock;
format longEng

display('Geopositioning of SPOT-5 HRG Level 1A Stereopairs, by Hüseyin TOPAN (BEÜ & 2013)')

% display('===== Loading and Preprocessing =====')
    %===== Loading of data =====
    [gcp, meta, satpv, atti, lookang] = loading1;
    %===== Preprocessing =====
    [appval1, gcp1] = prepro(gcp, meta, satpv, atti, lookang);

    %===== Loading of data =====
    [gcp, meta, satpv, atti, lookang] = loading2;
    %===== Preprocessing =====
    [appval2, gcp2] = prepro(gcp, meta, satpv, atti, lookang);
    
display('===== Parameters and check points =====')
[Sp Sc] = Spc;

display('===== Pre-adjustment =====')
    [gcp1, gcp2, unknwn1, unknwn2, file] = preadj(gcp1, gcp2, appval1, appval2, Sc, Sp);

display('===== Bundle Adjustment =====');
if (Sp == 0) & (Sc == 0)
    disperror(25)
    break
else
[gcp1 gcp2] = bndl (unknwn1, unknwn2, gcp1, gcp2, appval1, Sp, Sc, file);
end

% vakit(time1)