% Inputs: Hitting beam , Normal vector.
function [out_beam] = reflection( in_beam , normal )
in_beam = - in_beam;
r = vrrotvec( in_beam , normal );
m = vrrotvec2mat( r );
out_beam = (m * normal' / norm( m * normal' ))';
end