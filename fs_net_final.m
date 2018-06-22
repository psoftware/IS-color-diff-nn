function perf = fs_net_final(x,t)
	hiddenLayerSize = 15
    net = fitnet(hiddenLayerSize);
    xx = x.';
    tt = t.';
    [net, tr] = train(net, xx, tt);
    y = net(xx);
    perf = perform(net, tt, y);
end