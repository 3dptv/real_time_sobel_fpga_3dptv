function F = myfun1 (x)
UV=load('uv.mat');
% x(1)=r0
% x(2)=r1
% x(3)=t0
% x(4)=t1
% x(5)=V0x
% x(6)=V0y
% x(7)=V0z
% x(8)=V1x
% x(9)=V1y
% x(10)=V1z

F = [x(5)^2+x(6)^2+x(7)^2-1; 
     x(8)^2+x(9)^2+x(10)^2-1;  
     dot((UV.U0_start+x(3)*UV.U0_vector)-(UV.U1_start+x(4)*UV.U1_vector),(UV.U0_vector+[x(5),x(6),x(7)]));
     det([1,1,1;UV.U0_vector+[x(5),x(6),x(7)];UV.U1_vector+[x(8),x(9),x(10)]]);
     UV.V0_start(1)+x(1)*x(5)-(UV.U0_start(1)+x(3)*UV.U0_vector(1));
     UV.V0_start(2)+x(1)*x(6)-(UV.U0_start(2)+x(3)*UV.U0_vector(2));
     UV.V0_start(3)+x(1)*x(7)-(UV.U0_start(3)+x(3)*UV.U0_vector(3));
     UV.V1_start(1)+x(2)*x(8)-(UV.U1_start(1)+x(4)*UV.U1_vector(1));
     UV.V1_start(2)+x(2)*x(9)-(UV.U1_start(2)+x(4)*UV.U1_vector(2));
     UV.V1_start(3)+x(2)*x(10)-(UV.U1_start(3)+x(4)*UV.U1_vector(3))];