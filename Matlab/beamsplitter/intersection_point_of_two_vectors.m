function[intersection_point]=intersection_point_of_two_vectors(vector1,vector2)
banana=@(x)sum(((vector1.tail+x(1)*vector1.vector)-(vector2.tail+x(2)*vector2.vector)).^2);
[x,fval] = fminsearch(banana,[-1.2, 1]);
point1=vector1.tail+x(1)*vector1.vector;
point2=vector2.tail+x(2)*vector2.vector;
point=(point1+point2)/2;
check=norm(point1-point2);
if check<200 intersection_point=point;
else
    check=-1;
    intersection_point=[0,0,0];
end
end


