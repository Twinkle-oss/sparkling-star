clc;
clear all
close all
rand('state',1)
%训练预测数据
[input_train,output_train,input_test,output_test]=online_dataproduce();
%数据归一化
[inputn,mininput,maxinput,outputn,minoutput,maxoutput]=premnmx(input_train,output_train); %对p和t进行字标准化预处理 
X=inputn';Y=outputn';
X=[ones(size(X,1),1) X]; % 将原来的方表达式化成Y=Xβ，注意最前面的1不要丢了
alpha=0.95;%置信度，
B=regress(Y,X,1-alpha);    %调用线性回归程序(B的第一个数为常数项)
%数据归一化
inputn_test = tramnmx(input_test,mininput,maxinput);inputn_test=inputn_test';
inputn_test=[ones(size(inputn_test,1),1) inputn_test];
an=inputn_test*B;
test_simu=postmnmx(an,minoutput,maxoutput);test_simu=test_simu';

inputn_train = tramnmx(input_train,mininput,maxinput);inputn_train=inputn_train';
inputn_train=[ones(size(inputn_train,1),1) inputn_train];
an=inputn_train*B;
train_simu=postmnmx(an,minoutput,maxoutput);train_simu=train_simu';
%% 绘图对比  
    figure                        %绘图
plot(test_simu,'r*-')                %绘制预测值曲线
hold on                       %继续绘图
plot(output_test,'bo-')                  %实际值曲线
legend('预测值','实际值')      %图例
grid on
xlabel('样本编号')
ylabel('输出')
string_1 = {['测试样本预测结果对比'  '  mse='  num2str(mse(test_simu-output_test))];};
title(string_1)

R2_test=(min(min(corrcoef(test_simu, output_test))))^2;
rmse_test=sqrt(mse(test_simu-output_test));
mbe_test=mean(abs(test_simu-output_test)./test_simu);

figure                        %绘图
plot(train_simu,'r*-')                %绘制预测值曲线
hold on                       %继续绘图
plot(output_train,'bo')                  %实际值曲线
legend('预测值','实际值')      %图例
grid on
xlabel('样本编号')
ylabel('输出')
string_1 = {['训练样本拟合结果对比,' '  mse='  num2str(mse(train_simu-output_train))];};
title(string_1)

