%���ѵ�����ݺͲ�������,����֮���0��Ϊ������,����1��������0


clc;
clear;

statistics_file='F:\����ΰ\code_statistic\result_feature_file';
srcdir_ok={'����','С','ǳ','δ��ȫ��������'};
srcdir_other={'������','��','��','��ȫ��������'};

cd(statistics_file);
mkdir('statistics_avg');



[row,com]=size(srcdir_ok);

for i=1:1:com
    ok_file=strcat(statistics_file,'\',srcdir_ok{i});
    other_file=strcat(statistics_file,'\',srcdir_other{i});
    classification_grading(ok_file,other_file,statistics_file);
      
end

