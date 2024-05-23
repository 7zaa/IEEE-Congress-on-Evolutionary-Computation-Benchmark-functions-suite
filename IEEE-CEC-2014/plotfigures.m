clear all
% mex cec20_func.cpp -DWINDOWS
fhd=str2func('cec14_func');
num=1%10
[X, Y] = meshgrid(-100:1:100, -100:1:100);
% Z_convex = X.^2 + Y.^2; % 凸函数，例如 x^2 + y^2
for i=1:size(X,1)
    for j=1:size(Y,1)
        Z_convex(i,j)=feval(fhd,[X(i,j),Y(i,j)]',num);
%         Z_convex(i,j)= X(i,j)^2+Y(i,j)^2;
    end
end
figure(1);
surf(X, Y, Z_convex);
shading interp;  % 设置光滑着色
title('Convex Optimization Problem');
xlabel('X');
ylabel('Y');
zlabel('Objective Function');
