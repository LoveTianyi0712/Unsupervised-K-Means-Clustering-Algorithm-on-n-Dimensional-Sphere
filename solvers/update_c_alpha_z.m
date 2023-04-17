function [clusters, alpha, z, index] = update_c_alpha_z(n, clusters, new_alpha, z)
% function for updating cluster center and the renewal of the c and z
% matrix.
%
% Input:
%       n: number of the data
%       clusters: previous clusters
%       new_alpha: iterated alpha 
%       z: z matrix
%
% Output:
%       cluster: new cluster number
%
% by Liyifan Gan
    
%     clusters = clusters - sum(new_alpha <= 1 / n);
%     index = ~(new_alpha <= 1 / n);
%     alpha = new_alpha(index);
%     alpha = alpha / sum(alpha);
%     z = z(:, index);
%     z = z / sum(z);
%     z(isnan(z)) = 0;

     index = [];
     for k = 1:clusters
         if new_alpha(k) <= 1 / n
             clusters = clusters - 1;
         else
            index = [index, k]; 
         end
     end
     alpha = new_alpha(index);
     z = z(:, index);
     z = z ./ sum(z);
     z(isnan(z)) = 0;
end