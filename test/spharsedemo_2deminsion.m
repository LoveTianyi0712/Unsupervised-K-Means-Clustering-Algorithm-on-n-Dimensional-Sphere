clc, clear
rng(3368)
% 设置球半径和点的数量
r = 1;
N = 100;

% 在球面上随机生成点
theta = pi* 1/6 * rand(N,1);
x1 = r*sin(theta);
y1 = r*cos(theta);

theta = pi* 1/6 * rand(N,1) + pi/2;
x2 = r*sin(theta);
y2 = r*cos(theta);

theta = pi* 1/6 * rand(N,1) + pi;
x3 = r*sin(theta);
y3 = r*cos(theta);

theta = pi* 1/6 * rand(N,1) + 5/3 * pi;
x4 = r*sin(theta);
y4 = r*cos(theta);

data = [x1, y1; x2, y2; x3, y3; x4, y4];

type = [ones(1, 100), 2 * ones(1, 100), 3 * ones(1, 100), 4 * ones(1, 100)]';

params.epsilion = 1e-8;
params.maxiter = 5000;
params.R = r;
params.alpha = 1e-4;
params.beta = 0.999;
params.Max_Iteration = 5000;
params.verbose = 0;
params.lsmaxiter = 30;
params.ratio1 = 0.02;
params.ratio2 = 0.98;
params.FirstIterInitStepSize = 0.01;
params.KeepNum = Inf;
params.OutputGap = 100;
params.minstepsize = eps;
params.maxstepsize = 1000;
params.isStopped = @IsStopped;
params.initstepsize  = 0.01;
params.linesearch = @LinesearchBacktracking;
params.Tolerance = 1e-3;
params.converge_rate = 10;
[centroids, info] = u_k_means(data, params);

fprintf("Converged after %d iterations, clusters number: %d, time used: %f\n", info.t, info.clusters(info.t), info.time);

figure;
scatter(data(:, 1), data(:, 2), 15, type, 'filled');
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
hold on
scatter(centroids(:, 1), centroids(:, 2),  'filled');
title("聚类结果");

figure;
subplot(2, 2, 1);
scatter(data(:, 1), data(:, 2), 15, 'filled');
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
hold on;
scatter(info.centroids{2}(:, 1), info.centroids{2}(:, 2), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：2，聚类数量：297")

subplot(2, 2, 2);
scatter(data(:, 1), data(:, 2), 15, 'filled');
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
hold on;
scatter(info.centroids{4}(:, 1), info.centroids{4}(:, 2), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：4，聚类数量：97")

subplot(2, 2, 3);
scatter(data(:, 1), data(:, 2), 15, 'filled');
hold on;
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
scatter(info.centroids{8}(:, 1), info.centroids{8}(:, 2), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：8，聚类数量：6")

subplot(2, 2, 4);
scatter(data(:, 1), data(:, 2), 15, 'filled');
xlim([-1.5, 1.5])
ylim([-1.5, 1.5])
hold on;
scatter(info.centroids{10}(:, 1), info.centroids{10}(:, 2), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：10，聚类数量：4")
