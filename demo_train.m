%% Training and validation


clearvars -except X Y N;
close all;
if ~ exist('X', 'var')
t0 = tic;
X = csvread('data_train.csv',1,1);
Y = csvread('labels_train.csv',1,1);
tread = toc(t0); disp(['reading takes: ',num2str(tread),' s']);
N = size(X,1);

end


%% Scattering: feature extraction

while true
    idxp = round( N*rand );
    if idxp>0
        break;
    end
end

x1 = X(idxp,:)';

L = length(x1);
T = 2^8; 

t1 = tic;

filt_opt = default_filter_options('audio', T);
[Wop, filters ] = wavelet_factory_1d(L, filt_opt);
twop = toc(t1); disp(['loading Wop takes: ',num2str(twop),' s']);


S = scat(x1, Wop);

% break;
%% visualization
j1 = 0;
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

% gtzan_src
src = gtzan_src('./data/gtest');
% prepare_database
N = 5*2^17;
T = 8192;
 
filt_opt.Q = [8 1];
filt_opt.J = T_to_J(T, filt_opt);
 
scat_opt.M = 2;
 
Wopg = wavelet_factory_1d(N, filt_opt, scat_opt);
 
feature_fun = @(x)(format_scat( ...
    log_scat(renorm_scat(scat(x, Wopg)))));
database_options.feature_sampling = 8;

database = prepare_database(src, feature_fun, database_options);

[train_set, test_set] = create_partition(src, 0.8);


database = svm_calc_kernel(database, 'gaussian');


svm_options.kernel_type = 'gaussian';
svm_options.C = 2.^[0:4:8];
svm_options.gamma = 2.^[-16:4:-8];
 
[err,C,gamma] = svm_param_search( ...
    database, train_set, [], svm_options);

    







