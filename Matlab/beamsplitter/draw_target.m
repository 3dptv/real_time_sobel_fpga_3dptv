function []=draw_target(distance_target,size_target)
target.front.a=[-size_target/2,size_target/2,-distance_target];
target.front.b=[size_target/2,size_target/2,-distance_target];
target.front.c=[size_target/2,-size_target/2,-distance_target];
target.front.d=[-size_target/2,-size_target/2,-distance_target];
target.back.a=[-size_target/2,size_target/2,-distance_target-size_target];
target.back.b=[size_target/2,size_target/2,-distance_target-size_target];
target.back.c=[size_target/2,-size_target/2,-distance_target-size_target];
target.back.d=[-size_target/2,-size_target/2,-distance_target-size_target];
color='m';
draw(target.front.a,target.front.b,color)
draw(target.front.b,target.front.c,color)
draw(target.front.c,target.front.d,color)
draw(target.front.d,target.front.a,color)
draw(target.back.a,target.back.b,color)
draw(target.back.b,target.back.c,color)
draw(target.back.c,target.back.d,color)
draw(target.back.d,target.back.a,color)
draw(target.front.a,target.back.a,color)
draw(target.front.b,target.back.b,color)
draw(target.front.c,target.back.c,color)
draw(target.front.d,target.back.d,color)
end

