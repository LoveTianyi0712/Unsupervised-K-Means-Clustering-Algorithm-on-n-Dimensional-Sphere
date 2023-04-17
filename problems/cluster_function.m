function [output, x] = cluster_function(x, data, params)
% calculate the sum of the cluster function
% Input: 
%       x: cluster points
%       data: all data points
%       params: a struct used in the function
%               params.R: radius of the spharse
%
% Output:
%       output: the sum of the cluster function
%
% by Liyifan Gan

    radius = params.R;
    output = 0;
    [n, m] = size(data);
    for k = 1:n
        output = output + spherical_distance(x.main, data(k, :), radius)^2;
    end
    output = output / n;
end