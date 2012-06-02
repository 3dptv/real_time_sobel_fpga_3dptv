% txt2image_v3
% using plot_circle and poly2mask
% this is for the 4-image-splitter files.
% version 2, reads _targets (or newtxt)

sy = 1280;
sx = 1024;
Radius = 1; % small dots



plotoutput = false;
saveoutput = true;
% cd('sobel_2\txt');
% cd('sobel_070822/cal1');
directoryname = uigetdir('.');
curdir = cd;
addpath(curdir);
cd(directoryname);
if ~exist('img2','dir'), mkdir('img2'), end

% d = dir('*.txt');
d = dir('*.*_targets');

% f =  @(x) mean2(x);

if plotoutput, figure; end

for i = 1:length(d)
    [filepath,filename,fileext] = fileparts(d(i).name);
%     points = load(fullfile(filepath,d(i).name));
     fid = fopen(fullfile(filepath,d(i).name),'r');
     header = fgets(fid);
     tmp = textscan(fid,'%d %f %f %d %d %d %d %d');
     fclose(fid);
%     x = points(:,1); % 1280
%     y = points(:,2); % 1024
x = tmp{2};
y = tmp{3};
    bw = uint8(zeros(sx,sy));

tic
    for j = 1:length(x)
        output_coord = plot_circle(x(j),y(j),Radius);
        bw = imadd(bw,uint8(poly2mask(output_coord(:,1),output_coord(:,2),sx,sy)));
    end
toc

    bw(bw>0) = 255;
    % bw = flipud(bw);
    cam1 = bw;
%     cam2 = bw(1:ceil(sx/2),ceil(sy/2)+1:end);
%     cam3 = bw(ceil(sx/2)+1:end,1:ceil(sy/2));
%     cam4 = bw(ceil(sx/2)+1:end,ceil(sy/2)+1:end);


    if plotoutput
        imshow(cam1)
        drawnow
    end

    if saveoutput
        imwrite(cam1,['./img2/Cam1.', fileext(2:7)],'tiff','compression','none');
%         imwrite(cam3,['./img2/Cam2.',filename(4:end)],'tiff','compression','none');
%         imwrite(cam2,['./img2/Cam3.',filename(4:end)],'tiff','compression','none');
%         imwrite(cam4,['./img2/Cam4.',filename(4:end)],'tiff','compression','none');
    end
end
cd(curdir);