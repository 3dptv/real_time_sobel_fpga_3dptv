%%

clear all
clc

% CHOOSE PARAMETERS:
close_method=2; % Figure closing method: 0-Dont close, 1-Open one then close one, 2 - Open all, then close all.
pause_time=0.1; % Pause Time (For "close_method=1")
pics_num_at_each_figure=1; % Number of images on each figure

% input of the first TXT file's serial number
first=input('Enter the serial number of the FIRST text file\n','s');
txt_file='00000000.txt';

% txt_file="000serial.txt"
txt_file(9-size(first,2):1:8)=first;

% check if the TXT file actually exists
existance=exist(txt_file,'file');

k=0;
m=0;

% Number of images on each figure
raws=fix(sqrt(pics_num_at_each_figure));
disp('Raws:.');
disp(raws);
columns=round(raws*1.25);
disp('Columns:.');
disp(columns);
pics_num_at_each_figure=raws*columns;

scrsz = get(0,'ScreenSize');

fig=0;
fig_count=0;

while existance==2          % while file exists
    if (mod(k,pics_num_at_each_figure)==0)            % if devides by PICS NUMBER, open a new window !
        fig=fig+1;
        m=0;
        if close_method==1
            if fig==2 pause(pause_time)
            end
            if fig>2
                fig_count=fig_count+1;
                if mod(fig_count,2)==0
                close(2)
                else close(1)
                end
                pause(pause_time)
                fig=2;
            end
        end
        if close_method==2 pause(pause_time)
        end
        figure('Position',[1 35 scrsz(3)-20 scrsz(4)-110])
    end
    m=m+1;
    k=k+1;
    a=load(txt_file);   % "a" recieves the content of the TXT file
    
    % Plotting the image
    subplot(raws,columns,m);
    plot(a(:,1),a(:,2),':ro','LineWidth',1,'MarkerEdgeColor','w','MarkerFaceColor','k','MarkerSize',5);
    axis ij
    axis equal
    axis ([0 1280 0 1024])
    title({txt_file,[num2str(size(a,1)),' Objects']},'Color','b');
    xlabel(max(a(:,1)));
    ylabel(max(a(:,2)));
    
    % Call the next file
    txt_file_serial_number=num2str(str2num(txt_file(1:8))+1);
    txt_file(9-size(txt_file_serial_number,2):1:8)=txt_file_serial_number;
    
   % check if the TXT file actually exists 
    existance=exist(txt_file,'file');
end

if close_method==2
    for i=1:(fig-1) close(i) 
    end
end

if k==0 disp('THE FIRST FILE WAS NOT FOUND !!!');
    disp('Please check again.');
else disp('Total number of files is');
    disp(k);
end

clear all