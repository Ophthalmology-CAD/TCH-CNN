
clc;
clear all;

% data_root='F:\����ΰ\code_statistic\test_data'; %���ѡ����ļ���
% result_file='F:\����ΰ\code_statistic';

data_root='C:\Users\mingmin\Desktop\�Զ��ָ�ͼ��\autocut_data';
result_file='C:\Users\mingmin\Desktop\�Զ��ָ�ͼ��';
cd(result_file);
result_feature_file='result_feature';
mkdir('result_feature_file');
result_feature_dir=strcat(result_file,'\','result_feature_file');

srcdir_ok={'����','С','ǳ','δ��ȫ��������'};
srcdir_other={'������','��','��','��ȫ��������'};
[row,com]=size(srcdir_ok);

for i=1:1:com
    vl_phow_svm_v2(data_root,result_feature_dir,srcdir_ok{i},srcdir_other{i});
      
end
