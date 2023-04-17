function criteria = compute_max_norm(old_cluster, new_cluster, clusters, params)
% compute the criteria of the cluster between different iteration
%
% Input: 
%       old_cluster: previous old cluster
%       new_cluster: new cluster
%       cluster: number of the cluster number
%       params: a struct used in the function
%               params.R: radius of the spharse
%
% Output:
%       criteria: maxium of the norm of the two clusters
%
% by Liyifan Gan

    calc_norm = [];
    for k = 1: clusters
       calc_norm(k) = spherical_distance(new_cluster(k, :), old_cluster(k, :), params.R)^2;
    end
    criteria = max(calc_norm);
end