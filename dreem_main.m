%% Dreem project 

%% 0.0 -  Load data
clearvars -except X Y N L ;
close all;

if ~ exist('X', 'var')
   demo_startup;
    t0 = tic;
    X = csvread('data_train.csv',1,1);
    Y = csvread('labels_train.csv',1,1);
    tread = toc(t0); disp(['reading takes: ',num2str(tread),' s']);
    [N, L] = size(X);

end

%% 0.1 - wave observations 
figure();
[idx_pos, idx_negs] = plotsignals(X, Y, 1);

%% 1.0 - Scattering: feature extraction with <featurefun>

T = 2^9;  % taille de fenetre pour Scattering 

filt_opt = default_filter_options('dyadic', T);
% filt_opt.filter_type = {'gabor_1d','morlet_1d'};
[Wop, filters ] = wavelet_factory_1d(L, filt_opt);

% ===== THE OPERATOR that does all the feature extraction transformations
% =======================================================================
featurefun = @(x)(format_scat( log_scat( renorm_scat( scat(x, Wop)))));
% =======================================================================
nobs = 1;

for i = 1 : nobs
if mod(i,2)
    xpos = X(idx_pos(i),:)';
    xnegs = X(idx_negs(i), : )';
end
Sp_table = featurefun(xpos);%scat(xpos, Wop);
Sn_table = featurefun(xnegs); %scat(xnegs, Wop);

figure(); subplot(121);imagesc( Sp_table) ;
subplot(122); imagesc(Sn_table);

Spn( i ,: ) = mean( Sp_table, 2)';
Spn( i+nobs, :) = mean( Sn_table, 2 )';
end

% distances = NORM2( Spn, Spn, 1);
% figure(); imagesc( distances );
pause(.1);

% break;
%% 1.1 - Database building
%  indices for POSITIVE examples: <idx_pos>
%  indices for NEGATIVE examples: <idx_negs>

while true
    iidx_subnegs = round( length(idx_negs)*rand(1,5000) );
    if ~ sum( iidx_subnegs == 0)
        break;
    end
end
%==================Build Balanced [positive + negative] data source========

equi_idxs = [idx_pos; idx_negs( iidx_subnegs )]; % 4981 + 5000
Y_ch = Y(equi_idxs);
X_ch = X(equi_idxs,:);
% =========================================================================
% =====================Create data structure for SVM ======================
% <dreemdb> contains organised SCATTERING FEATURE VECTORS and LABELS


dsrc = create_dreemsrc(Y_ch );

database_options.feature_sampling = 1;

dreemdb = prepare_dreemdb(dsrc, featurefun,X_ch, database_options);


%% 2.0 - SVM based on the paired database <(dsrc , dreemdb)>

[train_set, test_set] = create_partition(dsrc, 0.8);

train_opt.kernel_type = 'linear';
 train_opt.C = 8;
 
 model = svm_train(dreemdb, train_set , train_opt);
 
 labels = svm_test(dreemdb, model, test_set );
 
 
 err = classif_err(labels, test_set, dsrc);

 
 categories = Y_ch( test_set );
 posteriors = labels;
 posteriors( posteriors == 2) = 0;
 
 PERFORMANCE = auc( categories, posteriors);
 
 
 
 
 
 
