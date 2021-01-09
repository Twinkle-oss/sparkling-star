 function [acc,bestc,bestg] = SVMcgForRegress(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,msestep)
      %SVMcg cross validation by faruto
      %cmin,cmax, 参数c最小值最大值
      %cstep,gstep,msestep 步长
      if nargin < 10
      msestep = 0.06;
      end
      if nargin < 8
      cstep = 0.8;
      gstep = 0.8;
      end
      if nargin < 7
      v = 5;
      end
      if nargin < 5
      gmax = 8;
      gmin = -8;
      end
      if nargin < 3
      cmax = 8;
      cmin = -8;
      end

      [X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
      [m,n] = size(X);
      cg = zeros(m,n);

      eps = 10^(-4);

      bestc = 0;
      bestg = 0;
      acc = -Inf;
      basenum = 2;
      for i = 1:m
      for j = 1:n
      cmd = ['-v ',num2str(v),' -c ',num2str( basenum^X(i,j) ),' -g ',num2str( basenum^Y(i,j) ),' -s 0 -p 0.01 -t 2 -h 0'];
      cg(i,j) = svmtrain(train_label, train, cmd);
%       [~,error_2,~] = svmpredict(tn_test,pn_test,model);cg(i,j)=error_2(1);

      if cg(i,j) > acc
      acc = cg(i,j);
      bestc = basenum^X(i,j);
      bestg = basenum^Y(i,j);
      end

      end
      end
      % to draw the acc with different c & g
      [cg,ps] = mapminmax(cg,0,1);
      figure(1);
      [C,h] = contour(X,Y,cg,0:msestep:0.5);
      clabel(C,h,'FontSize',10,'Color','r');
      xlabel('log2c','FontSize',12);
      ylabel('log2g','FontSize',12);
      firstline = 'SVC参数选择结果图(等高线图)[GridSearchMethod]'; 
      secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
      ' CVacc=',num2str(acc)];
      title({firstline;secondline},'Fontsize',12);
      grid on;

      figure(2);
      meshc(X,Y,cg);
      % mesh(X,Y,cg);
      % surf(X,Y,cg);
      axis([cmin,cmax,gmin,gmax,0,1]);
      xlabel('log2c','FontSize',12);
      ylabel('log2g','FontSize',12);
      zlabel('acc','FontSize',12);
      firstline = 'SVC参数选择结果图(3D视图)[GridSearchMethod]'; 
      secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
      ' CVacc=',num2str(acc)];
      title({firstline;secondline},'Fontsize',12);