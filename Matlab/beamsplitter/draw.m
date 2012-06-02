function []=draw(point1,point2,color)
resolution=5;
vector=(point1-point2)/resolution;
t=0:resolution;
plot3(point2(1)+t*vector(1),point2(2)+t*vector(2),point2(3)+t*vector(3),color)
hold on
end