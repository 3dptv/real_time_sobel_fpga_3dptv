function []=draw_beamsplitter_mark(ramp_location,base_length,step_height)
z_peak=ramp_location.highest(3);
color='k';

front.a=[0,base_length/2,z_peak];
front.b=[base_length/2,0,z_peak];
front.c=[0,-base_length/2,z_peak];
front.d=[-base_length/2,0,z_peak];
front.e=[0,0,z_peak];

back.a=[-base_length/2,base_length/2,z_peak-step_height];
back.b=[0,base_length/2,z_peak-step_height];
back.c=[base_length/2,base_length/2,z_peak-step_height];
back.d=[base_length/2,0,z_peak-step_height];
back.e=[base_length/2,-base_length/2,z_peak-step_height];
back.f=[0,-base_length/2,z_peak-step_height];
back.g=[-base_length/2,-base_length/2,z_peak-step_height];
back.h=[-base_length/2,0,z_peak-step_height];

draw(back.a,back.c,color)
draw(back.c,back.e,color)
draw(back.e,back.g,color)
draw(back.g,back.a,color)

draw(front.a,front.c,color)
draw(front.b,front.d,color)

draw(back.f,front.e,color)
draw(back.d,front.e,color)
draw(back.h,front.e,color)
draw(back.b,front.e,color)

draw(back.b,front.a,color)
draw(back.d,front.b,color)
draw(back.f,front.c,color)
draw(back.h,front.d,color)

draw(back.g,front.c,color)
draw(back.e,front.b,color)
draw(back.c,front.a,color)
draw(back.a,front.d,color)
end
