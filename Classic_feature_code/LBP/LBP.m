function features=LBP(filepath)
pic=imread(filepath);
pic=imresize(pic,[20 30],'nearest');
graypic=rgb2gray(pic);
windowsize=9;%窗口大小
feature=[];
features=[];
for index1=1:size(graypic,1)-(windowsize-1)
    for index2=1:size(graypic,2)-(windowsize-1)
        window=graypic(index1:index1+windowsize-1,index2:index2+windowsize-1);
        %对窗口扫描
        group=[];
        for index3=1:size(window,1)-2
            for index4=1:size(window,2)-2
                group=window(index3:index3+2,index4:index4+2);
                tempbinary=[];
                for index5=1:size(group,1)
                    for index6=1:size(group,2)
                        if index5~=2 | index6~=2
                            if group(index5,index6)>=group(2,2)
                                tempbinary(numel(tempbinary)+1)=1;
                            else
                                tempbinary(numel(tempbinary)+1)=0;
                            end
                        end
                    end
                end
                %对二进制串循环右移
                tempcount=[];
                binarychange=[];
                circlebinary=[tempbinary(1) tempbinary(2) tempbinary(3) tempbinary(5) tempbinary(8) tempbinary(7) tempbinary(6) tempbinary(4)];
                binarychange(1,:)=circlebinary;
                tempsum=0;
                for index8=1:numel(circlebinary)
                    tempsum=tempsum+circlebinary(index8)*power(2,index8-1);
                end
                tempcount(1)=tempsum;
                %tempcount(1)=tempbinary(1)*1+tempbinary(2)*2+tempbinary(3)*4+tempbinary(5)*8+tempbinary(8)*16+tempbinary(7)*32+tempbinary(6)*64+tempbinary(4)*128;
                for index7=1:7
                   binarychange(index7+1,:)= [binarychange(index7,2:8) binarychange(index7,1)];
                    tempsum=0;
                        for index8=1:size( binarychange,2)
                           tempsum=tempsum+ binarychange(index7+1,index8)*power(2,index8-1);
                        end
                        tempcount(index7+1)=tempsum;
                    %tempcount(index7+1)=tempcirclebinary(1)*1+tempcirclebinary(2)*2+tempcirclebinary(3)*4+tempcirclebinary(5)*8+tempcirclebinary(8)*16+tempcirclebinary(7)*32+tempcirclebinary(6)*64+tempcirclebinary(4)*128;
                end
                minvalue=tempcount(1);
                minposition=1;
                for index9=2:numel(tempcount)
                    if tempcount(index9)<minvalue
                        minvalue=tempcount(index9);
                        minposition=index9;
                    end
                end
                minbinary=binarychange(minposition,:);
                jumpnumber=0;
                for index10=1:numel(minbinary)
                    if index10~=8
                        if minbinary(index10)~=minbinary(index10+1)
                            jumpnumber=jumpnumber+1;
                        end
                    else
                        if minbinary(index10)~=minbinary(1)
                            jumpnumber=jumpnumber+1;
                        end
                    end
                end
                if jumpnumber<=2
                    feature((index1-1)*(size(graypic,2)-(windowsize-1))+index2,(index3-1)*(size(window,2)-2)+index4)=sum(minbinary);
                else
                    feature((index1-1)*(size(graypic,2)-(windowsize-1))+index2,(index3-1)*(size(window,2)-2)+index4)=8+1;%sum(minbinary)+1
                end
            end
        end          
    end
end
%统计直方图
maxnumber=max(max(feature));
for index11=1:size(feature,1)
    b=hist(feature(index11,:),maxnumber+1);
    features=[features b];
end