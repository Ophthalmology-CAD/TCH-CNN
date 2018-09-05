function extract_every_category(srcdir_category,result_feature_dir,data_root)


 

% srcdir=uigetdir('C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\test_data','Choose source directory.'); %获得选择的文件夹
%srcdir=uigetdir('C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\test_data\大'); %获得选择的文件夹

%选择待处理文件夹的总目录，一次处理一个类别

% srcdir_file={'正常','不正常','小','大','浅','深','未完全覆盖中央','完全覆盖中央'};

srcdir_root=data_root;
 
srcdir=strcat(srcdir_root,'\',srcdir_category);

%current_file='C:\Users\mingmin\Desktop\cnn应用\zhangkai代码\小波\0';
cd(result_feature_dir);
mkdir(srcdir_category);

sub_name={'1' '2' '3' '4' '5'};
[row,com]=size(sub_name);
%srcdir_sub是各个待抽取特征的图像
srcdir_sub={};
for i=1:1:com
    srcdir_sub_one=strcat(srcdir,'\',sub_name(i));
    srcdir_sub{i}=srcdir_sub_one;
end
%特征抽取后保存到对应的txt文本中，文件名一样
sub_name_txt=strcat(sub_name,'.txt');

features={};
for i=1:1:com
    
    [waveletarray]=waveletfeature(srcdir_sub{i});
    features{i}=waveletarray;
   
end

cd(result_feature_dir);
cd(srcdir_category);
for i=1:1:com
%   save feature.txt -ascii waveletarray
    result_features=features{i};
    save(sub_name_txt{i},'-ascii','result_features');
end

