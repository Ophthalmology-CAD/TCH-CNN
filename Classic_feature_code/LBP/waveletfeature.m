%LBP

function [waveletarray]=waveletfeature(srcdir)

warning off
% clc
% clear
%featurearray=[];
waveletarray=[];
% srcDir=uigetdir('D:\程序文件\matlab\sift','Choose source directory.'); %获得选择的文件夹
srcDir=srcdir{1};

cd(srcDir);
allnames=struct2cell(dir('*.jpg'));%图片格式
[k,len]=size(allnames); %获得文件的个数
for ii=1:len
%逐次取出文件
name=allnames{1,ii};
fileabsolutepath=strcat(strcat(srcDir,'\'),name);
c=LBP(fileabsolutepath);
%featurearray(ii,:)=c;
waveletarray(ii,:)=c;
end
% save feature.txt -ascii featurearray
end