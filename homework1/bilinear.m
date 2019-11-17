function []=bilinear(time)
% timeΪ�Ŵ������С�ı���
img=imread('ddd.png');
method='linear';
[imgH,imgW,nothing]=size(img);
x1=1:1/time:imgW;
y1=1:1/time:imgH;
[x2,y2,z2]=meshgrid(x1,y1,1:3);
% ����ϵͳ����λ���Բ�ֵ
newImg = interp3(double(img),x2,y2,z2,method); 
size(newImg)
imshow(uint8(newImg));
end