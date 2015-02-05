%% Training and validation


clearvars -except X Y N;
close all;
if ~ exist('data_train', 'var')
t0 = tic;
X = csvread('data_train.csv',1,1);
Y = csvread('labels_train.csv',1,1);
tread = toc(t0); disp(['reading takes: ',num2str(tread),' s']);
N = size(X,1);

end


%% Scattering: feature extraction

x1 = X(1,:)';

L = length(x1);
T = 2^7; 

t1 = tic;

filt_opt = default_filter_options('audio', T);
[Wop, filters ] = wavelet_factory_1d(N, filt_opt);
twop = toc(t1); disp(['loading Wop takes: ',num2str(twop),' s']);


S = scat(x1, Wop);

% break;
%% visualization
j1 = 23;
figure(1);
scattergram(S{2},[],S{3},j1);
% break;
S = renorm_scat(S);
S = log_scat(S);
 figure(2);
scattergram(S{2},[],S{3},j1);
% break;

%% Formate feature data:
[S_table, meta] = format_scat(S);

%% opt setting 
figure(3);
plotsignals(X, Y, 1);
%%









