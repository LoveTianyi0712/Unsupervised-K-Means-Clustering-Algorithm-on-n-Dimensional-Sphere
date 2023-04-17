function [centroids, info] = u_k_means(data, params)
% Unsupervised K-Means clustering algorithm
%
% Input:
%       data: input data with n rows and m columns, n denote the number of
%             the sample and m is the dimension of the data 
%       params: necessary parameters used in the algorithm
%               params.epsilion: criteria for stopping the algorithm
%               params.maxiter: maximum iteration times
%               params.R: radius of the spharse
%
% Output:
%       centroids: clustering result
%       info: the information generated during the iteration process
% 
% by Liyifan Gan
    
    tic;
    % get the number and the dimension of the data
    [n, dimension] = size(data);
    
    % initialize
    t = 1;
    centroids{1} = data;
    clusters(1) = n;
    alpha{1} = ones(1, clusters) ./ clusters;
    z{1} = zeros(n, clusters);
    gamma(1) = 1;
    beta(1) = 1;
    for i = 1 : n
        for k = 1 : clusters(1)
            calc_value(k) = spherical_distance(data(i, :), centroids{1}(k, :), params.R) - gamma(1) * log(alpha{1}(k));
        end
        calc_value(i) = inf;  % safegard that the 
        [~, idx] = min(calc_value);
        z{1}(i, idx) = 1;
    end
    
    % first updateion
    t = t + 1;
    gamma(t) = update_gamma(clusters(1), params);
    alpha{t} = update_alpha(z{1}, alpha{1}, beta(1), gamma(1), n);
    [clusters(t), alpha{t}, z{t}, index] = update_c_alpha_z(n, clusters(1), alpha{t}, z{1});
    centroids{t} = update_a(clusters(t), dimension, z{t}, data, params);
    
    % loop
    criteria = compute_max_norm(centroids{t-1}(index, :), centroids{t}, clusters(t), params);
    while criteria >= params.epsilion && t < params.maxiter
        z{t+1} = compute_z(data, n, alpha{t}, clusters(t), centroids{t}, params);
        gamma(t+1) = update_gamma(clusters(t), params);
        alpha{t+1} = update_alpha(z{t+1}, alpha{t}, beta(t-1), gamma(t), n);
        beta(t) = update_beta(t, dimension, n, clusters(t), alpha{t}, alpha{t+1}, z{t+1});
        [clusters(t+1), alpha{t+1}, z{t+1}, index] = update_c_alpha_z(n, clusters(t), alpha{t+1}, z{t+1});
        if t > 60
            if clusters(t) - clusters(t - 60) == 0
                beta(t) = 0;
            end
        end
        centroids{t+1} = update_a(clusters(t+1), dimension, z{t+1}, data, params);
        criteria = compute_max_norm(centroids{t}(index, :), centroids{t+1}, clusters(t + 1), params);
        t = t + 1;
    end
    
    % generate the result and the debugging information
    info.t = t;
    info.alpha = alpha;
    info.beta = beta;
    info.gamma = gamma;
    info.z = z;
    info.clusters = clusters;
    info.centroids = centroids;
    info.time = toc;
    centroids = centroids{t};
end