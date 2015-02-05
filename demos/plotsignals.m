%% demo_plotsignals
function plotsignals(data_train, labels_train, randd )


opt.maxplot = 8;
idx_pos = find(labels_train == 1);
idx_negs = find(labels_train == 0);

idx_show = idxsampling(idx_pos,idx_negs,100, randd ); %[idx_pos(1:100); idx_negs(1:100)];

Xshow = data_train(idx_show,:);
signalplot(Xshow, opt);
end