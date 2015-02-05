function signalplot( X, opt )
%% plot signals

n  = size(X,1)/2; % number of pos/neg examples
np = min(n, opt.maxplot);

xx = (1:600)/200;

for i =1 : np
    
subplot(opt.maxplot, 2, 2*i-1 );

plot(xx, X(i,:) );
axis([0 xx(end) -200 200])
subplot(opt.maxplot, 2, 2*i );

plot(xx, X(n+i,:) );
axis([0 xx(end) -200 200])

end



