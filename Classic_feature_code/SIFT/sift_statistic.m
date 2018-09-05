
clc;
clear all;

% data_root='F:\蒋杰伟\code_statistic\test_data'; %获得选择的文件夹
% result_file='F:\蒋杰伟\code_statistic';

data_root='C:\Users\mingmin\Desktop\自动分割图像\autocut_data';
result_file='C:\Users\mingmin\Desktop\自动分割图像';
cd(result_file);
result_feature_file='result_feature';
mkdir('result_feature_file');
result_feature_dir=strcat(result_file,'\','result_feature_file');

srcdir_ok={'正常','小','浅','未完全覆盖中央'};
srcdir_other={'不正常','大','深','完全覆盖中央'};
[row,com]=size(srcdir_ok);

for i=1:1:com
    vl_phow_svm_v2(data_root,result_feature_dir,srcdir_ok{i},srcdir_other{i});
      
end
