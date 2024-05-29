function [gbest,gbestval,convergence,time]= TSA_func(fhd,Dimension,Particle_Number,Max_Gen,VRmin,VRmax,varargin)
%[gbest,gbestval,fitcount]= PSO_func('f8',3500,200000,30,30,-5.12,5.12)
% fitcount
%
N=Particle_Number; % initial number of trees in an area.
low=ceil(0.1*N);          % is used by determining the number of seeds produced for a tree
high=ceil(0.25*N);        % is used by determining the number of seeds produced for a tree
D= Dimension; % Dimensionality of the problem
ST=0.1;           % Search tendency parameter used for equation selection
dmin=VRmin;        % The lower bound of search space
dmax=VRmax;         % The upper bound of search space

fes=N;              % is the fes counter.
max_fes=D*10000;    % is the termination condition, 与PSO的函数评估次数相等

trees=zeros(N,D);    % tree population
obj=zeros(1,N);      % objective function value for each tree

t=1;
convergence = ones(1,Max_Gen);
tic;
for i=1:N
    for j=1:D
        trees(i,j)=dmin+(dmax-dmin)*rand;   % The trees location on the search space
    end
%   obj(i)=feval(objfun,trees(i,:));
%     obj(i)=feval(fhd,trees(i,:),varargin{:});
end

obj=feval(fhd,trees',varargin{:});

%%% The determination of best tree location in the stand
[values,indis]=min(obj);
indis=indis(end);
best=obj(indis);
best_params=trees(indis,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  while  (t <= Max_Gen) %(fes<max_fes)  % Max_Gen 最大迭代次数未使用
%%%%%%%%%%%%%%%%%%   SEED PRODUCTION   %%%%%%%%%%%%%%%%%%
        for i=1:N
            ns=low+randi(high-low+1)-1; % Number of seeds for this tree
            ns=ns(1);
            seeds=zeros(ns,D);
            objs=zeros(1,ns);
            for j=1:ns
                % Determination of the neighbour for ith tree.    
                   r=fix(rand*N)+1;
                   while(i==r)
                        r=fix(rand*N)+1;
                   end
                %%% SEEDS ARE CREATING
                for d=1:D
           
                    if(rand<ST)
                        seeds(j,d)=trees(i,d)+(best_params(d)-trees(r,d))*(rand-0.5)*2;%局部
                       
                    else
                        seeds(j,d)=trees(i,d)+(trees(r,d)-trees(i,d))*(rand-0.5)*2;%全局
                        
                    end
                end
               % Check if solutions go outside the search spaceand bring them back
                  Flag4ub=seeds(j,:)>dmax;
                  Flag4lb=seeds(j,:)<dmin;
                  seeds(j,:)=(seeds(j,:).*(~(Flag4ub+Flag4lb)))+(dmin+(dmax-dmin)*rand)*Flag4ub+(dmin+(dmax-dmin)*rand)*Flag4lb;
%                 objs(j)=feval(objfun,seeds(j,:));
%                 objs(i)=feval(fhd,seeds(j,:)',varargin{:});
            end
            
            objs=feval(fhd,seeds',varargin{:});
            
            [val,indis]=min(objs);
            indis=indis(end);
            if(objs(indis)<obj(i))
                trees(i,:)=seeds(indis,:);
                obj(i)=objs(indis);
            end
            fes=fes+ns;            
        end

        %%% The determination of best tree location obtained so far.
        [values,indis]=min(obj);
        indis=indis(end);
        temp_best=obj(indis);   
        if(temp_best<best)
            best=temp_best;
            best_params=trees(indis,:);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 记录convergence情况
        convergence(t)=best;
        t=t+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  end
    gbest = best_params; %返回最佳值
    gbestval =best; %返回最佳位置
%     fitcount=fes; %返回函数评估次数
toc;
time=toc;
end









