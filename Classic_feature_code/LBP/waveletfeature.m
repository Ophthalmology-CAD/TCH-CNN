%LBP

function [waveletarray]=waveletfeature(srcdir)

warning off
% clc
% clear
%featurearray=[];
waveletarray=[];
% srcDir=uigetdir('D:\�����ļ�\matlab\sift','Choose source directory.'); %���ѡ����ļ���
srcDir=srcdir{1};

cd(srcDir);
allnames=struct2cell(dir('*.jpg'));%ͼƬ��ʽ
[k,len]=size(allnames); %����ļ��ĸ���
for ii=1:len
%���ȡ���ļ�
name=allnames{1,ii};
fileabsolutepath=strcat(strcat(srcDir,'\'),name);
c=LBP(fileabsolutepath);
%featurearray(ii,:)=c;
waveletarray(ii,:)=c;
end
% save feature.txt -ascii featurearray
end