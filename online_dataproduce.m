function [MIX_train,DATA_train,MIX_test,DATA_test]=online_dataproduce()
%���ݴ����Լ���ȡ�����ݼ��������
data=xlsread('data.xlsx');N=size(data,1);
num=floor(0.8*N);order=randperm(N);
MIX_train=data(order(1:num),1:end-1)';%ѵ��������
DATA_train=data(order(1:num),end)';%ѵ�������
MIX_test=data(order(num+1:end),1:end-1)';%���Լ�����
DATA_test=data(order(num+1:N),end)';%���Լ����
%% ���ӻ�
figure
plot3(data(:,1),data(:,2),data(:,3),'r*')
xlabel('x����')
ylabel('y����')
zlabel('z����')
grid on
end