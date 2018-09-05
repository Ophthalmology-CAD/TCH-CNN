%���ѵ�����ݺͲ�������,����֮���0��Ϊ������,����1��������0

function classification_grading(ok_file,other_file,statistics_file)

% features_root={'C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\С��\0\result_feature_file'}; %���ѡ����ļ���
% srcdir_category={'����','������','С','��','ǳ','��','δ��ȫ��������','��ȫ��������'};
% current_dir=pwd;
% result_feature_file='result_feature';
% mkdir('result_feature_file');
% result_feature_dir=strcat(current_dir,'\','result_feature_file');


% features_ok={'C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\С��\0\result_feature_file\����'}; %���ѡ����ļ���
% features_other={'C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\С��\0\result_feature_file\������'}; %���ѡ����ļ���
features_ok=ok_file;
features_other=other_file;

sub_name={'1.txt' '2.txt' '3.txt' '4.txt' '5.txt'};
features_des_ok=strcat(features_ok,'\',sub_name);
features_des_other=strcat(features_other,'\',sub_name);
% statistics_file='C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\С��\0\result_feature_file';
% 
% cd(statistics_file);
% mkdir('statistics_avg');


tp=[];fp=[];tn=[];fn=[];
for i=1:1:5
    sample_train_ok=load(features_des_ok{i});
    number1=size(sample_train_ok,1);
    sample_train_other=load(features_des_other{i});
    number2=size(sample_train_other,1);
    testdata=[sample_train_ok;sample_train_other];
    testlabel=[ones(number1,1);zeros(number2,1)];
    
    traindata={};
    trainnumber_ok=0;trainnumber_other=0;
    traindata_ok=[];
    traindata_other=[];
    for j=1:1:5
        if j~=i
            sample3=load(features_des_ok{j});
            number3=size(sample3,1);
            sample4=load(features_des_other{j});
            number4=size(sample4,1);
            
            traindata_ok=[traindata_ok;sample3];
            
%             traindata_ok(j)={sample3};
            trainnumber_ok=trainnumber_ok+number3;
%             traindata_other(j)={sample4};
            traindata_other=[traindata_other;sample4];
            trainnumber_other=trainnumber_other+number4;            
        end

    end
    traindata=[traindata_ok;traindata_other];
    trainlabel=[ones(trainnumber_ok,1);zeros(trainnumber_other,1)];
    [TP,FN,TN,FP]=wavelet(testdata,testlabel,traindata,trainlabel,number1,number2);
    
    tp=[tp TP];
    tn=[tn TN];
    fn=[fn FN];
    fp=[fp FP];
   
end

cd(statistics_file);
cd('statistics_avg');

save('tp.txt','-ascii', '-append','tp');
save('fp.txt','-ascii', '-append','fp');
save('tn.txt','-ascii', '-append','tn');
save('fn.txt','-ascii', '-append','fn');

% tp=[1 2 3 5];
% dlmwrite('tp.txt',tp);
end