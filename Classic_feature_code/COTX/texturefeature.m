function [grayfeature,graygradientfeature]=texturefeature(filename,filepath)
fileabsolutepath=strcat(strcat(filepath,'\'),filename);
I=imread(fileabsolutepath);
%I=imread('19300001059097132395816070227.jpg');
I=rgb2gray(I);
I=double(I);
[picx picy]=gradient(I);
discretegraylevel=10;%灰度离散化级数
grayfeature=[];%灰度共生矩阵纹理特征
graygradientfeature=[];%梯度共生矩阵纹理特征
gradientpic=sqrt(picx.^2+picy.^2);%灰度梯度图
maxgray=max(max(gradientpic));%梯度图像最大灰度
mingray=min(min(gradientpic));%梯度图像最小灰度
gradientpic=(gradientpic-mingray)/(maxgray-mingray);
%求灰度共生矩阵
maxgray1=max(max(I));
mingray1=min(min(I));
%grayarray=zeros(maxgray1-mingray1+1);%存储灰度共生矩阵
grayarray=zeros(256);%存储灰度共生矩阵

for index1=1:size(I,1)
    for index2=1:size(I,2)
       if index2~=size(I,2)      
           grayarray(I(index1,index2)+1,I(index1,index2+1)+1)=grayarray(I(index1,index2)+1,I(index1,index2+1)+1)+1;
       end
       if index1~=1 & index2~=size(I,2) & (index1~=1 & index2~=size(I,2))
           grayarray(I(index1,index2)+1,I(index1-1,index2+1)+1)=grayarray(I(index1,index2)+1,I(index1-1,index2+1)+1)+1;
       end
       if index1~=1 
           grayarray(I(index1,index2)+1,I(index1-1,index2)+1)=grayarray(I(index1,index2)+1,I(index1-1,index2)+1)+1;
       end
       if index1~=1 & index2~=1 & (index1~=1 & index2~=1)
           grayarray(I(index1,index2)+1,I(index1-1,index2-1)+1)=grayarray(I(index1,index2)+1,I(index1-1,index2-1)+1)+1;
       end
    end
end
grayarray=grayarray/4;
grayarray=grayarray/sum(sum(grayarray));%归一化
gradientpic=ceil(gradientpic*discretegraylevel);
for index3=1:size(gradientpic,1)%修正
    for index4=1:size(gradientpic,2)
        if gradientpic(index3,index4)==0
           gradientpic(index3,index4)=1;
        end
    end
end
graygradientarray=zeros(256,discretegraylevel);%存储灰度梯度共生矩阵
for index5=1:size(I,1)
    for index6=1:size(I,2)
        graygradientarray(I(index5,index6)+1,gradientpic(index5,index6))=graygradientarray(I(index5,index6)+1,gradientpic(index5,index6))+1;
    end 
end
graygradientarray=graygradientarray/sum(sum(graygradientarray));%归一化
grayfeature(1)=sum(sum(grayarray.^2));
temp=0;
for index7=1:255
    tempsum=0;
    for index8=1:256
        for index9=1:256
            if abs(index8-index9)==index7
                tempsum=tempsum+grayarray(index8,index9);
            end
        end
    end
    temp=temp+index7^2*tempsum;
end
grayfeature(2)=temp;
ux=[];%行
uy=[];
deltax=[];%行
deltay=[];
ux=mean(sum(grayarray'));
uy=mean(sum(grayarray));
deltax=std(sum(grayarray'));
deltay=std(sum(grayarray));
temp=0;
for index10=1:256
    for index11=1:256
        temp=temp+index10*index11*grayarray(index10,index11);
    end
end
grayfeature(3)=(temp-ux*uy)/deltax*deltay;
temp=0;
for index12=1:256
    for index13=1:256
        temp=temp+(1/(1+(index12-index13)^2))*grayarray(index12,index13);
    end
end
grayfeature(5)=temp;
temp=0;
for index14=2:2*256
    tempsum=0;
    for index15=1:256
        for index16=1:256
            if index15+index16==index14
                tempsum=tempsum+grayarray(index15,index16);
            end
        end
    end
    temp=temp+index14*tempsum;
end
grayfeature(6)=temp;

temp=0;
for index14=2:2*256
    tempsum=0;
    for index15=1:256
        for index16=1:256
            if index15+index16==index14
                tempsum=tempsum+grayarray(index15,index16);
            end
        end
    end
    if tempsum==0
        temp=temp+0;
    else
    temp=temp+tempsum*log2(tempsum);
    end
end
grayfeature(8)=-temp;
temp=0;
for index14=2:2*256
    tempsum=0;
    for index15=1:256
        for index16=1:256
            if index15+index16==index14
                tempsum=tempsum+grayarray(index15,index16);
            end
        end
    end
    if tempsum~=0
      temp=temp+((index14-grayfeature(8))^2)*tempsum*log2(tempsum);
    else
        temp=temp+0;
    end
end
grayfeature(7)=temp;
temp=0;
for index12=1:256
    for index13=1:256
        if grayarray(index12,index13)==0
          temp=temp+0;
        else
           temp=temp+grayarray(index12,index13)*log2(grayarray(index12,index13));
        end
    end
end
grayfeature(9)=-temp;
temp=zeros(1,256);
for index17=0:256-1
    for index18=1:256
        for index19=1:256
            if abs(index18-index19)==index17
                temp(index17+1)= temp(index17+1)+1;
            end
        end
    end
end
grayfeature(10)=var(temp);

temp1=0;
for index20=1:256
    if temp==0
      temp1=temp+0;
    else
      temp1=temp1+temp(index20)*log2(temp(index20));
    end
end
grayfeature(11)=temp1;

HXY=grayfeature(9);
temp1=0;
temp2=0;
px=sum(grayarray);
py=sum(grayarray');
for index21=1:256
    for index22=1:256
        if px(index21)==0 | py(index22)==0
             temp1=temp1+0;
        else
        temp1=temp1+grayarray(index21,index22)*log2(px(index21)*py(index22));
        end
         if px(index21)==0 | py(index22)==0
          temp2=temp2+0;
         else
          temp2=temp2+px(index21)*py(index22)*log2(px(index21)*py(index22));
         end
    end
end
HX=0;
HY=0;
for index23=1:256
    if px(index23)==0
         HX=HX+0;
    else
        HX=HX+px(index23)*log2(px(index23));
    end
    if py(index23)==0
        HY=HY+0;
    else
        HY=HY+py(index23)*log2(py(index23));
    end
end
HXY1=-temp1;
HXY2=-temp2;
grayfeature(12)=(HXY-HXY1)/max(HX,HY);
grayfeature(13)=(1-exp(-2*(HXY2-HXY)))^(1/2);
%计算第二组特征
temp1=0;
temp2=0;
temp3=0;
for index1=1:size(graygradientarray,1)
    for index2=1:size(graygradientarray,2)
        temp1=temp1+graygradientarray(index1,index2)/((index2+1)^2);
        temp3=temp1+graygradientarray(index1,index2)/(index2^2);
        temp2=temp2+graygradientarray(index1,index2);
    end
end
graygradientfeature(1)=temp1/temp2;
graygradientfeature(2)=temp3/temp2;
temp4=0;
for index3=1:size(graygradientarray,1)
    tempsum=0;
    for index4=1:size(graygradientarray,2)
        tempsum=tempsum+graygradientarray(index3,index4);
    end
    temp4=temp4+tempsum^2;
end
graygradientfeature(3)=temp4/temp2;
temp5=0;
for index4=1:size(graygradientarray,2)
       tempsum=0;
     for index3=1:size(graygradientarray,1)
        tempsum=tempsum+graygradientarray(index3,index4);
    end
    temp5=temp5+tempsum^2;
end
graygradientfeature(4)=temp5/temp2;
graygradientfeature(5)=sum(sum(graygradientarray.^2));

temp6=0;
for index3=1:size(graygradientarray,1)
    tempsum=0;
    for index4=1:size(graygradientarray,2)
        tempsum=tempsum+graygradientarray(index3,index4);
    end
    temp6=temp6+index3*tempsum;
end
graygradientfeature(6)=temp6;

temp6=0; 
for index4=1:size(graygradientarray,2)
      tempsum=0;
    for index3=1:size(graygradientarray,1)   
        tempsum=tempsum+graygradientarray(index3,index4);
    end
    temp6=temp6+index4*tempsum;
end
graygradientfeature(7)=temp6;

temp6=0; 
for index4=1:size(graygradientarray,1)
      tempsum=0;
    for index3=1:size(graygradientarray,2)   
        tempsum=tempsum+graygradientarray(index4,index3);
    end
    temp6=temp6+((index4-graygradientfeature(6))^2)*tempsum;
end
graygradientfeature(8)=temp6;

temp6=0; 
for index4=1:size(graygradientarray,2)
      tempsum=0;
    for index3=1:size(graygradientarray,1)   
        tempsum=tempsum+graygradientarray(index3,index4);
    end
    temp6=temp6+((index4-graygradientfeature(7))^2)*tempsum;
end
graygradientfeature(9)=temp6;

temp6=0; 
for index4=1:size(graygradientarray,1)
    for index3=1:size(graygradientarray,2)   
        tempsum=tempsum+graygradientarray(index4,index3);
    end
    temp6=temp6+(index4-graygradientfeature(6))*(index3-graygradientfeature(7))*graygradientarray(index4,index3);
end
graygradientfeature(10)=temp6;
 temp8=0;
for index5=1:size(graygradientarray,1)
    for index6=1:size(graygradientarray,2)
        tempsum=0;
        for index7=1:size(graygradientarray,2)
           tempsum=tempsum+graygradientarray(index5,index7);
        end
        if tempsum==0
           temp8=temp8+0; 
        else
            temp8=temp8+graygradientarray(index5,index6)*tempsum;
        end
    end
end
graygradientfeature(11)=-temp8;

temp8=0;
for index5=1:size(graygradientarray,2)
    for index6=1:size(graygradientarray,1)
        tempsum=0;
        for index7=1:size(graygradientarray,1)
           tempsum=tempsum+graygradientarray(index7,index5);
        end
        if tempsum==0
           temp8=temp8+0; 
        else
            temp8=temp8+graygradientarray(index6,index5)*tempsum;
        end
    end
end
graygradientfeature(12)=-temp8;

 temp8=0;
 temp9=0;
for index5=1:size(graygradientarray,1)
    for index6=1:size(graygradientarray,2)
        tempsum=0;
        if graygradientarray(index5,index6)==0
           temp8=temp8+0; 
           temp9=temp9+0;
        else
            temp8=temp8+graygradientarray(index5,index6)*log2(graygradientarray(index5,index6));
            temp9=(temp9+(index5-index6)^2)*graygradientarray(index5,index6); 
        end
    end
end
graygradientfeature(13)=-temp8;
graygradientfeature(14)=temp9;