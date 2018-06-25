function [best_mse, best_net] = fs_net_final(x,t)
	hiddenLayerSize = 8;
    repetitions = 10;

    best_mse = 999;
   % best_net = [];

    disp(['fs_net_final started (', num2str(repetitions), ' repetitions)']);

    xx = x.';
	tt = t.';
    for i=1:repetitions
        net = fitnet(hiddenLayerSize);
        net.trainParam.showWindow = false;

        [net, tr] = train(net, xx, tt);
        y = net(xx);
        perf = perform(net, tt, y);

        regr = regression(tt,y);
        disp(['Repetition ', num2str(i), ' mse=', num2str(perf), ' R=', num2str(regr)]);
        if(perf < best_mse)
            best_mse = perf;
            best_net = net;
        end
    end

    % plot best network regression
    [m,n] = size(x);
    y = best_net(xx);
    best_R = regression(tt,y); 
    disp(['Best neural network (', num2str(n),' features, ', num2str(hiddenLayerSize), ' neurons): mse=', num2str(best_mse), ' R=', num2str(best_R)]);
    plotregression(tt,y, 'All');
end