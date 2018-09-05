
function [waveletarray]=waveletfeature(srcdir)
warning off
% clc
% clear
N=2;%小波层数
waveletarray=[];
srcDir=srcdir{1};

% srcDir=uigetdir('C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\test_data','Choose source directory.'); %获得选择的文件夹
cd(srcDir);
allnames=struct2cell(dir('*.jpg'));%图片格式
[k,len]=size(allnames); %获得文件的个数
for ii=1:len
%逐次取出文件
name=allnames{1,ii};
%提取小波特征
fileabsolutepath=strcat(strcat(srcDir,'\'),name);
pic=imread(fileabsolutepath);
pic=rgb2gray(pic);
pic1=imresize(pic,[15,30],'nearest');
[c,s]=wavedec2(pic1,N,'haar');
waveletarray(ii,:)=c;
end
%save feature.txt -ascii waveletarray
end