function [MIX_train,MIX_test,DATA_train,DATA_test]=online_dataproduce()
%��ȡ���ݵ����롢���
data=xlsread('data.xlsx');
N=size(data,1);n=floor(N*0.8);order=randperm(N);
MIX_train=data(order(1:n),1:end-1)';%ѵ��������
DATA_train=data(order(1:n),end)';%ѵ�������

MIX_test=data(order(n+1:end),1:end-1)';%���Լ�����
DATA_test=data(order(n+1:end),end)';%���Լ����
end