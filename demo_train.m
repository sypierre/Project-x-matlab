%% Training and validation


clearvars -except data_train labels_train N;
close all;
if ~ exist('data_train', 'var')
t0 = tic;
data_train = csvread('data_train.csv',1,1);
labels_train = csvread('labels_train.csv',1,1);
tread = toc(t0); disp(['reading takes: ',num2str(tread),' s']);
N = size(data_train,1);

end


%% Scattering: feature extraction

x1 = data_train(1,:)';

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
scattergram(S{2},[],S{3},j1);
% break;
S = renorm_scat(S);
S = log_scat(S);
 
scattergram(S{2},[],S{3},j1);
break;

%% Formate feature data:
[S_table, meta] = format_scat(S);










