function [] = user_define()

% 设将要拟合的直线为 y = 2x+3，该直线为理想情况
% 现对直线上 x>0 随机取点20个，分别对应x[20] y[20]
clear
clc
%y = 2*x +3;
a = [1,5];  % 直线上的点（1，5）
b = [5,13];     % 直线上的点（5，13）
% 初始化参数，以提升计算效率
% 否则会提示警告：“变量似乎会随着迭代次数改变而变化，请预分配内存，以提高运行速度”
% t = zero(1,20);
% p = zero(1,20);
t(1) = 0;
p(1) = 0;
% 生成的t(i)和p（i）为直线上的随机点
for i = 1:20
    t(i) = rand(1,1)*5;
    p(i) = 2*t(i)+3;
end
 
% 对采集到的离散的t(i),p(i)加入wng(1,size(t),1)的高斯白噪声，生成的序列作为含误差的测量序列
t = sort(t);
p = sort(p);
% 采用带绝对值的高斯白噪声
% t_g = t + abs(wgn(1,20,0));
% p_g = p + abs(wgn(1,20,0));
% 使用（-1，1）的随机数来给测试序列添加噪声
% t_g = t + (rand(1,20)*2-1);
% p_g = p + (rand(1,20)*2-1);
% 高斯白噪声
t_g = t + wgn(1,20,0);
p_g = p + wgn(1,20,0);
% 最小二乘法对 t_g 和 p_g 拟合
% 这里才开始最小二乘法
% 首先使用Matlab内置的最小二乘函数 polyfit 进行多项式拟合，具体自己查help
% 注：type函数可帮助查看源代码
line1 = polyfit(t_g,p_g,1);
t_g2 = 1:0.1:5;
p_g2 = polyval(line1,t_g2);
plot(t_g,p_g,'o',t_g2,p_g2);
legend('拟合的曲线');
hold on
ideal_line = 2*t_g2+3;
plot(t_g2,ideal_line,'b');
legend('样本点','拟合的曲线','原直线');
