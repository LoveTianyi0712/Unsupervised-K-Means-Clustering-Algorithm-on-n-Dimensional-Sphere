function centroids = update_a(clusters, dimension, z, data, params)
% function for updating centroids.
%
% Input: 
%       clusters: number of clusters
%       dimension: dimension of the data
%       data: original data matrix
%       z: the z matrix
%       params: a struct used in the function
%               params.R: radius of the spharse
%       
% Output:
%       centroids: update result of the centroids
%
% by Liyifan Gan
    centroids = zeros(clusters, dimension);
    radius = params.R;
    for k = 1: clusters
        % the first step: compute the cluster center using the normal 
        % k means and project it onto the spherical space        
        cluster_data = ~(z(:, k) == 0) .* data;
        cluster_data = cluster_data(any(cluster_data, 2), :);
        [n, m] =  size(cluster_data);
        centroids(k, :) = sum(cluster_data) / n;
        centroids(k, :) = centroids(k, :) * radius / norm(centroids(k, :));
        % the second step: use the new centroids as initalizer and compute 
        % the real center using the steepest descend method
        fns.f = @(x)cluster_function(x, cluster_data, params);
        fns.Grad = @(x)cluster_function_grad(x, cluster_data, params);
        x0.main = centroids(k, :)';
        params.x0 = x0;
        [xopt, info] = RSD(fns, params);
        centroids(k, :) = xopt.main';
    end
    centroids(isnan(centroids)) = 0;
end