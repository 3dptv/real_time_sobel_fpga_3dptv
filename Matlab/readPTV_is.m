function [varargout] = readPTV_is(varargin)
%READPTV_IS *Insert a one line summary here*
%   [VARARGOUT] = READPTV_IS(VARARGIN)
%
%   inputs:
%      varargin  - *Insert description of input variable here*
%
%   outputs:
%      varargout  - *Insert description of output variable here*
%
%   example:
%
%   notes:
%
%   See also HELP 
%

% Created: 02-Oct-2003
% Author: Alex Liberzon 
% E-Mail : liberzon@tx.technion.ac.il 
% Phone : +972 (0)48 29 3861 
% Copyright (c) 2003 Technion - Israel Institute of Technology 
%
% Modified at: 02-Oct-2003
% $Revision: 1.0 $  $Date: 02-Oct-2003 13:27:15$ 

% Initialization
wd = cd;

% Pick up files for the analysis
[filename1, pathname] = uigetfile('ptv_is.*', 'Pick a FIRST PTV_IS file');
if isequal(filename1,0) | isequal(pathname,0)
    cd(wd); error('Wrong selection')
else
    cd(pathname)
    [filename2, pathname] = uigetfile('ptv_is.*', 'Pick a LAST PTV_IS file');
    if isequal(filename2,0) | isequal(pathname,0)
        cd(wd); error('Wrong selection')
    else
% Main code is  here
dot = 7; 
        firstIndx =  eval(filename1(dot+1:end));
        lastIndx =  eval(filename2(dot+1:end));
        baseName = filename1(1:dot-1);
         
        % The database is designed as a structure P with .x for coordinates
        % .pt for pointers and .t for absolute time
        p = struct('x',[],'pt',[],'t',[]);
        
        for i = firstIndx:lastIndx
                        runIndx = i-firstIndx+1; % running counter
% Read the file
data = textread([basename,int2str(i)]);
numRows = data(1); 
data = data(2:end,1:5);



p(i).x = data(:,3:5); % X - vector of 3D coordinates
% p(i).y = data(:,2);
% p(i).z = data(:,3);
p(i).pt = data(:,1:2); % pointers backward and forward
p(i).t = runIndx-1; % absolute time, starting from zero



    end
end
cd(wd);