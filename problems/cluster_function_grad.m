function [output, x] = cluster_function_grad(x, data, params)
% calculate the sum of the gradient cluster function
% Input: 
%       x: cluster points
%       data: all data points
%       params: a struct used in the function
%               params.R: radius of the spharse
%
% Output:
%       output: the sum of the gradient of the cluster function
%
% by Liyifan Gan
    
    output = 0;
    radius = params.R;
    [n, m] = size(data);
    for i = 1:n
        y = data(i, :)';
        xy = x.main' * y / radius^2;
        output = output + radius * acos(xy) / sqrt(1 - xy^2) * (eye(m) - x.main * x.main') * y;
    end
    output = - 2 / n * output;
end