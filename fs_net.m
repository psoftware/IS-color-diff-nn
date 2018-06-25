function perf = fs_net(x,t)
	hiddenLayerSize = 10;
    net = fitnet(hiddenLayerSize);
    net.trainParam.showWindow = false;
    xx = x.';
    tt = t.';
    [net, tr] = train(net, xx, tt,'useParallel','yes');
    y = net(xx);
    perf = perform(net, tt, y);
end