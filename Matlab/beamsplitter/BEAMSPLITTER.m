%{
Copyright (c) 2010, Mark Kreizer
Copyright (c) 2010, Alex Liberzon, Turbulence Structure Laboratory
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are 
met:

    * Redistributions of source code must retain the above copyright 
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright 
      notice, this list of conditions and the following disclaimer in 
      the documentation and/or other materials provided with the distribution
      
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
POSSIBILITY OF SUCH DAMAGE.
%}

clear all
close all
clc
tic
%%  Inputs
splitter_type=2; % "1" for Mark's design ; "2" - for Zurich-pyramid design

% Field Of View angle [degrees]
fov = 16;

% the following sizes in [mm]
size_target=100; % Target's width

% Distances [mm]
distance_target=600;  % Camera-Target distance
distance_beamsplitter_tip=215; % Camera-Pyramid's head-tip distance

alpha_ramp = 18 ; % Splitter's angle

%% Main equations set - initial guess values
distance_splitter_2_rear_mirrors=200; %Initial Guess
distance_target_2_rear_mirrors=700; %Initial Guess
practical_offset_ratio=100; % change this value to affect "diagonal_deviation_in_percents"

%%
alpha_VC=find_alpha_VC(alpha_ramp);
find_solution(fov,distance_target,size_target,distance_beamsplitter_tip,alpha_ramp,distance_splitter_2_rear_mirrors,distance_target_2_rear_mirrors,alpha_VC,practical_offset_ratio,splitter_type);
toc