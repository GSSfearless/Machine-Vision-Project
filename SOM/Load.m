%%%%%%%%%%%%% 2021/10/15 Gan Runze %%%%%%%%%%%%%%%

%%
clear;clc

%Let's make a waitbar
h =waitbar(0,'Please Wait')

%makeing prefix to loading data
prefix_1=('/home/ryan/Downloads/p_dataset_26/Sample1/')
d_1 = dir([prefix_1,'*.mat'])
prefix_2=('/home/ryan/Downloads/p_dataset_26/Sample2/')
d_2 = dir([prefix_2,'*.mat'])
prefix_3=('/home/ryan/Downloads/p_dataset_26/Sample3/')
d_3 = dir([prefix_3,'*.mat'])
prefix_A=('/home/ryan/Downloads/p_dataset_26/SampleA/')
d_A = dir([prefix_A,'*.mat'])
prefix_B=('/home/ryan/Downloads/p_dataset_26/SampleB/')
d_B = dir([prefix_B,'*.mat'])
prefix_C=('/home/ryan/Downloads/p_dataset_26/SampleC/')
d_C = dir([prefix_C,'*.mat'])

%%%%%%%%%%%%%%%%%Transform struct format into matrix format%%%%%%%%%%%%%%

%Initialize the data
data = zeros(6*1026*26,26)

%Six loop to transform struct format data into matrix format data
K_1 = 0

for i=1:1016
    t_1(i)=load([prefix_1,d_1(i).name])
        if i == 1
            data(1:26,:) = cell2mat(struct2cell(t_1(i)))
        
        else
            data((i-1)*26+1:i*26,:) = cell2mat(struct2cell(t_1(i)))
        end
    str = ['Runing on Sample 1  :',num2str(i/1016*100),'%']
    waitbar(i/1016,h,str)
end


K_2 = 26*1016*1

for i=1:1016
    t_2(i)=load([prefix_2,d_2(i).name])
        if i == 1
            data(K_2+1:K_2+26,:) = cell2mat(struct2cell(t_2(i)))
        
        else
            data((i-1)*26+K_2+1:i*26+K_2,:) = cell2mat(struct2cell(t_2(i)))
        end
    str = ['Runing on Sample 2  :',num2str(i/1016*100),'%']
    waitbar(i/1016,h,str)
end


K_3 = 26*1016*2

for i=1:1016
    t_3(i)=load([prefix_3,d_3(i).name])
        if i == 1
            data(K_3+1:K_3+26,:) = cell2mat(struct2cell(t_3(i)))
            
        else
            data((i-1)*26+K_3+1:i*26+K_3,:) = cell2mat(struct2cell(t_3(i)))
        end
    str = ['Runing on Sample 3  :',num2str(i/1016*100),'%']
    waitbar(i/1016,h,str)        
end


A = 26*1016*3

for i=1:1016
    t_A(i)=load([prefix_A,d_A(i).name])
        if i == 1
            data(A+1:A+26,:) = cell2mat(struct2cell(t_A(i)))
            
        else
            data((i-1)*26+A+1:i*26+A,:) = cell2mat(struct2cell(t_A(i)))
        end
    str = ['Runing on Sample A  :',num2str(i/1016*100),'%']
    waitbar(i/1016,h,str)        
end


B = 26*1016*4

for i=1:1016
    t_B(i)=load([prefix_B,d_B(i).name])
        if i == 1
            data(B+1:B+26,:) = cell2mat(struct2cell(t_B(i)))
            
        else
            data((i-1)*26+B+1:i*26+B,:) = cell2mat(struct2cell(t_B(i)))
        end
    str = ['Runing on Sample B  :',num2str(i/1016*100),'%']
    waitbar(i/1016,h,str)      
end

C = 26*1016*5

for i=1:1016
    t_C(i)=load([prefix_C,d_C(i).name])
        if i == 1
            data(C+1:C+26,:) = cell2mat(struct2cell(t_C(i)))
            
        else
            data((i-1)*26+C+1:i*26+C,:) = cell2mat(struct2cell(t_C(i)))
        end
    str = ['Runing on Sample C  :',num2str(i/1016*100),'%']
    waitbar(i/1016,h,str)        
end

delete(h)
%%%%%%%%%%%%%%%%%%%%% Save the data in txt format %%%%%%%%%%%%%%%%%%%%%%%%%
save train_backup.txt -ascii data

fid = fopen('train.txt','wt')
[M,N]=size(data)
for i = 1:1:M
    for j =1:1:N
        if j==N
            fprintf(fid,'%g\n',data(i,j));
        else
            fprintf(fid,'%g\t',data(i,j));
        end
    end
end
fclose(fid)


