function [MIX_train,DATA_train,MIX_test,DATA_test]=online_dataproduce()
%数据处理以及提取各数据集输入输出
data=xlsread('data.xlsx');N=size(data,1);
num=floor(0.8*N);order=randperm(N);
MIX_train=data(order(1:num),1:end-1)';%训练集输入
DATA_train=data(order(1:num),end)';%训练集输出
MIX_test=data(order(num+1:end),1:end-1)';%测试集输入
DATA_test=data(order(num+1:N),end)';%测试集输出
%% 可视化
figure
plot3(data(:,1),data(:,2),data(:,3),'r*')
xlabel('x坐标')
ylabel('y坐标')
zlabel('z坐标')
grid on
end