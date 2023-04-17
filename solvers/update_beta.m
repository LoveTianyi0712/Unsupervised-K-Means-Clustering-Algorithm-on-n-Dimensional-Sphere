function beta = update_beta(iter, dimension, n, clusters, alpha, new_alpha, z)
% function for updating beta
% 
% Input:
%       iter: iteration index
%       dimension: dimension of the data
%       n: number of the data
%       clusters: number of clusters
%       alpha: old alpha
%       new_alpha: updated alpha
%       z: z matrix
%
% Output:
%       beta: updated beta
% 
% by Liyifan Gan
    
    eta = min(1, 1 / iter^(floor(dimension / 2 - 1)));
    first_term = sum(exp(-eta * n * abs(new_alpha - alpha))) / clusters;
    sum_ln_alpha_t = sum(log(alpha));
    second_term = (1 - max(sum(z, 1) / n)) / (-max(alpha * sum_ln_alpha_t));
    beta = min(first_term, second_term);
end