clc
clear all
close all
load result1.mat
load result2.mat
train_acc1=sum(t_train'==train_simu)/length(t_train);%bp 
train_acc2=sum(t_train==Predict_1)/length(t_train);%svm
test_acc1=sum(t_test'==test_simu)/length(t_test);%bp 
test_acc2=sum(t_test==Predict_2)/length(t_test);%svm

figure
plot(1:length(t_test),Predict_2,'r-*',1:length(t_test),t_test,'b:o',1:length(t_test),test_simu,'k-*')
grid on
legend('svmԤ��ֵ','��ʵֵ','bpԤ��ֵ')
xlabel('�������')
ylabel('���')

string_2 = {'���Լ�Ԥ�����ͶԱ�';
           ['svm׼ȷ�� = ' num2str(test_acc2*100)];
           ['bp׼ȷ�� = ' num2str(test_acc1*100)];};
title(string_2)

figure
plot(1:length(t_train),Predict_1,'r-*',1:length(t_train),t_train,'b:o',1:length(t_train),train_simu,'k-*')
grid on
legend('svmԤ��ֵ','��ʵֵ','bpԤ��ֵ')
xlabel('�������')
ylabel('���')

string_2 = {'ѵ����Ԥ�����ͶԱ�';
           ['svm׼ȷ�� = ' num2str(train_acc2*100)];
           ['bp׼ȷ�� = ' num2str(train_acc1*100)]};
title(string_2)