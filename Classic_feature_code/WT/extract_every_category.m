function extract_every_category(srcdir_category,result_feature_dir,data_root)


 

% srcdir=uigetdir('C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\test_data','Choose source directory.'); %���ѡ����ļ���
%srcdir=uigetdir('C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\test_data\��'); %���ѡ����ļ���

%ѡ��������ļ��е���Ŀ¼��һ�δ���һ�����

% srcdir_file={'����','������','С','��','ǳ','��','δ��ȫ��������','��ȫ��������'};

srcdir_root=data_root;
 
srcdir=strcat(srcdir_root,'\',srcdir_category);

%current_file='C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\С��\0';
cd(result_feature_dir);
mkdir(srcdir_category);

sub_name={'1' '2' '3' '4' '5'};
[row,com]=size(sub_name);
%srcdir_sub�Ǹ�������ȡ������ͼ��
srcdir_sub={};
for i=1:1:com
    srcdir_sub_one=strcat(srcdir,'\',sub_name(i));
    srcdir_sub{i}=srcdir_sub_one;
end
%������ȡ�󱣴浽��Ӧ��txt�ı��У��ļ���һ��
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

