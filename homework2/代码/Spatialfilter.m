function [] = Spatialfilter()
clc;
clear;
%����ͼ�񣬲�ת��Ϊdouble��
I=imread('test.png');
I_D=im2double(I);
[MM,NN]=size(I_D);
 
%%%%%----------------------2��˳��ͳ���˲���-------------------------------
%%======================= 2.3 ������İ�������ֵ�˲���=====================
%�����Ӵ��ڵĳߴ�
m=5;
n=5;
%ȷ��Ҫ��չ��������
len_m=floor(m/2);
len_n=floor(n/2);
%��ԭʼͼ�������չ����������˾�����չ���Խ���ͼ���Ե����
I_D_pad=padarray(I_D,[len_m,len_n],'symmetric');
%�����չ���ͼ��ߴ�
[M,N]=size(I_D_pad);
d=5;
J_Alpha=zeros(MM,NN);
%�������Ӵ��ڵ�г��ƽ��
for i=1+len_m:M-len_m
    for j=1+len_n:N-len_n
        %����չͼ����ȡ����ͼ��
        Block=I_D_pad(i-len_m:i+len_m,j-len_n:j+len_n);
        %�������İ�������ֵ        
        J_Alpha(i-len_m,j-len_n)=sum(sum(Block))/(m*n-d);
    end
end
figure;
imshow(J_Alpha);
title('������İ�������ֵ�˲���');

