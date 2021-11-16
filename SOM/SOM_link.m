%%
clear;clc;close all;
%%
% c = charMeasurements
% d1 = getfield(c,'Image')
% d2 = getfield(c(2),'Image')
% d3 = getfield(c(3),'Image')
% dc = getfield(c(4),'Image')
% da = getfield(c(5),'Image')
% db = getfield(c(6),'Image')
% save ('/home/ryan/mv_project/1.mat','d1')
% save ('/home/ryan/mv_project/2.mat','d2')
% save ('/home/ryan/mv_project/3.mat','d3')
% save ('/home/ryan/mv_project/A.mat','da')
% save ('/home/ryan/mv_project/B.mat','db')
% save ('/home/ryan/mv_project/C.mat','dc')
%%

MatOriginal = regexp(fileread('SegmentedC.txt'), '\r?\n', 'split');
MatOriginal = vertcat(MatOriginal{:});
MC = char2num(MatOriginal)

MatOriginal = regexp(fileread('SegmentedB.txt'), '\r?\n', 'split');
MatOriginal = vertcat(MatOriginal{:});
MB = char2num(MatOriginal)

MatOriginal = regexp(fileread('SegmentedA.txt'), '\r?\n', 'split');
MatOriginal = vertcat(MatOriginal{:});
MA = char2num(MatOriginal)

MatOriginal = regexp(fileread('Segmented1.txt'), '\r?\n', 'split');
MatOriginal = vertcat(MatOriginal{:});
M1 = char2num(MatOriginal)

MatOriginal = regexp(fileread('Segmented2.txt'), '\r?\n', 'split');
MatOriginal = vertcat(MatOriginal{:});
M2 = char2num(MatOriginal)

MatOriginal = regexp(fileread('Segmented3.txt'), '\r?\n', 'split');
MatOriginal = vertcat(MatOriginal{:});
M3 = char2num(MatOriginal)

%%
number1 = load('p_dataset_26/Sample1/img002-00001.mat')
number2 = load('p_dataset_26/Sample2/img003-00001.mat')
number3 = load('p_dataset_26/Sample3/img004-00001.mat')
numbera = load('p_dataset_26/SampleA/img011-00001.mat')
numberb = load('p_dataset_26/SampleB/img012-00001.mat')
numberc = load('p_dataset_26/SampleC/img013-00001.mat')
n1 = load('train_1.txt')
n2 = load('train_2.txt')
n3 = load('train_3.txt')
na = load('train_A.txt')
nb = load('train_B.txt')
nc = load('train_C.txt')
n1_t = load('test_1.txt')
n2_t = load('test_2.txt')
n3_t = load('test_3.txt')
na_t = load('test_A.txt')
nb_t = load('test_B.txt')
nc_t = load('test_C.txt')
n = [n1;n2;n3;na;nb;nc]
n_t = [n1_t; n2_t; n3_t; na_t; nb_t; nc_t]

%%
% M1 = cell2mat(struct2cell(load('/home/ryan/mv_project/1.mat')))
% M2 = cell2mat(struct2cell(load('/home/ryan/mv_project/2.mat')))
% M3 = cell2mat(struct2cell(load('/home/ryan/mv_project/3.mat')))
%MA = cell2mat(struct2cell(load('/home/ryan/mv_project/A.mat')))
%MB = cell2mat(struct2cell(load('/home/ryan/mv_project/B.mat')))
%MC = cell2mat(struct2cell(load('/home/ryan/mv_project/C.mat')))
% For matrix 1: 15x6 -> 26x26
M1 = M1(:,1:5)
M1_left = zeros(15,10)
M1_right = zeros(15,11)
M1 = cat(2, M1_right,M1)
M1 = cat(2, M1,M1_left)
M1_stretch = repmat(M1(8,:),7,1)  
M1 = cat(1,M1,M1_stretch)
M1_up = zeros(26,1)
M1_down = zeros(3,26)
N1_new = zeros(26,26)
N1_new(1,:) = M1_up
N1_new(2:23,:) = M1
N1_new(24:end,:) = M1_down
N_1 = imadjust(N1_new,[0.01 0.02],[0 1])
N1 = imcomplement(N_1)
N1 = N1.*255
N1_test = reshape(N1,1,[])

M2_left = zeros(15,9)
M2_right = zeros(15,8)
M2 = cat(2,M2_left,M2)
M2 = cat(2,M2,M2_right)
N2_up = zeros(6,26)
N2_down = zeros(5,26)
N2_new = zeros(26,26)
N2_new(1:6,:) = N2_up
N2_new(7:21,:)= M2
N2_new(22:end,:)=N2_down
N_2 = imadjust(N2_new,[0.01 0.02],[0 1])
N2 = imcomplement(N_2)
N2 = N2.*255
N2_test = reshape(N2,1,[])

M3_left = zeros(15,8)
M3_right = zeros(15,8)
M3 = cat(2,M3_left,M3)
M3 = cat(2,M3,M3_right)
N3_up = zeros(6,26)
N3_down = zeros(5,26)
N3_new = zeros(26,26)
N3_new(1:6,:) = N3_up
N3_new(7:21,:)= M3
N3_new(22:end,:)=N3_down
N_3 = imadjust(N3_new,[0.01 0.02],[0 1])
N3 = imcomplement(N_3)
N3 = N3.*255
N3_test = reshape(N3,1,[])


Ma_left = zeros(15,7)
Ma_right = zeros(15,8)
Ma = cat(2,Ma_left,MA)
Ma = cat(2,Ma,Ma_right)
Na_up = zeros(6,26)
Na_down = zeros(5,26)
Na_new = zeros(26,26)
Na_new(1:6,:) = Na_up
Na_new(7:21,:)= Ma
Na_new(22:end,:)=Na_down
N_a = imadjust(Na_new,[0.01 0.02],[0 1])
Na = imcomplement(N_a)
Na = Na.*255
Na_test = reshape(Na,1,[])


Mb_left = zeros(15,7)
Mb_right = zeros(15,7)
Mb = cat(2,Mb_left,MB)
Mb = cat(2,Mb,Mb_right)
Nb_up = zeros(6,26)
Nb_down = zeros(5,26)
Nb_new = zeros(26,26)
Nb_new(1:6,:) = Nb_up
Nb_new(7:21,:)= Mb
Nb_new(22:end,:)=Nb_down
N_b = imadjust(Nb_new,[0.01 0.02],[0 1])
Nb = imcomplement(N_b)
Nb = Nb.*255
Nb_test = reshape(Nb,1,[])


%% Mc_left is the column added on the left side of original image
% Mc_right... right

Mc_left = zeros(15,7)
Mc_right = zeros(15,7)
Mc = cat(2,Mc_left,MC)
Mc = cat(2,Mc,Mc_right)
Nc_up = zeros(6,26)
Nc_down = zeros(5,26)
Nc_new = zeros(26,26)
Nc_new(1:6,:) = Nc_up
Nc_new(7:21,:)= Mc
Nc_new(22:end,:)=Nc_down
N_c = imadjust(Nc_new,[0.01 0.02],[0 1])
Nc = imcomplement(N_c)
Nc = Nc.*255
Nc_test = reshape(Nc,1,[])







