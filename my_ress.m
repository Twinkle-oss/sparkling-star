clc;
clear all
close all
rand('state',1)
%ѵ��Ԥ������
[input_train,output_train,input_test,output_test]=online_dataproduce();
%���ݹ�һ��
[inputn,mininput,maxinput,outputn,minoutput,maxoutput]=premnmx(input_train,output_train); %��p��t�����ֱ�׼��Ԥ���� 
X=inputn';Y=outputn';
X=[ones(size(X,1),1) X]; % ��ԭ���ķ����ʽ����Y=X�£�ע����ǰ���1��Ҫ����
alpha=0.95;%���Ŷȣ�
B=regress(Y,X,1-alpha);    %�������Իع����(B�ĵ�һ����Ϊ������)
%���ݹ�һ��
inputn_test = tramnmx(input_test,mininput,maxinput);inputn_test=inputn_test';
inputn_test=[ones(size(inputn_test,1),1) inputn_test];
an=inputn_test*B;
test_simu=postmnmx(an,minoutput,maxoutput);test_simu=test_simu';

inputn_train = tramnmx(input_train,mininput,maxinput);inputn_train=inputn_train';
inputn_train=[ones(size(inputn_train,1),1) inputn_train];
an=inputn_train*B;
train_simu=postmnmx(an,minoutput,maxoutput);train_simu=train_simu';
%% ��ͼ�Ա�  
    figure                        %��ͼ
plot(test_simu,'r*-')                %����Ԥ��ֵ����
hold on                       %������ͼ
plot(output_test,'bo-')                  %ʵ��ֵ����
legend('Ԥ��ֵ','ʵ��ֵ')      %ͼ��
grid on
xlabel('�������')
ylabel('���')
string_1 = {['��������Ԥ�����Ա�'  '  mse='  num2str(mse(test_simu-output_test))];};
title(string_1)

R2_test=(min(min(corrcoef(test_simu, output_test))))^2;
rmse_test=sqrt(mse(test_simu-output_test));
mbe_test=mean(abs(test_simu-output_test)./test_simu);

figure                        %��ͼ
plot(train_simu,'r*-')                %����Ԥ��ֵ����
hold on                       %������ͼ
plot(output_train,'bo')                  %ʵ��ֵ����
legend('Ԥ��ֵ','ʵ��ֵ')      %ͼ��
grid on
xlabel('�������')
ylabel('���')
string_1 = {['ѵ��������Ͻ���Ա�,' '  mse='  num2str(mse(train_simu-output_train))];};
title(string_1)

