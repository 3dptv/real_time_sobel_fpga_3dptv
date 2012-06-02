function []=find_solution(fov,distance_target,size_target,distance_beamsplitter_tip,alpha_ramp,distance_splitter_2_rear_mirrors,distance_target_2_rear_mirrors,alpha_VC,practical_offset_ratio,splitter_type)

clc
fov = fov * pi / 180 ;
alpha_ramp = alpha_ramp * pi / 180 ;
point_camera = [ 0 , 0 , 0 ] ;    % origin [0,0,0] - at camera

%%
% X points right, Y points up, Z points back

target_center_location = [ 0 , 0 , - distance_target ] ; % Camera's front side center

switch splitter_type
    case 1
        [step_height,base_length,ramp_location] = splitter_dimmensions_mark(alpha_ramp,distance_beamsplitter_tip,fov);
    case 2
        [step_height,base_length,ramp_location] = splitter_dimmensions_zurich_pyramid(alpha_ramp,distance_beamsplitter_tip,fov)
end

practical_offset=(ramp_location.deepest-ramp_location.highest)/practical_offset_ratio;

%% Calculating "a" to "b" parts of the rays
ray0_bl.a=build_ray_vector_by_2_points(point_camera,ramp_location.highest + practical_offset);
ray1_bl.a=build_ray_vector_by_2_points(point_camera,ramp_location.deepest - practical_offset);

ray0_bl.b.tail=ray0_bl.a.head;
ray1_bl.b.tail=ray1_bl.a.head;

ray0_bl.b.vector=reflection(ray0_bl.a.vector,ramp_location.normal);
ray1_bl.b.vector=reflection(ray1_bl.a.vector,ramp_location.normal);

ray0_bl.c.head=[size_target/2 , size_target/2 , -distance_target];
ray1_bl.c.head=[-size_target/2 , -size_target/2 , -distance_target];

%% Deriving and solving main equations

U0_start = ray0_bl.b.tail ;
U0_vector = ray0_bl.b.vector ;
U1_start = ray1_bl.b.tail ;
U1_vector = ray1_bl.b.vector ;

V0_start = ray0_bl.c.head ;
V1_start = ray1_bl.c.head ;
save('uv.mat','U0_start','U1_start','V0_start','V1_start','U0_vector','U1_vector');

x0 = [distance_target_2_rear_mirrors;distance_target_2_rear_mirrors;distance_splitter_2_rear_mirrors;distance_splitter_2_rear_mirrors;alpha_VC(1);alpha_VC(2);alpha_VC(3);alpha_VC(1);alpha_VC(2);alpha_VC(3)];           % Make a starting guess at the solution
options=optimset('Display','iter','MaxFunEvals',100000,'MaxIter',1000);   % Option to display output
[x,fval] = fsolve(@myfun1,x0,options)  % Call solver
U0_end=U0_start+x(3)*U0_vector;
U1_end=U1_start+x(4)*U1_vector;
V0_vector=[x(5) x(6) x(7)];
V0_vector=V0_vector/norm(V0_vector);
V1_vector=[x(8) x(9) x(10)];
V1_vector=V1_vector/norm(V1_vector);

%% Completing the "c" part of the rays
ray0_bl.b.head = U0_end ;
ray1_bl.b.head = U1_end ;

rear_mirror.vector1=ray0_bl.b.head-ray1_bl.b.head;
rear_mirror.vector1=rear_mirror.vector1/norm(rear_mirror.vector1);

rear_mirror.normal=ray0_bl.b.vector+V0_vector;
rear_mirror.normal=rear_mirror.normal/norm(rear_mirror.normal);

rear_mirror.normal2=ray1_bl.b.vector+V1_vector;
rear_mirror.normal2=rear_mirror.normal2/norm(rear_mirror.normal2);

rear_mirror.normal=rear_mirror.normal+rear_mirror.normal2;
rear_mirror.normal=rear_mirror.normal/norm(rear_mirror.normal);

