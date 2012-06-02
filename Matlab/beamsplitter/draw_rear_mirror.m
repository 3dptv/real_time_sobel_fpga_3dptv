function []=draw_rear_mirror(ray0,ray1,ray2,ray3,color)

draw(ray0(3,:),ray2(3,:),color)
draw(ray2(3,:),ray1(3,:),color)
draw(ray1(3,:),ray3(3,:),color)
draw(ray3(3,:),ray0(3,:),color)

end