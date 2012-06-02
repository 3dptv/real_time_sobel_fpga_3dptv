function data = readXUAPFiles(directory)
% DATA = READXUAPFILES(DIRECTORY) reads all the data from the xuap.* files
% in the directory (DIRECTORY) into a structure DATA. 
% DATA has the following fields:
% DATA.prev, DATA.next, DATA.xr, DATA.yr, DATA.zr, 
% DATA.xf,yf,zf,uf,vf,wf,axf,ayf,azf
%{
The output is in two kinds of files. For each ptv_is.* there will be a xuap.* 
containing column by column the following (r=raw, f=filtered):
link_past, link_future, x_r,y_r,z_r,x_f,y_f,z_f,u_f,v_f,w_f,ax_f,ay_f,az_f,sucessfull
%}

if ~nargin, 
    directory = cd; 
end

wd = cd;
cd(directory);
d = dir('xuap.*');

for i = 1:length(d)
    tmp = textread(d(i).name);
    data(i).prev = tmp(:,1);
    data(i).next = tmp(:,2);
    data(i).xr = tmp(:,3);
    data(i).yr = tmp(:,4);
    data(i).zr = tmp(:,5);
    %
    data(i).xf = tmp(:,6);
    data(i).yf = tmp(:,7);
    data(i).zf = tmp(:,8);
    %
    data(i).uf = tmp(:,9);
    data(i).vf = tmp(:,10);
    data(i).wf = tmp(:,11);
    %
    data(i).axf = tmp(:,12);
    data(i).ayf = tmp(:,13);
    data(i).azf = tmp(:,14);
    clear tmp
    %
end
cd(wd);
return