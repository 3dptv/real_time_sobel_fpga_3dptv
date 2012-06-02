function [step_height,base_length,ramp_location] = splitter_dimmensions_zurich_pyramid(alpha_ramp,distance_beamsplitter_tip,fov)
syms step_height base_length
eq_a=step_height-base_length/sqrt(2)*tan(alpha_ramp);
eq_b=(distance_beamsplitter_tip+step_height)*tan(fov/2)-base_length/sqrt(2);
ans_a=solve(eq_a,eq_b);
clear eq_a eq_b
step_height = sym2poly(ans_a.step_height);
base_length = sym2poly(ans_a.base_length);

ramp_location.highest = [ 0 , 0 , - distance_beamsplitter_tip ] ; % Pyramid's head-tip location
ramp_location.deepest=[-base_length/2,-base_length/2,-(distance_beamsplitter_tip+step_height)];
ramp_location.middle_height=[-base_length/2,0,-(distance_beamsplitter_tip+step_height/2)];
ramp_location.vector1=ramp_location.deepest-ramp_location.highest;
ramp_location.vector1=ramp_location.vector1/norm(ramp_location.vector1);
ramp_location.vector2=ramp_location.middle_height-ramp_location.highest;
ramp_location.vector2=ramp_location.vector2/norm(ramp_location.vector2);
ramp_location.normal=cross(ramp_location.vector2,ramp_location.vector1);