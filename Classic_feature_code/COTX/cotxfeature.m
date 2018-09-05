
function [waveletarray]=cotxfeature(srcdir)
%function lastfaeture=extractfeature()
warning off
%clc
%clear

srcDir=srcdir{1};
waveletarray=[];
%srcDir=uigetdir('D:\�����ļ�\matlab\ͼ������\0','Choose source directory.'); %���ѡ����ļ���
cd(srcDir);
allnames=struct2cell(dir('*.jpg'));%ͼƬ��ʽ
[k,len]=size(allnames); %����ļ��ĸ���
for ii=1:len
%���ȡ���ļ�
name=allnames{1,ii};
%��ȡ��ɫ����
colorarray=colorfeature(name,srcDir);
waveletarray(ii,1:9)=colorarray(:)';
[grayfeature,graygradientfeature]=texturefeature(name,srcDir);
waveletarray(ii,10:22)=grayfeature;
waveletarray(ii,23:36)=graygradientfeature;
end
%save feature.txt -ascii waveletarray
end