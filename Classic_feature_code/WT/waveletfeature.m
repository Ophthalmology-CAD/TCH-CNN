
function [waveletarray]=waveletfeature(srcdir)
warning off
% clc
% clear
N=2;%С������
waveletarray=[];
srcDir=srcdir{1};

% srcDir=uigetdir('C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\test_data','Choose source directory.'); %���ѡ����ļ���
cd(srcDir);
allnames=struct2cell(dir('*.jpg'));%ͼƬ��ʽ
[k,len]=size(allnames); %����ļ��ĸ���
for ii=1:len
%���ȡ���ļ�
name=allnames{1,ii};
%��ȡС������
fileabsolutepath=strcat(strcat(srcDir,'\'),name);
pic=imread(fileabsolutepath);
pic=rgb2gray(pic);
pic1=imresize(pic,[15,30],'nearest');
[c,s]=wavedec2(pic1,N,'haar');
waveletarray(ii,:)=c;
end
%save feature.txt -ascii waveletarray
end