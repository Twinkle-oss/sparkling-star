function [MIX_train,MIX_test,DATA_train,DATA_test]=online_dataproduce()
%提取数据的输入、输出
data=xlsread('data.xlsx');
N=size(data,1);n=floor(N*0.8);order=randperm(N);
MIX_train=data(order(1:n),1:end-1)';%训练集输入
DATA_train=data(order(1:n),end)';%训练集输出

MIX_test=data(order(n+1:end),1:end-1)';%测试集输入
DATA_test=data(order(n+1:end),end)';%测试集输出
end