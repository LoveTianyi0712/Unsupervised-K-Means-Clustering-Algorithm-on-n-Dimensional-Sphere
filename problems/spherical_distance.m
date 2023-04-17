function d = spherical_distance(p1, p2, R)
% calculate the distance between two points on a spharse on the original
% point
%
% Input: 
%       p1: points 1, on the spharse
%       p2: points 2, on the same pharse
%        R: radius of the spharse
%
% Output:
%       d: distance
%
% by Liyifan Gan
    dot_product = dot(p1, p2);
    angle = acos(dot_product / R^2);
    d = R * angle;
end
