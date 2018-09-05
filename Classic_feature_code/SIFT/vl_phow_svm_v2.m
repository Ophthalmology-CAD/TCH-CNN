function vl_phow_svm_v2(data_file,createfile,class1,class2)
% clc;
% clear all;

%  srcDir=uigetdir('Choose source directory.'); %���ѡ����ļ���
% srcDir='C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\sift+svmʵ��\bigorsmall';
% conf.calDir = srcDir ;%���ɽ������Ŀ¼
% class1='С';
% class2='��';
% data_file='C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����\test_data';
% createfile='C:\Users\mingmin\Desktop\cnnӦ��\zhangkai����';

test1=strcat(data_file,'\',class1);
test2=strcat(data_file,'\',class2);


cd(createfile);
mkdir(class1);
mkdir(class2);


conf.calDir = test1 ;%���ɽ������Ŀ¼


%������
conf.numClasses = 4 ;%ѡ���ļ������ڸ�Ŀ¼������ֻ�б�ѡ�ļ���һ���ļ���
conf.numWords = 600 ;%kmeans�ã�600����������
conf.numSpatialX = [2 4] ;
conf.numSpatialY = [2 4] ;
conf.quantizer = 'kdtree' ;
conf.svm.solver = 'sdca' ;
conf.phowOpts = {'Step', 3} ;


%ѵ����1��SIFT



classes = dir(conf.calDir) ;
classes= classes([classes.isdir]) ;
classes = {classes(3:conf.numClasses+2).name} ;
model.classes = classes ;
model.phowOpts = conf.phowOpts ;
model.numSpatialX = conf.numSpatialX ;
model.numSpatialY = conf.numSpatialY ;
model.quantizer = conf.quantizer ;
model.vocab = [] ;
model.w = [] ;
model.b = [] ;
model.classify = @classify ;


every_sub_file={'1','2','3','4' '5'};

com=length(every_sub_file);
% com=1;
for i=1:1:com
    [descrs_everyone,images_everyone]=getdescribes(test1,classes,every_sub_file{i},model);
    descrs_every{i}=descrs_everyone;
    images_every{i}=images_everyone;
%     descrs=[descrs,descrs_everyone];
end

for i=1:1:com
    [descrs_everyone,images_everyone]=getdescribes(test2,classes,every_sub_file{i},model);
    descrs_every{i+com}=descrs_everyone;
    images_every{i+com}=images_everyone;
%     descrs=[descrs,descrs_everyone];
end

 
  %���м���SIFT�����ϲ�
  descrs={};
  for i=1:1:com*2
     descrs=[descrs,descrs_every{i}];
  end
  %ѡȡ����10000��
  descrs = vl_colsubset(cat(2, descrs{:}), 10e4) ;
  descrs = single(descrs) ;
  % Quantize the descriptors to get the visual words
  %��þ�������
  vocab = vl_kmeans(descrs, conf.numWords, 'verbose', 'algorithm', 'elkan', 'MaxNumIterations', 50) ;
  
model.vocab = vocab ; 
if strcmp(model.quantizer, 'kdtree')
  model.kdtree = vl_kdtreebuild(vocab) ;
end


% --------------------------------------------------------------------
%                                           Compute spatial histograms
% --------------------------------------------------------------------
%��ȡ�����ļ���1 

cd(createfile);
cd(class1);
every_sub_file={'1','2','3','4' '5'};
save_file_name={'1.txt','2.txt','3.txt','4.txt','5.txt'}
% com=length(every_sub_file);
for i=1:1:com
    [features]=get_hists(test1,classes,images_every{i},model);
     save(save_file_name{i},'-ascii','features');
%     descrs=[descrs,descrs_everyone];
end

cd(createfile);
cd(class2);
for i=1:1:com
    [features]=get_hists(test2,classes,images_every{i+com},model);
     save(save_file_name{i},'-ascii','features');
%     descrs=[descrs,descrs_everyone];
end




  



%--------------------------------------------------------------------------
function [descrs5,images5] = getdescribes(data_file,classes,sub_file,model)%���ɽ������Ŀ¼) 
 %��ȡ��5���ļ���������ͼƬ
 
conf.calDir = data_file ;%���ɽ������Ŀ¼
images5 = {} ;
ims = dir(fullfile(conf.calDir,sub_file, '*.jpg'))' ;
ims = cellfun(@(x)fullfile(sub_file,x),{ims.name},'UniformOutput',false) ;
h5=length(ims);%h5����ѵ����5��ͼƬ����
images5 = {images5{:}, ims{:}} ;

descrs5 = {} ;%ѵ����5��SIFT������������
 parfor ii = 1:1:h5
    im = imread(fullfile(conf.calDir, images5{ii})) ;
    im = standarizeImage(im) ;
    [drop, descrs5{ii}] = vl_phow(im, model.phowOpts{:}) ;%������ȡ����
 end

function [features] = get_hists(data_file,classes,images1,model)%���ɽ������Ŀ¼) 

