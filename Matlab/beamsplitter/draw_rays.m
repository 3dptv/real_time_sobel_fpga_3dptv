function []=draw_rays(ray0,ray1,ray2,ray3,color)

draw(ray0(1,:),ray0(2,:),color);
draw(ray0(2,:),ray0(3,:),color);
draw(ray0(3,:),ray0(4,:),color);

draw(ray1(1,:),ray1(2,:),color);
draw(ray1(2,:),ray1(3,:),color);
draw(ray1(3,:),ray1(4,:),color);

draw(ray2(1,:),ray2(2,:),color);
draw(ray2(2,:),ray2(3,:),color);
draw(ray2(3,:),ray2(4,:),color);

draw(ray3(1,:),ray3(2,:),color);
draw(ray3(2,:),ray3(3,:),color);
draw(ray3(3,:),ray3(4,:),color);

end