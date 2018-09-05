
function [waveletarray]=cotxfeature(srcdir)
%function lastfaeture=extractfeature()
warning off
%clc
%clear

srcDir=srcdir{1};
waveletarray=[];
%srcDir=uigetdir('D:\程序文件\matlab\图像特征\0','Choose source directory.'); %获得选择的文件夹
cd(srcDir);
allnames=struct2cell(dir('*.jpg'));%图片格式
[k,len]=size(allnames); %获得文件的个数
for ii=1:len
%逐次取出文件
name=allnames{1,ii};
%提取颜色特征
colorarray=colorfeature(name,srcDir);
waveletarray(ii,1:9)=colorarray(:)';
[grayfeature,graygradientfeature]=texturefeature(name,srcDir);
waveletarray(ii,10:22)=grayfeature;
waveletarray(ii,23:36)=graygradientfeature;
end
%save feature.txt -ascii waveletarray
end