% addpath('./data');

clear;
data_test = csvread('data_test.csv',1,1);

data_train = csvread('data_train.csv',1,1);

label_zeros = csvread('label_zero.csv',1,1);
labels_train = csvread('labels_train.csv',1,1);
