

clc;
clear;

data_root={'L:\Ӳ������\�о�����\code_statistic\test_data'}; %���ѡ����ļ���
srcdir_category={'����','������','С','��','ǳ','��','δ��ȫ��������','��ȫ��������'};
%current_dir=data_root;

result_file='L:\Ӳ������\�о�����\code_statistic\';
cd(result_file);
result_feature_file='result_feature';
mkdir('result_feature_file');
result_feature_dir=strcat(result_file,'\','result_feature_file');

[row,com]=size(srcdir_category);

for i=1:1:com
    
    extract_every_category(srcdir_category{i},result_feature_dir,data_root);
      
end
