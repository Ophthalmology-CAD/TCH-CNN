

function [TP,FN,TN,FP]=wavelet(testdata,testlabel,traindata,trainlabel,number1,number2)

% clc
% clear all
% format long
% testdata=[];
TP=0;
FN=0;
TN=0;
FP=0;
trianlabel=trainlabel;
triandata=traindata;
%number1=size(testlabel,1);

model = svmtrain(trianlabel,triandata, '-s 0 -t 0 -b 1');
[predict_label, accuracy, dec_values] =svmpredict(testlabel, testdata, model,'-b 1');
for index1=1:number1
    if predict_label(index1)==1 & testlabel(index1)==1
       TP=TP+1;
    end
end
for index1=1:number2
    if predict_label(index1+number1)==0 & testlabel(index1+number1)==0
         TN=TN+1;
    end
end
FP=number2-TN;
        P=sum(testlabel);
        N=numel(testlabel)-P;
FN=number1-TP;


% 
% Accuracy=(TP+TN)/(P+N);
% Sensitivity=TP/P;
% FNR=1-Sensitivity;
% Specificity=TN/N;
% FPR=1-Specificity;
% 
% ROC=[];%画ROC曲线的存储矩阵
% largevalues=[];
% largevalues=dec_values(:,2);%属于正例的概率
% templabel=[];
% 
% 
%     %组合矩阵
%     comprehensivearray=[testlabel largevalues];
%     
%      %排序
%     for index4=1:size(comprehensivearray,1)
%         for index5=index4+1:size(comprehensivearray,1)
%             if comprehensivearray(index4,2)<comprehensivearray(index5,2)
%                 %交换
%                 temp=comprehensivearray(index4,:);
%                 comprehensivearray(index4,:)=comprehensivearray(index5,:);
%                 comprehensivearray(index5,:)=temp;
%             end
%         end
%     end
%    for index=1:size(comprehensivearray,1)
%     benchmark=comprehensivearray(index,2);
%     for index1=1:size(comprehensivearray,1)
%         if comprehensivearray(index1,2)>=benchmark
%            comprehensivearray(index1,3)=0;
%         else
%            comprehensivearray(index1,3)=1;
%         end
%     end
% 
%         FP1=0;
%         TP1=0;
%         for index2=1:size(comprehensivearray,1)
%             if comprehensivearray(index2,1)==0 & comprehensivearray(index2,3)==1
%                 FP1=FP1+1;
%             end
%         end
%         for index3=1:size(comprehensivearray,1)
%             if comprehensivearray(index3,1)==1 & comprehensivearray(index3,3)==1
%                 TP1=TP1+1;
%             end
%         end
%   ROC(1,index)=FP1/N;
%   ROC(2,index)=TP1/P;     
%   end 
% plot(ROC(1,:),ROC(2,:),'-*r');
% 
end