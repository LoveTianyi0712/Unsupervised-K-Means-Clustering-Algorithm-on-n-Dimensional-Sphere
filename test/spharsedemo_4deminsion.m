clc, clear
% 设置球半径和点的数量
r = 1;
N = 100;

% 在球面上随机生成点
phi_1 = pi* 1/6 * rand(N,1);
phi_2 = pi* 1/6 * rand(N,1);
phi_3 = 2 * pi* 1/6 * rand(N,1);

a1 = r * cos(phi_1);
b1 = r * sin(phi_1) .* cos(phi_2);
c1 = r * sin(phi_1) .* sin(phi_2) .* cos(phi_3);
d1 = r * sin(phi_1) .* sin(phi_2) .* sin(phi_3);

phi_1 = pi* 1/6 * rand(N,1) + pi / 3;
phi_2 = pi* 1/6 * rand(N,1) + pi / 3;
phi_3 = 2 * pi* 1/6 * rand(N,1) + pi / 3;
a2 = r * cos(phi_1);
b2 = r * sin(phi_1) .* cos(phi_2);
c2 = r * sin(phi_1) .* sin(phi_2) .* cos(phi_3);
d2 = r * sin(phi_1) .* sin(phi_2) .* sin(phi_3);

phi_1 = pi* 1/6 * rand(N,1) + 2 * pi / 3;
phi_2 = pi* 1/6 * rand(N,1) + 2 * pi / 3;
phi_3 = 2 * pi* 1/6 * rand(N,1) + 2 * pi / 3;
a3 = r * cos(phi_1);
b3 = r * sin(phi_1) .* cos(phi_2);
c3 = r * sin(phi_1) .* sin(phi_2) .* cos(phi_3);
d3 = r * sin(phi_1) .* sin(phi_2) .* sin(phi_3);

data = [a1, b1, c1, d1; a2, b2, c2, d2; a3, b3, c3, d3];
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
params.converge_rate = 500;
[centroids, info] = u_k_means(data, params);

fprintf("Converged after %d iterations, clusters number: %d, time used: %f\n", info.t, info.clusters(info.t), info.time);