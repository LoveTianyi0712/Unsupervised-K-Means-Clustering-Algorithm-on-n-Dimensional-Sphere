function [xopt, info] = RSD(fns, params)
% Solver of the steepest descent method
%
% INPUT:
% fns : a struct that contains required function handles
%     fns.f(x) : return objective function value at x.
%     fns.Grad(x) : return the gradient of objection function at x.
%
% params : a struct that contains parameters that are used in the solver.
%     params.x0 : initial approximation of minimizer.
%     params.verbose             : '0' means silence, '1' means output information of initial and final iterate. 
%                                  '2' means output information of every iterate.
% 
% 
% OUTPUT:
% xopt : the last iterate
% info : informtion generated during the algorithms
%      
%
% By Wen Huang
    x1 = params.x0;              % initial iterate
    [f1, x1] = fns.f(x1);        % function value
    [gradf1, x1] = fns.Grad(x1); % Riemannian gradient
    ngf1 = norm(gradf1, 'fro');  % initial norm of grad
    ngf0 = ngf1;
    iter = 0;
    if(params.verbose >= 1)
        fprintf('iter:%d,f:%.3e,|gf|:%.3e\n', iter, f1, ngf1);
    end
    % Get search direction
    eta1 = - gradf1; % search direction
    fvs = f1; ngfs = ngf1; times = toc; Xs{1} = x1; GFs{1} = gradf1; Etas{1} = eta1; lf = 1; lgf = 1;
    stop = 0;
    status = 0;
    while(~stop && status == 0)
        
        % Find appropriate initial step size
        initslope = eta1' * gradf1;
        initstepsize = params.initstepsize;
        
        % Line search algorithm
        [eta2, stepsize, x2, f2, gradf2, slopex2, LSinfo, status] = params.linesearch(eta1, x1, fvs, gradf1, initslope, initstepsize, iter, fns, params);
        x2.main = x2.main / norm(x2.main) * params.R;
        f2 = fns.f(x2); % function value
        gradf2 = fns.Grad(x2); % Riemannian gradient
        ngf2 = norm(gradf2, 'fro'); % initial norms of grad
        
        % finish line search
        
        if(length(Xs) >= params.KeepNum)
            Xs(1) = []; GFs(1) = []; Etas(1) = [];
        end
        eta1 = - gradf2;
        
        fvs(end + 1) = f2;
        ngfs(end + 1) = ngf2;
        Xs{end + 1} = x2;
        GFs{end + 1} = gradf2;
        Etas{end + 1} = eta1;
        iter = iter + 1;
        
        % Check stopping criterion
        stop = IsStopped(iter, Xs, fvs, ngfs, ngf0, times, fns, params);
        
        lf(iter) = LSinfo.lf; lgf(iter) = LSinfo.lgf;
        % Get ready for the next iteration
        x1 = x2; f1 = f2; gradf1 = gradf2; ngf1 = ngf2;
        if(params.verbose >= 2 && mod(iter, params.OutputGap) == 0)
            fprintf('iter:%d,f:%.3e,|gf|:%.3e,s0:%.1e,snew:%.1e,t0:%.1e,tnew:%.1e,lf:%d,lgf:%d\n', iter, f1, ngf1, initslope, slopex2, initstepsize, stepsize, sum(lf), sum(lgf));
        end
    end
    if(params.verbose >= 1)
        fprintf('iter:%d,f:%.3e,|gf|:%.3e,|gf|/|gf0|:%.3e,lf:%d,lgf:%d\n', iter, f1, ngf1, ngf1 / ngf0, sum(lf), sum(lgf));
    end
    xopt = x1;
    info.iter = iter;
    info.ngfs = ngfs;
    info.times = times;
    info.fvs = fvs;
    info.xs = Xs;
    info.gfs = GFs;
    info.etas = Etas;
    info.lf = lf;
    info.lgf = lgf;
end
