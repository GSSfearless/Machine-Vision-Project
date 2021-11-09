
%%
clc; clear all; close all;


%%
number1 = load('/home/ryan/p_dataset_26/Sample1/img002-00001.mat')
number2 = load('/home/ryan/p_dataset_26/Sample2/img003-00001.mat')
number3 = load('/home/ryan/p_dataset_26/Sample3/img004-00001.mat')
numbera = load('/home/ryan/p_dataset_26/SampleA/img011-00001.mat')
numberb = load('/home/ryan/p_dataset_26/SampleB/img012-00001.mat')
numberc = load('/home/ryan/p_dataset_26/SampleC/img013-00001.mat')
fid = fopen('/home/ryan/mv_project/charact1.txt');
% read a char at a time, ignore linefeed and carriage return
% and put them in a 64 X 64 matrix
lf = char(10); % line feed character
cr = char(13); % carriage return character
A = fscanf(fid, [cr lf '%c'],[64,64]);
% close the file handler
fclose(fid);
A = A'; % transpose since fscanf returns column vectors
% convert letters A‐V to their corresponding values in 32 gray levels
% literal A becomes number 10 and so on...
A(isletter(A))= A(isletter(A)) - 55;
%convert number literals 0‐9 to their corresponding values in 32 gray
%levels. Numeric literal '0' becomes number 0 and so on...
A(A >= '0' & A <= '9') = A(A >= '0' & A <= '9') - 48;
A = uint8(A);
M = A

% Preprocessing for test image
Add_1 = zeros(26,2)
N_1_o = M(1:26,1:24)
N_1 = cat(2,Add_1,N_1_o)
N_1_ad = imadjust(N_1,stretchlim(N_1),[])
Nb1 = imcomplement(N_1_ad)
N1 = reshape(Nb1,1,[])


N_2 = M(1:26, 22:47)
% N_2(1:2,:)=[]
% N_2(21:end,:)=[]
N_2_ad = imadjust(N_2,stretchlim(N_2),[])
Nb2 = imcomplement(N_2_ad)
N2 = reshape(Nb2,1,[])

Add_3 = zeros(26,4)
N_3_o = M(1:26, 43:64)
N_3 = cat(2,N_3_o,Add_3)
N_3(1:5,:)=[]
N_3(15:21,:)=[]
N_3_up = repmat(N_3(5,:),7,1)
N_3_low = repmat(N_3(9,:),7,1)
N_3_new = zeros(26,26)
N_3_new(1:4,:) = N_3(1:4,:)
N_3_new(5:11,:) = N_3_up
N_3_new(12:15,:) = N_3(6:9,:)
N_3_new(16:22,:) =N_3_low
N_3_new(23:26,:) = N_3(11:14,:)
%N_3_ad = imadjust(N_new,stretchlim(N_new),[])
N_3_ad = imadjust(N_3_new,[0.01 0.02],[0 1])
Nb3 = imcomplement(N_3_ad)
Nb3 = Nb3.*255
N3 = reshape(Nb3,1,[])

Add_a = zeros(26,2)
N_A_o = M(38:63, 1:24)
N_A = cat(2,Add_a,N_A_o)
N_a_ad = imadjust(N_A,stretchlim(N_A),[])
Na = imcomplement(N_a_ad)
NA = reshape(Na,1,[])


N_B = M(38:63, 20:45)
N_B(1,:)=[]
N_B(21:25,:)=[]
N_B_up= repmat(N_B(4,:),5,1)
N_B_low= repmat(N_B(11,:),5,1)
N_B_new = zeros(26,26)
N_B_new(1:3,:)=N_B(1:3,:)
N_B_new(4:6,:)= N_B(4:6,:)
N_B_new(7:11,:)= N_B_up
N_B_new(12:15,:)=N_B(9:12,:)
N_B_new(16:20,:)=N_B_low
N_B_new(21:26,:)=N_B(15:20,:)
N_b_ad = imadjust(N_B_new,[0.01 0.02],[0 1])
Nb = imcomplement(N_b_ad)
NB = reshape(Nb,1,[])

Add_C= zeros(26,1)
N_C = M(38:63, 40:64)
N_C = cat(2,N_C,Add_C)
N_C(1,:)=[]
N_C(21:end,:)=[]
N_C_mid = repmat(N_C(10,:),11,1)
N_C_new= zeros(26,26)
N_C_new(1:7,:)=N_C(1:7,:)
N_C_new(8:18,:)=N_C_mid
N_C_new(19:26,:)=N_C(13:20,:)
N_C_new(:,19:23)=zeros(26,5)
N_C_ad = imadjust(N_C_new,[0.01 0.02],[0 1])
Nc = imcomplement(N_C_ad)
Nc = Nc.*255
NC = reshape(Nc,1,[])

n1 = load('/home/ryan/mv_project/train_1.txt')
n2 = load('/home/ryan/mv_project/train_2.txt')
n3 = load('/home/ryan/mv_project/train_3.txt')
na = load('/home/ryan/mv_project/train_A.txt')
nb = load('/home/ryan/mv_project/train_B.txt')
nc = load('/home/ryan/mv_project/train_C.txt')
n1_t = load('/home/ryan/mv_project/test_1.txt')
n2_t = load('/home/ryan/mv_project/test_2.txt')
n3_t = load('/home/ryan/mv_project/test_3.txt')
na_t = load('/home/ryan/mv_project/test_A.txt')
nb_t = load('/home/ryan/mv_project/test_B.txt')
nc_t = load('/home/ryan/mv_project/test_C.txt')
n = [n1;n2;n3;na;nb;nc]
n_t = [n1_t; n2_t; n3_t; na_t; nb_t; nc_t]


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% inputs = n1';
% 
% dimension1 = 10;
% dimension2 = 10;
% net = selforgmap([dimension1 dimension2]);
% 
% [net,tr] = train(net,inputs);
% view(net)
% y = net(inputs);
% 
% %t=mapminmax(t);
% % sim( )来做网络仿真
% % r=sim(net,t);
% % % 变换函数 将单值向量转变成下标向量。
% % rr=vec2ind(r)
% 
% %% 网络神经元分布情况
% % 查看网络拓扑学结构
% plotsomtop(net)
% % 查看临近神经元直接的距离情况
% plotsomnd(net)
% % 查看每个神经元的分类情况
% plotsomhits(net,inputs)




