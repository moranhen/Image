function[] = MATLAB_code()
clear;clc;close all
I1=imread('1.bmp');
I=rgb2gray(I1);
index=find(I<50);
I(index)=0;
BW=im2bw(I);
[H,T,R]=hough(BW);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on
axis normal
hold on
P=houghpeaks(H,5);
x=T(P(:,2)); 
y=R(P(:,1));
plot(x,y,'s','color','white');
lines=houghlines(BW,T,R,P);
figure
imshow(I1)
hold on
k=[];
b=[];
for n=1:length(lines)
   xy=[lines(n).point1; lines(n).point2];   
   k(n)=(xy(1,2)-xy(2,2))/(xy(1,1)-xy(2,1)+1e-8);
   b(n)=xy(1,2)-k(n)*xy(1,1);
end
k1=[];
k2=[];
b1=[];
b2=[];
alpha=rad2deg(atan(k));
distance=abs(alpha-alpha(1)); 
index=find(distance>120);  
distance(index)=180-distance(index); 

index1=find(distance<45);
index2=find(distance>=45);

k1=k(index1); 
k2=k(index2);
b1=b(index1);
b2=b(index2);
for n=index1
   xy=[lines(n).point1; lines(n).point2];
   plot(xy(:,1),xy(:,2),':g','LineWidth',1.5);
end

for n=index2
   xy=[lines(n).point1; lines(n).point2];
   plot(xy(:,1),xy(:,2),':r','LineWidth',1.5);
end
x0=[];
y0=[];
count=1;
for i=1:length(k1)
    for j=1:length(k2)
        x0(count)=(b1(i)-b2(j))/(k2(j)-k1(i));
        y0(count)=k1(i)*x0(count)+b1(i);
        count=count+1;
    end
end
plot(mean(x0),mean(y0),'o','LineWidth',2.5)



