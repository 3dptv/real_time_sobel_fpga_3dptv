function draw_beamsplitter_zurich_pyramid(ramp_location,base_length,step_height)
z_peak=ramp_location.highest(3);
color='k';

front.a=[0,base_length/2,z_peak-step_height/2];
front.b=[base_length/2,0,z_peak-step_height/2];
front.c=[0,-base_length/2,z_peak-step_height/2];
front.d=[-base_length/2,0,z_peak-step_height/2];
front.e=[0,0,z_peak];

back.a=[-base_length/2,base_length/2,z_peak-step_height];
back.b=[base_length/2,base_length/2,z_peak-step_height];
back.c=[base_length/2,-base_length/2,z_peak-step_height];
back.d=[-base_length/2,-base_length/2,z_peak-step_height];

draw(back.a,back.b,color)
draw(back.b,back.c,color)
draw(back.c,back.d,color)
draw(back.d,back.a,color)

draw(front.a,back.b,color)
draw(back.b,front.b,color)
draw(front.b,back.c,color)
draw(back.c,front.c,color)
draw(front.c,back.d,color)
draw(back.d,front.d,color)
draw(front.d,back.a,color)
draw(back.a,front.a,color)

draw(front.e,front.a,color)
draw(front.e,front.b,color)
draw(front.e,front.c,color)
draw(front.e,front.d,color)

end
