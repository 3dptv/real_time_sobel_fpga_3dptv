function [ray_vector]=build_ray_vector_by_2_points(tail_point,head_point)
vector=head_point-tail_point;
normal_vector=vector/norm(vector);
ray_vector.head=head_point;
ray_vector.tail=tail_point;
ray_vector.vector=normal_vector;
end