rear_mirror.vector2=cross(rear_mirror.vector1,rear_mirror.normal);
rear_mirror.vector2=rear_mirror.vector2/norm(rear_mirror.vector2);

ray0_bl.c.tail = ray0_bl.b.head ;
ray0_bl.c.vector = reflection(ray0_bl.b.vector,rear_mirror.normal);

ray1_bl.c.tail = ray1_bl.b.head ;
ray1_bl.c.vector = reflection(ray1_bl.b.vector,rear_mirror.normal) ;

syms s t p
ans2=solve(ray0_bl.c.tail(1)+p*ray0_bl.c.vector(1)-s,ray0_bl.c.tail(2)+p*ray0_bl.c.vector(2)-t,ray0_bl.c.tail(3)+p*ray0_bl.c.vector(3)+distance_target);
ray0_bl.c.head=ray0_bl.c.tail+sym2poly(ans2.p)*ray0_bl.c.vector;

syms s t p
ans3=solve(ray1_bl.c.tail(1)+p*ray1_bl.c.vector(1)-s,ray1_bl.c.tail(2)+p*ray1_bl.c.vector(2)-t,ray1_bl.c.tail(3)+p*ray1_bl.c.vector(3)+distance_target);
ray1_bl.c.head=ray1_bl.c.tail+sym2poly(ans3.p)*ray1_bl.c.vector;

%% Calculating raytracing for two more rays

ray2_bl.a.tail=ray0_bl.a.tail;
ray2_bl.a.head=[ray1_bl.a.head(1),ray0_bl.a.head(2),ramp_location.deepest(3)];
ray2_bl.a.vector=ray2_bl.a.head-ray2_bl.a.tail;
ray2_bl.a.vector=ray2_bl.a.vector/norm(ray2_bl.a.vector);
ray2_bl.b.tail=ray2_bl.a.head;
ray2_bl.b.vector=reflection(ray2_bl.a.vector,ramp_location.normal);

A=[rear_mirror.vector1;rear_mirror.vector2;-ray2_bl.b.vector];
B=ray2_bl.b.tail-ray0_bl.b.head;
x=B*inv(A);

ray2_bl.b.head=ray2_bl.b.tail+ray2_bl.b.vector*x(3);
ray2_bl.c.tail=ray2_bl.b.head;
ray2_bl.c.vector=reflection(ray2_bl.b.vector,rear_mirror.normal);
s0=(-distance_target-ray2_bl.c.tail(3))/ray2_bl.c.vector(3);
ray2_bl.c.head=ray2_bl.c.tail+s0*ray2_bl.c.vector ;

ray3_bl.a.tail=ray0_bl.a.tail;
ray3_bl.a.head=[ray0_bl.a.head(1),ray1_bl.a.head(2),-distance_beamsplitter_tip];
ray3_bl.a.vector=ray3_bl.a.head-ray3_bl.a.tail;
ray3_bl.a.vector=ray3_bl.a.vector/norm(ray3_bl.a.vector);
ray3_bl.b.tail=ray3_bl.a.head;
ray3_bl.b.vector=reflection(ray3_bl.a.vector,ramp_location.normal);

A=[rear_mirror.vector1;rear_mirror.vector2;-ray3_bl.b.vector];
B=ray3_bl.b.tail-ray0_bl.b.head;
x=B*inv(A);
ray3_bl.b.head=ray3_bl.b.tail+ray3_bl.b.vector*x(3);
ray3_bl.c.tail=ray3_bl.b.head;
ray3_bl.c.vector=reflection(ray3_bl.b.vector,rear_mirror.normal);
s0=(-distance_target-ray3_bl.c.tail(3))/ray3_bl.c.vector(3);
ray3_bl.c.head=ray3_bl.c.tail+s0*ray3_bl.c.vector ;

clear A B x s0
%%
diagonal_deviation_in_percents=norm(ray0_bl.c.head-ray1_bl.c.head)/(size_target*sqrt(2))*100-100
rotation_angle_deviation=acos(dot((ray0_bl.c.head-ray2_bl.c.head)/norm(ray0_bl.c.head-ray2_bl.c.head),([1,0,0]/norm([1,0,0]))))*180/pi

