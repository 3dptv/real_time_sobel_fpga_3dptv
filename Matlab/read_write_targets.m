d = dir('*.*_targets');

for i = 1:length(d)
    disp(i)
    %      fid = fopen(d(i).name,'r');
    %      header = fgets(fid);
    %      tmp = textscan(fid,'%d %f %f %d %d %d %d %d');
    %      fclose(fid);
    importfile(d(i).name); % generates textdata and data
    outliers = data(:,2) > 1280 | data(:,3)>1024;
    data(outliers,:) = [];
%      data(:,3) = 1024 - data(:,3);
%     data(:,3) = data(:,3) + i;
    data(:,2:8) = sortrows(data(:,2:8),[2]);
    [junk,ind] = sort(data(:,2));
    data(ind,8)= 0:length(ind)-1;
    data(:,1) = 0:length(data(:,2))-1;
    data(:,2) = round(data(:,2)*2)/2;
    data(:,3) = round(data(:,3)*2)/2;
%     data(:,4) = 74;
%     data(:,5) = 10;
%     data(:,6) = 10;
%     data(:,7) = 16000;
    fid = fopen([d(i).name],'w');
    fprintf(fid,'%d\n',length(data(:,2)));
    % tmp = textscan(fid,'%d %f %f %d %d %d %d %d','HeaderLines',1);
    fprintf(fid,'%4d %9.4f %9.4f %5d %5d %5d %5d %5d\n',data');
    
    fclose(fid);
end
fclose all
