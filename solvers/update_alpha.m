function new_alpha = update_alpha(z, alpha, beta, gamma, n)
% function for updating alpha
%
% Input:
%       z: z matrix used in the update formula
%       alpha: old alpha need to be update
%       beta: beta used in the update formula
%       gamma: gamma used in the update formula
%       n: number of the data
%
% Output: 
%       new_alpha: updated alpha
% 
% by Liyifan Gan

    entropy = sum(alpha .* log(alpha));
    new_alpha = zeros(size(alpha));
    for k = 1:length(new_alpha)
        new_alpha(k) = sum(z(:, k)) ./ n + (beta / gamma) * alpha(k) * (log(alpha(k)) - entropy);
    end
end