%��ȡ����
clc
clear
close all
warning off
rand('state',10)
%ѵ��Ԥ������
[input_train,input_test,output_train,output_test]=online_dataproduce();
%���ݹ�һ��
[inputn,mininput,maxinput,outputn,minoutput,maxoutput]=premnmx(input_train,output_train); %��p��t�����ֱ�׼��Ԥ���� 
N=floor(sqrt(size(input_train,2)))+1;%���鹫ʽ����������Ԫ�ڵ���
net=newff(minmax(inputn),[N,size(output_test,1)],{'tansig','purelin'},'trainlm');%N����������'tansig','purelin'���ݺ�����'trainlm'ѵ������
%trangdm ���������ݶ��½�
net.trainParam.epochs=500;%��������
net.trainParam.lr=0.01;%ѧϰ��
net.trainParam.goal=0.000001;%Ŀ�꾫��
net.trainParam.mc=0.9;%��������

%����ѵ��
net=train(net,inputn,outputn);%��ѵ�����ݽ���ѵ��
InputWeights=net.iw{1,1};%��ȡ��Ȩֵ
LayerWeights=net.lw{2,1};
bias1=net.b{1};%��ȡ����ֵ
bias2=net.b{2};
save net;
%���Լ�
inputn_test = tramnmx(input_test,mininput,maxinput);
an=sim(net,inputn_test);
test_simu=postmnmx(an,minoutput,maxoutput);
test_simu=round(test_simu);test_simu(test_simu>3)=3;test_simu(test_simu<1)=1;
%ѵ����
inputn_train = tramnmx(input_train,mininput,maxinput);
an=sim(net,inputn_train);
train_simu=postmnmx(an,minoutput,maxoutput);
train_simu=round(train_simu);train_simu(train_simu>3)=3;train_simu(train_simu<1)=1;
%% ��ͼ�Ա�      
figure                        %��ͼ
plot(test_simu,'r*-')                %����Ԥ��ֵ����
hold on                       %������ͼ
plot(output_test,'bo')                  %ʵ��ֵ����
legend('Ԥ��ֵ','ʵ��ֵ')      %ͼ��
grid on
xlabel('�������')
ylabel('���')
string_1 = {'���Լ�Ԥ�����Ա�';
          };
title(string_1)
disp(['���Լ�׼ȷ��:' num2str(sum(test_simu==output_test)/length(test_simu)*100) '%'])

figure                        %��ͼ
plot(train_simu,'r*-')                %����Ԥ��ֵ����
hold on                       %������ͼ
plot(output_train,'bo')                  %ʵ��ֵ����
legend('Ԥ��ֵ','ʵ��ֵ')      %ͼ��
grid on
xlabel('�������')
ylabel('���')
string_1 = {'ѵ����Ԥ�����Ա�';
          };
title(string_1)
disp(['ѵ����׼ȷ��:' num2str(sum(train_simu==output_train)/length(train_simu)*100) '%'])

save result1.mat train_simu test_simu