clc;
clear all
close all
rand('state',10)
%% 导入数据
[MIXtrain,MIXtest,DATAtrain,DATAtest]=online_dataproduce();
p_train = MIXtrain';
t_train = DATAtrain';

p_test = MIXtest'; 
t_test = DATAtest';
% 输入集
[pn_train,inputps] = mapminmax(p_train');
pn_train = pn_train';
pn_test = mapminmax('apply',p_test',inputps);
pn_test = pn_test';
% 输出集
% [tn_train,outputps] = mapminmax(t_train');
tn_train = t_train;
% tn_test = mapminmax('apply',t_test',outputps);
tn_test = t_test;
%% 网格算法寻优
%  [bestmse,bestc,bestg] = SVMcgForRegress(tn_train,pn_train,-5,5,-5,5,5,0.5,0.5,0.05);%参数可改
% cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg),' -s 0 -p 0.01'];%t 核函数类型 p不敏感损失函数系数 s 支持向量机类型 
cmd = [' -t 2',' -s 0 -p 0.01'];
%参数设置参考网站：http://blog.sina.com.cn/s/blog_57a1cae80101bit5.html
model = svmtrain(tn_train,pn_train,cmd);

%% SVM仿真预测
[Predict_1,error_1,tt1] = svmpredict(tn_train,pn_train,model);
[Predict_2,error_2,tt2] = svmpredict(tn_test,pn_test,model);
%% 绘图
figure
plot(1:length(t_test),Predict_2,'r-*',1:length(t_test),t_test,'b:o')
grid on
legend('预测值','真实值')
xlabel('样本编号')
ylabel('类别')

string_2 = {'测试集预测类型对比';
           ['准确率 = ' num2str(error_2(1))]};
title(string_2)

figure
plot(1:length(t_train),Predict_1,'r-*',1:length(t_train),t_train,'b:o')
grid on
legend('预测值','真实值')
xlabel('样本编号')
ylabel('类别')

string_2 = {'训练集预测类型对比';
           ['准确率 = ' num2str(error_1(1))]};
title(string_2)
save result2.mat Predict_1 Predict_2 t_train t_test
%% 预测额外样本标签
% data=xlsread('data_pred.xlsx');
% data = mapminmax('apply',data',inputps);
% data = data';
% Predict_3 = svmpredict(ones(size(data,1),1),data,model);
% disp(['预测类别为：' num2str(Predict_3')])












