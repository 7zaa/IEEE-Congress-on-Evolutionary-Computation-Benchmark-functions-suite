clear all
close all
% mex cec22_func.cpp -DWINDOWS
func_num=1;
D=10;
Xmin=-100;
Xmax=100;
pop_size=100;
iter_max=500;
runs=2;
fhd=str2func('cec22_func');
for i=1:10% cec22_func has 10 functions
    func_num=i;
    for j=1:runs
        [PSO(i).gbest(j,:),PSO(i).gbestval(j,:),PSO(i).con(j,:)]= PSO_func(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num);
        [TSA(i).gbest(j,:),TSA(i).gbestval(j,:),TSA(i).con(j,:)]= TSA_func(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num);
        [GWO(i).gbest(j,:),GWO(i).gbestval(j,:),GWO(i).con(j,:)]= GWO_func(fhd,D,pop_size,iter_max,Xmin,Xmax,func_num);
    end
    PSO(i).conmean=mean(PSO(i).con);
    TSA(i).conmean=mean(TSA(i).con);
    GWO(i).conmean=mean(GWO(i).con);
    PSO(i).bestmean=mean(PSO(i).gbestval);
    TSA(i).bestmean=mean(TSA(i).gbestval);
    GWO(i).bestmean=mean(GWO(i).gbestval);
    bestresult(i,:)=[PSO(i).bestmean,TSA(i).bestmean,GWO(i).bestmean];
    figure(i)
    semilogy(PSO(i).conmean,'LineWidth',1);
    hold on
    semilogy(TSA(i).conmean,'LineWidth',1);
    semilogy(GWO(i).conmean,'LineWidth',1);
    legend('PSO','TSA','GWO')
    title(['Convergence curve of F',num2str(i)])
    xlabel('Iteration');
    ylabel('Best score obtained so far');
    drawnow
end



% for i=1:29
% eval(['load input_data/shift_data_' num2str(i) '.txt']);
% eval(['O=shift_data_' num2str(i) '(1:10);']);
% f(i)=cec14_func(O',i);i,f(i)
% end