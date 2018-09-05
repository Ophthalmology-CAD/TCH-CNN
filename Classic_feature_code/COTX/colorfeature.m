function colorarray=colorfeature(filename,filepath)
fileabsolutepath=strcat(strcat(filepath,'\'),filename);

pic=imread(fileabsolutepath);
colorarray=[];%´æ´¢ÑÕÉ«¾Ø
for index3=1:size(pic,3)
    colorarray(1,index3)=sum(sum(pic(:,:,index3)));
end 
colorarray=colorarray*1/(size(pic,1)*size(pic,2));
sum1=zeros(1,3);
sum2=zeros(1,3);
pic=double(pic);
for index4=1:size(pic,3)
   for index1=1:size(pic,1)
       for index2=1:size(pic,2)
           sum1(1,index4)=sum1(1,index4)+(pic(index1,index2,index4)-colorarray(1,index4))^2;
           sum2(1,index4)=sum2(1,index4)+(pic(index1,index2,index4)-colorarray(1,index4))^3;
       end
   end
end
sum1=sum1*1/(size(pic,1)*size(pic,2));
sum2=sum2*1/(size(pic,1)*size(pic,2));
colorarray(2,:)=sum1;
colorarray(3,:)=sum2;
for index5=1:3
    colorarray(2,index5)=sqrt(colorarray(2,index5));
    colorarray(3,index5)=colorarray(3,index5)^1/3;
end