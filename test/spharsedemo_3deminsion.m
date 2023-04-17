clc, clear
rng(3)
% 设置球半径和点的数量
r = 1;
N = 200;

% 在球面上随机生成点
theta = pi* 1/6 * rand(N,1);
phi = 2 * pi* 1/6 * rand(N,1);
x1 = r*sin(theta).*cos(phi);
y1 = r*sin(theta).*sin(phi);
z1 = r*cos(theta);

theta = pi* 1/6 * rand(N,1) + pi/3;
phi = 2 * pi* 1/6 * rand(N,1) + pi/3;
x2 = r*sin(theta).*cos(phi);
y2 = r*sin(theta).*sin(phi);
z2 = r*cos(theta);

theta = pi* 1/6 * rand(N,1) + 2 * pi/3;
phi = 2 * pi* 1/6 * rand(N,1) + 2 * pi/3;
x3 = r*sin(theta).*cos(phi);
y3 = r*sin(theta).*sin(phi);
z3 = r*cos(theta);

data = [x1, y1, z1; x2, y2, z2; x3, y3, z3];
type = [ones(1, 100), 2 * ones(1, 100), 3 * ones(1, 100)]';

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
params.OutputGap = 10;
params.minstepsize = eps;
params.maxstepsize = 1000;
params.isStopped = @IsStopped;
params.initstepsize  = 0.01;
params.linesearch = @LinesearchBacktracking;
params.Tolerance = 1e-3;
params.converge_rate = 10;
[centroids, info] = u_k_means(data, params);

fprintf("Converged after %d iterations, clusters number: %d, time used: %f\n", info.t, info.clusters(info.t), info.time);

% 绘制生成的点
figure
scatter3(data(:, 1), data(:, 2), data(:, 3), 15, data, 'filled');
hold on
scatter3(centroids(:, 1), centroids(:, 2), centroids(:, 3),  'filled');
title('聚类结果')

figure;
subplot(2, 2, 1);
scatter3(data(:, 1), data(:, 2), data(:, 3), 15, 'filled');
hold on;
scatter3(info.centroids{2}(:, 1), info.centroids{2}(:, 2), info.centroids{2}(:, 3), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：2，聚类数量：423")

subplot(2, 2, 2);
scatter3(data(:, 1), data(:, 2), data(:, 3), 15, 'filled');
hold on;
scatter3(info.centroids{4}(:, 1), info.centroids{4}(:, 2), info.centroids{4}(:, 3), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：4，聚类数量：149")

subplot(2, 2, 3);
scatter3(data(:, 1), data(:, 2), data(:, 3), 15, 'filled');
hold on;
scatter3(info.centroids{9}(:, 1), info.centroids{9}(:, 2), info.centroids{9}(:, 3), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：9，聚类数量：9")

subplot(2, 2, 4);
scatter3(data(:, 1), data(:, 2), data(:, 3), 15, 'filled');
hold on;
scatter3(info.centroids{12}(:, 1), info.centroids{12}(:, 2), info.centroids{12}(:, 3), 30, 'x', 'MarkerEdgeColor', 'black', 'LineWidth', 2);
title("迭代次数：12，聚类数量：3")