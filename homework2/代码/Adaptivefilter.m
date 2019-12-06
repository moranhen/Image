function [] = Adaptivefilter()
clc;
clear;
f=imread('test.png');
image_gray=rgb2gray(f);%得到灰度图像
ff =image_gray;
ff(:) = 0;
alreadyProcessed = false(size(image_gray));%生成逻辑非的矩阵
% 迭代.
Smax=7;
for k = 3:2:Smax
   zmin = ordfilt2(image_gray, 1, ones(k, k), 'symmetric');
   zmax = ordfilt2(image_gray, k * k, ones(k, k), 'symmetric');
   zmed = medfilt2(image_gray, [k k], 'symmetric');
   
   processUsingLevelB = (zmed > zmin) & (zmax > zmed) & ...
       ~alreadyProcessed; 
   zB = (image_gray > zmin) & (zmax > image_gray);
   outputZxy  = processUsingLevelB & zB;
   outputZmed = processUsingLevelB & ~zB;
   ff(outputZxy) = image_gray(outputZxy);
   ff(outputZmed) = zmed(outputZmed);
   
   alreadyProcessed = alreadyProcessed | processUsingLevelB;
   if all(alreadyProcessed(:))
      break;
   end
end
ff(~alreadyProcessed) = zmed(~alreadyProcessed);
f1=imnoise(image_gray,'salt & pepper',0.3);%添加椒盐噪声后的图像

figure;
imshow(ff);
figure;
imshow(f1);
