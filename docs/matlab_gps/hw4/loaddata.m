function ephemeris = loaddata()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Josh Wildey
%  Class: AAE57500
%  Homework 4 - 12/2/2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('igr11382.sp3');
test = 1;
cnt = 1;
while test
    tline = fgetl(fid);
    test = ~strcmp(tline,'EOF');
    if strcmp(tline(1),'P')
        sscanf(tline,'P %d %f %f %f %f',[sv x y z t])
    end
    cnt = cnt +1;
end
