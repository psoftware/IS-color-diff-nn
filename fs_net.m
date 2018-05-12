function perf = fs_net(x,t)
	hiddenLayerSize = 3;
    net = fitnet(hiddenLayerSize);
    xx = x.';
    tt = t.';
    [net, tr] = train(net, xx, tt);
    y = net(xx);
    perf = perform(net, tt, y);
end