conf.calDir = data_file 
hists1 = {} ;
  h1=length(images1);
  parfor ii = 1:h1
    im = imread(fullfile(conf.calDir, images1{ii})) ;
    hists1{ii} = getImageDescriptor(model, im);
  end
  hists1 = cat(2, hists1{:}) ;
  features=hists1';
  features=double(features);

  
% -------------------------------------------------------------------------
function im = standarizeImage(im)
% -------------------------------------------------------------------------

im = im2single(im) ;
if size(im,1) > 480, im = imresize(im, [480 NaN]) ; end

% -------------------------------------------------------------------------
function hist = getImageDescriptor(model, im)
% -------------------------------------------------------------------------

im = standarizeImage(im) ;
width = size(im,2) ;
height = size(im,1) ;
numWords = size(model.vocab, 2) ;

% get PHOW features
[frames, descrs] = vl_phow(im, model.phowOpts{:}) ;

% quantize local descriptors into visual words
switch model.quantizer
  case 'vq'
    [drop, binsa] = min(vl_alldist(model.vocab, single(descrs)), [], 1) ;
  case 'kdtree'
    binsa = double(vl_kdtreequery(model.kdtree, model.vocab, ...
                                  single(descrs), ...
                                  'MaxComparisons', 50)) ;
end

for i = 1:length(model.numSpatialX)
  binsx = vl_binsearch(linspace(1,width,model.numSpatialX(i)+1), frames(1,:)) ;
  binsy = vl_binsearch(linspace(1,height,model.numSpatialY(i)+1), frames(2,:)) ;

  % combined quantization
  bins = sub2ind([model.numSpatialY(i), model.numSpatialX(i), numWords], ...
                 binsy,binsx,binsa) ;
  hist = zeros(model.numSpatialY(i) * model.numSpatialX(i) * numWords, 1) ;
  hist = vl_binsum(hist, ones(size(bins)), bins) ;
  hists{i} = single(hist / sum(hist)) ;
end
hist = cat(1,hists{:}) ;
hist = hist / sum(hist) ;
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------

function [image, descriptors, locs] = sift(imageFile)

% Load image
image = imread(imageFile);

% If you have the Image Processing Toolbox, you can uncomment the following
%   lines to allow input of color images, which will be converted to grayscale.
% if isrgb(image)
%    image = rgb2gray(image);
% end

[rows, cols] = size(image); 

% Convert into PGM imagefile, readable by "keypoints" executable
f = fopen('tmp.pgm', 'w');
if f == -1
    error('Could not create file tmp.pgm.');
end
fprintf(f, 'P5\n%d\n%d\n255\n', cols, rows);
fwrite(f, image', 'uint8');
fclose(f);

% Call keypoints executable
if isunix
    command = '!./sift ';
else
    command = '!siftWin32 ';
end
command = [command ' <tmp.pgm >tmp.key'];
eval(command);

% Open tmp.key and check its header
g = fopen('tmp.key', 'r');
if g == -1
    error('Could not open file tmp.key.');
end
[header, count] = fscanf(g, '%d %d', [1 2]);
if count ~= 2
    error('Invalid keypoint file beginning.');
end
num = header(1);
len = header(2);
if len ~= 128
    error('Keypoint descriptor length invalid (should be 128).');
end

% Creates the two output matrices (use known size for efficiency)
locs = double(zeros(num, 4));
descriptors = double(zeros(num, 128));

% Parse tmp.key
for i = 1:num
    [vector, count] = fscanf(g, '%f %f %f %f', [1 4]); %row col scale ori
    if count ~= 4
        error('Invalid keypoint file format');
    end
    locs(i, :) = vector(1, :);
    
    [descrip, count] = fscanf(g, '%d', [1 len]);
    if (count ~= 128)
        error('Invalid keypoint file value.');
    end
    % Normalize each input vector to unit length
    descrip = descrip / sqrt(sum(descrip.^2));
    descriptors(i, :) = descrip(1, :);
end
fclose(g);


