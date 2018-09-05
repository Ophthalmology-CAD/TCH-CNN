%组合训练数据和测试数据,名字之后带0的为负样本,正常1，不正常0


clc;
clear;

statistics_file='F:\蒋杰伟\code_statistic\result_feature_file';
srcdir_ok={'正常','小','浅','未完全覆盖中央'};
srcdir_other={'不正常','大','深','完全覆盖中央'};

cd(statistics_file);
mkdir('statistics_avg');



[row,com]=size(srcdir_ok);

for i=1:1:com
    ok_file=strcat(statistics_file,'\',srcdir_ok{i});
    other_file=strcat(statistics_file,'\',srcdir_other{i});
    classification_grading(ok_file,other_file,statistics_file);
      
end