%% COMPLETING THE REST OF THE RAYS by using rotation matrices.
RAY0_bl=[point_camera;ray0_bl.a.head;ray0_bl.b.head;ray0_bl.c.head]';
RAY1_bl=[point_camera;ray1_bl.a.head;ray1_bl.b.head;ray1_bl.c.head]';
RAY2_bl=[point_camera;ray2_bl.a.head;ray2_bl.b.head;ray2_bl.c.head]';
RAY3_bl=[point_camera;ray3_bl.a.head;ray3_bl.b.head;ray3_bl.c.head]';

Rz1=[cos(pi/2) -sin(pi/2) 0; sin(pi/2) cos(pi/2) 0; 0 0 1];
Rz2=[cos(pi) -sin(pi) 0; sin(pi) cos(pi) 0; 0 0 1];
Rz3=[cos(1.5*pi) -sin(1.5*pi) 0; sin(1.5*pi) cos(1.5*pi) 0; 0 0 1];

RAY0_br=(Rz1*RAY0_bl)';RAY1_br=(Rz1*RAY1_bl)';RAY2_br=(Rz1*RAY2_bl)';RAY3_br=(Rz1*RAY3_bl)';
RAY0_ur=(Rz2*RAY0_bl)';RAY1_ur=(Rz2*RAY1_bl)';RAY2_ur=(Rz2*RAY2_bl)';RAY3_ur=(Rz2*RAY3_bl)';
RAY0_ul=(Rz3*RAY0_bl)';RAY1_ul=(Rz3*RAY1_bl)';RAY2_ul=(Rz3*RAY2_bl)';RAY3_ul=(Rz3*RAY3_bl)';

RAY0_bl=RAY0_bl';RAY1_bl=RAY1_bl';RAY2_bl=RAY2_bl';RAY3_bl=RAY3_bl';

clear Rz1 Rz2 Rz3
%% Rear Mirror Dimensions Calculations
rear_mirror_dimensions.size(1)=norm(RAY0_bl(3,:)-RAY2_bl(3,:));
rear_mirror_dimensions.size(2)=norm(RAY2_bl(3,:)-RAY1_bl(3,:));
rear_mirror_dimensions.size(3)=norm(RAY1_bl(3,:)-RAY3_bl(3,:));
rear_mirror_dimensions.size(4)=norm(RAY3_bl(3,:)-RAY0_bl(3,:));
rear_mirror_dimensions.angle(1)=acos(dot((RAY0_bl(3,:)-RAY2_bl(3,:)),(RAY2_bl(3,:)-RAY1_bl(3,:)))/(rear_mirror_dimensions.size(1)*rear_mirror_dimensions.size(2)))*180/pi;
rear_mirror_dimensions.angle(2)=acos(dot((RAY1_bl(3,:)-RAY3_bl(3,:)),(RAY2_bl(3,:)-RAY1_bl(3,:)))/(rear_mirror_dimensions.size(2)*rear_mirror_dimensions.size(3)))*180/pi;
rear_mirror_dimensions.angle(3)=acos(dot((RAY1_bl(3,:)-RAY3_bl(3,:)),(RAY3_bl(3,:)-RAY0_bl(3,:)))/(rear_mirror_dimensions.size(3)*rear_mirror_dimensions.size(4)))*180/pi;
rear_mirror_dimensions.angle(4)=acos(dot((RAY0_bl(3,:)-RAY2_bl(3,:)),(RAY3_bl(3,:)-RAY0_bl(3,:)))/(rear_mirror_dimensions.size(4)*rear_mirror_dimensions.size(1)))*180/pi;
rear_mirror_dimensions.diagonal(1)=norm(RAY0_bl(3,:)-RAY1_bl(3,:));
rear_mirror_dimensions.diagonal(2)=norm(RAY2_bl(3,:)-RAY3_bl(3,:));
%% Virtual Camera Calculations

