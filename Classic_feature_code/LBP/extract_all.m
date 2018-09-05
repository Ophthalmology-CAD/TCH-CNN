

clc;
clear;

data_root={'L:\硬盘数据\研究资料\code_statistic\test_data'}; %获得选择的文件夹
srcdir_category={'正常','不正常','小','大','浅','深','未完全覆盖中央','完全覆盖中央'};
%current_dir=data_root;

result_file='L:\硬盘数据\研究资料\code_statistic\';
cd(result_file);
result_feature_file='result_feature';
mkdir('result_feature_file');
result_feature_dir=strcat(result_file,'\','result_feature_file');

[row,com]=size(srcdir_category);

for i=1:1:com
    
    extract_every_category(srcdir_category{i},result_feature_dir,data_root);
      
end
