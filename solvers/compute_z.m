function z = compute_z(data, n, alpha, clusters, centroids, params)
% function computing for the z matrix for cluster assignment
%
% Input:
%       data: data matrix
%       n: number of the data
%       alpha: the probability of one data point belonged to the kth class
%       cluster: the number of the cluster
%       centroids: the clustering center
%       params: a struct used in the function
%               params.R: radius of the spharse
%
% Output:
%       z: the z matrix
%
% by Liyifan Gan

    z = zeros(n, clusters);
    gamma = update_gamma(clusters, params);
    for i = 1 : n
        min_calc = inf;
        for k = 1 : clusters
            calc_value = spherical_distance(data(i, :), centroids(k, :), params.R)^2 - gamma * log(alpha(k));
            if calc_value < min_calc
                min_calc = calc_value;
                idx = k;
            end
        end
        z(i, idx) = 1;
    end
end