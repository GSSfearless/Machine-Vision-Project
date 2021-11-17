
%%
%clc; clear all; close all;
clear;clc;close all
% tic;
% %location 
% 
% path_train='train.txt';
% train_label = repmat(1,1,676)
% test_label = repmat(1,1,676)
% train_data = load(path_train);
% [data_row,data_clown]=size(train_data);
% 
% 
% %s1 = struct('train_data_1',train_data_1,'train_label_1',train_label_1,'test_data_1',test_data_1,'test_label_1',test_label_1)
% 
% 
% 
% %SOM network m*n
% m=10;
% n=10;
% %Neuron som_sum
% som_sum=m*n;
% %weight initialize 
% w = rand(som_sum, data_clown);
% %Initialize learning rate
% learn0 = 0.6;
% learn_rate = learn0;
% %learning para
% learn_para=100;
% %Setting iteration 
% iter = 100;%1000 500
% %Neuron location
% [I,J] = ind2sub([m, n], 1:som_sum);
% %Neighbor Initialize
% neighbor0 =2;
% neighbor_redius = neighbor0;
% %Neighbor parameters
% neighbor_para = 1000/log(neighbor0);
% 
% for t=1:iter 
%     %  Scan all the sample points
%     display(['Iteration: ' num2str(t)]);
%     for j=1:data_row  
%         %Getting the winner neuron
%         data_x = train_data(j,:); 
%         %Find the winner neuron
%         [win_row, win_som_index]=min(dist(data_x,w'));  
%         %Find the winner neuron position
%         [win_som_row,win_som_cloumn] =  ind2sub([m, n],win_som_index);
%         win_som=[win_som_row,win_som_cloumn];
%         %Calculate and update the winner neuron neighbourhood position 
%         %distance_som = sum(( ([I( : ), J( : )] - repmat(win_som, som_sum,1)) .^2) ,2);
%         distance_som = exp( sum(( ([I( : ), J( : )] - repmat(win_som, som_sum,1)) .^2) ,2)/(-2*neighbor_redius*neighbor_redius)) ;
%         %Update the weights
%         for i = 1:som_sum
%            % if distance_som(i)<neighbor_redius*neighbor_redius 
%             w(i,:) = w(i,:) + learn_rate.*distance_som(i).*( data_x - w(i,:));
%         end
%     end
%  
%     %Updateing the learning rate
%     learn_rate = learn0 * exp(-t/learn_para);   
%     %Update the neighbor radius
%     neighbor_redius = neighbor0*exp(-t/neighbor_para);  
% end
% 
% 
% 
% %save as som_num
% som_num=cell(1,size(w,1));
% for i=1:size(w,1)
%     som_num{1,i}=[];
% end
% %Every neuron data corresponding number
% for num=1:data_row
%     [som_row,clown]= min(sum(( (w - repmat(train_data(num,:), som_sum,1)) .^2) ,2));
%     som_num{1,clown}= [som_num{1,clown},num];    
% end
% 
% 
% path1='som_num_1.mat';
% save(path1,'som_num');
% toc;
%%
number1 = load('p_dataset_26/Sample1/img002-00001.mat')
number2 = load('p_dataset_26/Sample2/img003-00001.mat')
number3 = load('p_dataset_26/Sample3/img004-00001.mat')
numbera = load('p_dataset_26/SampleA/img011-00001.mat')
numberb = load('p_dataset_26/SampleB/img012-00001.mat')
numberc = load('p_dataset_26/SampleC/img013-00001.mat')
%%
fid = fopen('charact1.txt');
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
N_3_pad_0 = zeros(26,26)
N_3_pad_0(1:4,:) = N_3(1:4,:)
N_3_pad_0(5:11,:) = N_3_up
N_3_pad_0(12:15,:) = N_3(6:9,:)
N_3_pad_0(16:22,:) =N_3_low
N_3_pad_0(23:26,:) = N_3(11:14,:)
N_3_pad_0 = imadjust(N_3_pad_0,[0.01 0.02],[0 1])
N_3_pad_0= imcomplement(N_3_pad_0)
N_3_pad_0 = N_3_pad_0.*255
N3_pad_0 = reshape(N_3_pad_0,1,[])


N_3_up_2 = repmat(N_3(5,:),5,1)
N_3_low_2 = repmat(N_3(9,:),5,1)
N_3_pad_2 = zeros(26,26)
N_3_pad_2(1:2,:) = zeros(2,26)
N_3_pad_2(3:6,:)= N_3(1:4,:)
N_3_pad_2(7:11,:) = N_3_up_2
N_3_pad_2(12:15,:)= N_3(6:9,:)
N_3_pad_2(16:20,:)= N_3_low_2
N_3_pad_2(21:24,:)= N_3(11:14,:)
N_3_pad_2(25:26,:)= zeros(2,26)
N_3_pad_2 = imadjust(N_3_pad_2,[0.01 0.02],[0 1])
N_3_pad_2= imcomplement(N_3_pad_2)
N_3_pad_2 = N_3_pad_2.*255
N3_pad_2 = reshape(N_3_pad_2,1,[])



N_3_up_3 = repmat(N_3(5,:),4,1)
N_3_low_3 = repmat(N_3(9,:),4,1)
N_3_pad_3 = zeros(26,26)
N_3_pad_3(1:3,:) = zeros(3,26)
N_3_pad_3(4:7,:)= N_3(1:4,:)
N_3_pad_3(8:11,:) = N_3_up_3
N_3_pad_3(12:15,:)= N_3(6:9,:)
N_3_pad_3(16:19,:)= N_3_low_3
N_3_pad_3(20:23,:)= N_3(11:14,:)
N_3_pad_3(24:26,:)= zeros(3,26)
N_3_pad_3 = imadjust(N_3_pad_3,[0.01 0.02],[0 1])
N_3_pad_3= imcomplement(N_3_pad_3)
N_3_pad_3 = N_3_pad_3.*255
N3_pad_3 = reshape(N_3_pad_3,1,[])




N_3_up_4 = repmat(N_3(5,:),3,1)
N_3_low_4 = repmat(N_3(9,:),3,1)
N_3_pad_4 = zeros(26,26)
N_3_pad_4(1:4,:) = zeros(4,26)
N_3_pad_4(5:8,:)= N_3(1:4,:)
N_3_pad_4(9:11,:) = N_3_up_4
N_3_pad_4(12:15,:)= N_3(6:9,:)
N_3_pad_4(16:18,:)= N_3_low_4
N_3_pad_4(19:22,:)= N_3(11:14,:)
N_3_pad_4(23:26,:)= zeros(4,26)
N_3_pad_4 = imadjust(N_3_pad_4,[0.01 0.02],[0 1])
N_3_pad_4= imcomplement(N_3_pad_4)
N_3_pad_4 = N_3_pad_4.*255
N3_pad_4 = reshape(N_3_pad_4,1,[])


N_3_up_5 = repmat(N_3(5,:),2,1)
N_3_low_5 = repmat(N_3(9,:),2,1)
N_3_pad_5 = zeros(26,26)
N_3_pad_5(1:5,:) = zeros(5,26)
N_3_pad_5(6:9,:)= N_3(1:4,:)
N_3_pad_5(10:11,:) = N_3_up_5
N_3_pad_5(12:15,:)= N_3(6:9,:)
N_3_pad_5(16:17,:)= N_3_low_5
N_3_pad_5(18:21,:)= N_3(11:14,:)
N_3_pad_5(22:26,:)= zeros(5,26)
N_3_pad_5 = imadjust(N_3_pad_5,[0.01 0.02],[0 1])
N_3_pad_5= imcomplement(N_3_pad_5)
N_3_pad_5 = N_3_pad_5.*255
N3_pad_5 = reshape(N_3_pad_5,1,[])



N_3_up_6 = repmat(N_3(5,:),1,1)
N_3_low_6 = repmat(N_3(9,:),1,1)
N_3_pad_6 = zeros(26,26)
N_3_pad_6(1:6,:) = zeros(6,26)
N_3_pad_6(7:10,:)= N_3(1:4,:)
N_3_pad_6(11,:) = N_3_up_6
N_3_pad_6(12:15,:)= N_3(6:9,:)
N_3_pad_6(16,:)= N_3_low_6
N_3_pad_6(17:20,:)= N_3(11:14,:)
N_3_pad_6(21:26,:)= zeros(6,26)
N_3_pad_6 = imadjust(N_3_pad_6,[0.01 0.02],[0 1])
N_3_pad_6= imcomplement(N_3_pad_6)
N_3_pad_6 = N_3_pad_6.*255
N3_pad_6 = reshape(N_3_pad_6,1,[])


N_3_pad_7 = zeros(26,26)
N_3_pad_7(1:7,:) = zeros(7,26)
N_3_pad_7(8:11,:)= N_3(1:4,:)
N_3_pad_7(12:15,:)= N_3(6:9,:)
N_3_pad_7(16:19,:)= N_3(11:14,:)
N_3_pad_7(20:26,:)= zeros(7,26)
N_3_pad_7 = imadjust(N_3_pad_7,[0.01 0.02],[0 1])
N_3_pad_7= imcomplement(N_3_pad_7)
N_3_pad_7 = N_3_pad_7.*255
N3_pad_7 = reshape(N_3_pad_7,1,[])



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
% inputs = n';
% dimension1 = 10;
% dimension2 = 10;
% net = selforgmap([dimension1 dimension2]);
% [net,tr] = train(net,inputs);
% view(net)
% y = net(inputs);
% %t=mapminmax(t);
% % sim( ) to do Network simulation
% % r=sim(net,t);
% % % 
% % rr=vec2ind(r)
% % Find the topology structure of the network
% plotsomtop(net)
% % plot the distance plot
% plotsomnd(net)
% % plot the classifier result
% plotsomhits(net,inputs)




