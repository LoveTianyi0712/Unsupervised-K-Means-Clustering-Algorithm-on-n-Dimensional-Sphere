function gamma = update_gamma(cluster, params)
% function for updating gamma
%
% Input:
%       cluster: number of the clusters
%
% Output:
%       gamma: updated gamma
%
% by Liyifan Gan

    gamma = exp(-cluster / params.converge_rate);
end