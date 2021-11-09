%%
%%Gan Runze 2021/10/14 SOM
% 1.Competition：Match the best neuron---------->Calculate every neuron with
% the target, choose the min difference one as the best
% 2.Coorporation ：In the updateing process, not only the best neuron update, but also the neighbourhood 
%will update in the form of function.
% Algorithm:
% 1.Initialize 
%    1)Iteration：time step iter
%    2)MxN size intial network
%    3)Initialize learning rate
%    4)The neighbour radius
% 2.Find the winner by Euclidean distance(the minimum is the winner)
% 3.weights update：
%        For the winner and the neighbours number of m to update ，j=1:m；    
%            wj(t+1)=wj(t)+learnfun(t)*neighborfun(t)*(x-wj);
% 4.Update learning rate, and update the neighbourfun(t):
%        neighborfun(t)=neighbor0*exp(-dij/t1);   t1=iter/log(neighbor0)
%         learnfun(t)=learn0*exp(-t/t2);     t2=iter
% 5.Go to step 2 until Reach the max iteration steps
clear;clc;close all
tic;
%location 
file_path='/home/ryan/';
path_train=strcat(file_path,'train_C.txt');
path_test = strcat(file_path,'train_C.txt');
train_label_1 = repmat(1,1,676)
test_label_1 = repmat(1,1,676)

train_data_1 = load(path_train);
test_data_1 = load(path_test);

[data_row,data_clown]=size(train_data_1);

s1 = struct('train_data_C',train_data_1,'train_label_C',train_label_1,'test_data_C',test_data_1,'test_label_C',test_label_1)



%SOM network m*n
m=10;
n=10;
%Neuron som_sum
som_sum=m*n;
%weight initialize 
w = rand(som_sum, data_clown);
%Initialize learning rate
learn0 = 0.6;
learn_rate = learn0;
%learning para
learn_para=100;
%设置迭代次数
iter =200;%1000 500
%神经元位置
[I,J] = ind2sub([m, n], 1:som_sum);
%邻域初始化 
neighbor0 =2;
neighbor_redius = neighbor0;
%邻域参数
neighbor_para = 1000/log(neighbor0);

%迭代次数
for t=1:iter 
    %  样本点遍历
    display(['Iteration: ' num2str(t)]);
    for j=1:data_row  
        %获取样本点值
        data_x = train_data_1(j,:); 
        %找到获胜神经元
        [win_row, win_som_index]=min(dist(data_x,w'));  
        %获胜神经元的拓扑位置
        [win_som_row,win_som_cloumn] =  ind2sub([m, n],win_som_index);
        win_som=[win_som_row,win_som_cloumn];
        %计算其他神经元和获胜神经元的距离,邻域函数
        %distance_som = sum(( ([I( : ), J( : )] - repmat(win_som, som_sum,1)) .^2) ,2);
        distance_som = exp( sum(( ([I( : ), J( : )] - repmat(win_som, som_sum,1)) .^2) ,2)/(-2*neighbor_redius*neighbor_redius)) ;
        %权值更新
        for i = 1:som_sum
           % if distance_som(i)<neighbor_redius*neighbor_redius 
            w(i,:) = w(i,:) + learn_rate.*distance_som(i).*( data_x - w(i,:));
        end
    end
 
    %更新学习率
    learn_rate = learn0 * exp(-t/learn_para);   
    %更新邻域半径
    neighbor_redius = neighbor0*exp(-t/neighbor_para);  
end
%data数据在神经元的映射
%神经元数组som_num存储图像编号
som_num=cell(1,size(w,1));
for i=1:size(w,1)
    som_num{1,i}=[];
end
%每个神经元节点对应的data样本编号
for num=1:data_row
    [som_row,clown]= min(sum(( (w - repmat(train_data_1(num,:), som_sum,1)) .^2) ,2));
    som_num{1,clown}= [som_num{1,clown},num];    
end
%imshow(double(som_num))



% figure()
% subplot(3,2,1)
% plot(trainX(1,:),trainX(2,:),'+')
% hold on
% for i=1:N
%     plot(ww(1,(N*i-N+1):N*i),ww(2,(N*i-N+1):N*i),'-ok')
%     plot(ww(1,i:N:M*N),ww(2,i:N:M*N),'-ok')
% end
% title(['Iteration=',num2str(0)])
% for j=2:6
% subplot(3,2,j)
% plot(trainX(1,:),trainX(2,:),'+')
% hold on
% for i=1:N
%     plot(ww(2*j-1,(N*i-N+1):N*i),ww(2*j,(N*i-N+1):N*i),'-ok')
%     plot(ww(2*j-1,i:N:M*N),ww(2*j,i:N:M*N),'-ok')
% end
% title(['Iteration=',num2str(w_iteration(j-1))])
% end



%save neuron format，.mat格式




path1=strcat(file_path,'som_num_C.mat');
save(path1,'som_num');
toc;
