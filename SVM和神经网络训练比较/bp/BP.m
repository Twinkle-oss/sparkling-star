%读取数据
clc
clear
close all
warning off
rand('state',10)
%训练预测数据
[input_train,input_test,output_train,output_test]=online_dataproduce();
%数据归一化
[inputn,mininput,maxinput,outputn,minoutput,maxoutput]=premnmx(input_train,output_train); %对p和t进行字标准化预处理 
N=floor(sqrt(size(input_train,2)))+1;%经验公式计算隐层神经元节点数
net=newff(minmax(inputn),[N,size(output_test,1)],{'tansig','purelin'},'trainlm');%N隐层结点数，'tansig','purelin'传递函数，'trainlm'训练函数
%trangdm 带动量的梯度下降
net.trainParam.epochs=500;%迭代次数
net.trainParam.lr=0.01;%学习率
net.trainParam.goal=0.000001;%目标精度
net.trainParam.mc=0.9;%动量因子

%网络训练
net=train(net,inputn,outputn);%对训练数据进行训练
InputWeights=net.iw{1,1};%提取出权值
LayerWeights=net.lw{2,1};
bias1=net.b{1};%提取出阈值
bias2=net.b{2};
save net;
%测试集
inputn_test = tramnmx(input_test,mininput,maxinput);
an=sim(net,inputn_test);
test_simu=postmnmx(an,minoutput,maxoutput);
test_simu=round(test_simu);test_simu(test_simu>3)=3;test_simu(test_simu<1)=1;
%训练集
inputn_train = tramnmx(input_train,mininput,maxinput);
an=sim(net,inputn_train);
train_simu=postmnmx(an,minoutput,maxoutput);
train_simu=round(train_simu);train_simu(train_simu>3)=3;train_simu(train_simu<1)=1;
%% 绘图对比      
figure                        %绘图
plot(test_simu,'r*-')                %绘制预测值曲线
hold on                       %继续绘图
plot(output_test,'bo')                  %实际值曲线
legend('预测值','实际值')      %图例
grid on
xlabel('样本编号')
ylabel('输出')
string_1 = {'测试集预测结果对比';
          };
title(string_1)
disp(['测试集准确率:' num2str(sum(test_simu==output_test)/length(test_simu)*100) '%'])

figure                        %绘图
plot(train_simu,'r*-')                %绘制预测值曲线
hold on                       %继续绘图
plot(output_train,'bo')                  %实际值曲线
legend('预测值','实际值')      %图例
grid on
xlabel('样本编号')
ylabel('输出')
string_1 = {'训练集预测结果对比';
          };
title(string_1)
disp(['训练集准确率:' num2str(sum(train_simu==output_train)/length(train_simu)*100) '%'])

save result1.mat train_simu test_simu