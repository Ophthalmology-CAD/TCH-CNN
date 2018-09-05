%组合训练数据和测试数据,名字之后带0的为负样本,正常1，不正常0

function classification_grading(ok_file,other_file,statistics_file)

% features_root={'C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\小波\0\result_feature_file'}; %获得选择的文件夹
% srcdir_category={'正常','不正常','小','大','浅','深','未完全覆盖中央','完全覆盖中央'};
% current_dir=pwd;
% result_feature_file='result_feature';
% mkdir('result_feature_file');
% result_feature_dir=strcat(current_dir,'\','result_feature_file');


% features_ok={'C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\小波\0\result_feature_file\正常'}; %获得选择的文件夹
% features_other={'C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\小波\0\result_feature_file\不正常'}; %获得选择的文件夹
features_ok=ok_file;
features_other=other_file;

sub_name={'1.txt' '2.txt' '3.txt' '4.txt' '5.txt'};
features_des_ok=strcat(features_ok,'\',sub_name);
features_des_other=strcat(features_other,'\',sub_name);
% statistics_file='C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\小波\0\result_feature_file';
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