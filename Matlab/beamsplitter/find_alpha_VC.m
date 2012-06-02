function [alpha_VC]=find_alpha_VC(alpha_VC)
syms x z
ans10=solve(x^2+z^2-1,acos(z)*180/pi-alpha_VC);
ans10.x=subs(ans10.x);
ans10.z=subs(ans10.z);
for i=1:size(ans10.x,1)
    if ans10.x(i)<0
        alpha_VC=[ans10.x(i),-0.1,ans10.z(i)]
        break
    end
end
