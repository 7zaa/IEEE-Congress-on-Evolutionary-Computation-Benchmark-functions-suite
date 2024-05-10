% mex cec20_func.cpp -DWINDOWS
if isempty(flag)
    fhd=str2func('cec20_func');
    num=[1,2,3,8]%10
    [X, Y] = meshgrid(-100:1:100, -100:1:100);
    % Z_convex = X.^2 + Y.^2; % 凸函数，例如 x^2 + y^2
    for i=1:size(X,1)
        for j=1:size(Y,1)
            Z_convex1(i,j)=feval(fhd,[X(i,j),Y(i,j)]',num(1));
            Z_convex2(i,j)=feval(fhd,[X(i,j),Y(i,j)]',num(2));
            Z_convex3(i,j)=feval(fhd,[X(i,j),Y(i,j)]',num(3));
            Z_convex4(i,j)=feval(fhd,[X(i,j),Y(i,j)]',num(4));
            %         Z_convex(i,j)= X(i,j)^2+Y(i,j)^2;
        end
    end
    flag=1;
end
figure;
count=1;
for i = num
    subplot(2,2,count)
    surf(X, Y, eval(['Z_convex',num2str(count)]));
    shading interp;  % 设置光滑着色
    title(['F_',num2str(i),' Optimization Problem']);
    xlabel('X');
    ylabel('Y');
    zlabel('Objective Function');
    count=count+1;
end