VC_location.bl = intersection_point_of_two_vectors(ray0_bl.c,ray1_bl.c);
VC_location.br = [-VC_location.bl(2),VC_location.bl(1),VC_location.bl(3)];
VC_location.ur = [-VC_location.bl(1),-VC_location.bl(2),VC_location.bl(3)];
VC_location.ul = [VC_location.bl(2),-VC_location.bl(1),VC_location.bl(3)];
VC_distance = norm(target_center_location-VC_location.bl);
VC_vector = (target_center_location-VC_location.bl)/VC_distance;
VC_angle = acos(dot(VC_vector,ray0_bl.a.vector))*180/pi;

%% PLOTTING...

figure

color='b';
draw_rays(RAY0_bl,RAY1_bl,RAY2_bl,RAY3_bl,color);
color='b';
draw_rays(RAY0_br,RAY1_br,RAY2_br,RAY3_br,color);
draw_rays(RAY0_ur,RAY1_ur,RAY2_ur,RAY3_ur,color);
draw_rays(RAY0_ul,RAY1_ul,RAY2_ul,RAY3_ul,color);

% 
color='g';
draw(VC_location.bl,RAY0_bl(3,:),color);
draw(VC_location.bl,RAY1_bl(3,:),color);
draw(VC_location.bl,RAY2_bl(3,:),color);
draw(VC_location.bl,RAY3_bl(3,:),color);

draw(VC_location.br,RAY0_br(3,:),color);
draw(VC_location.br,RAY1_br(3,:),color);
draw(VC_location.br,RAY2_br(3,:),color);
draw(VC_location.br,RAY3_br(3,:),color);

draw(VC_location.ur,RAY0_ur(3,:),color);
draw(VC_location.ur,RAY1_ur(3,:),color);
draw(VC_location.ur,RAY2_ur(3,:),color);
draw(VC_location.ur,RAY3_ur(3,:),color);

draw(VC_location.ul,RAY0_ul(3,:),color);
draw(VC_location.ul,RAY1_ul(3,:),color);
draw(VC_location.ul,RAY2_ul(3,:),color);
draw(VC_location.ul,RAY3_ul(3,:),color);

plot3(0,0,0,'o','MarkerSize',8,'MarkerFaceColor','k');
plot3(VC_location.bl(1),VC_location.bl(2),VC_location.bl(3),'o','MarkerSize',4,'MarkerFaceColor','b');
plot3(VC_location.br(1),VC_location.br(2),VC_location.br(3),'o','MarkerSize',4,'MarkerFaceColor','b');
plot3(VC_location.ul(1),VC_location.ul(2),VC_location.ul(3),'o','MarkerSize',4,'MarkerFaceColor','b');
plot3(VC_location.ur(1),VC_location.ur(2),VC_location.ur(3),'o','MarkerSize',4,'MarkerFaceColor','b');

color='k';
draw_rear_mirror(RAY0_bl,RAY1_bl,RAY2_bl,RAY3_bl,color);
color='k';
draw_rear_mirror(RAY0_br,RAY1_br,RAY2_br,RAY3_br,color);
draw_rear_mirror(RAY0_ur,RAY1_ur,RAY2_ur,RAY3_ur,color);
draw_rear_mirror(RAY0_ul,RAY1_ul,RAY2_ul,RAY3_ul,color);

switch splitter_type
    case 1
        draw_beamsplitter_mark(ramp_location,base_length,step_height);
    case 2
        draw_beamsplitter_zurich_pyramid(ramp_location,base_length,step_height);
end
draw_target(distance_target,size_target);

xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal

%% Output
step_height
base_length
rear_mirror_longest_line=max(rear_mirror_dimensions.size)
rear_mirror_shortest_line=min(rear_mirror_dimensions.size)
rear_mirror_angles=rear_mirror_dimensions.angle
% rear_mirror_dimensions.diagonal(1)
% rear_mirror_dimensions.diagonal(2)
VC_location
VC_distance
VC_angle
diagonal_deviation_in_percents
