#### TCH-CNN is the code for the CC-Cruiser intelligence agent. It includes automatic localization of the lens, automatic screening and three-angles grading of pediatric cataract. Also it includes four classical feature extraction methods (LBP, SIFT, wavelet transform, color and texture features) and SVM classifier method.
- Please feel free to contact us for any questions or comments: Jiewei Jiang, E-mail: jiangjw924@126.com.
- For auto-cutting, the "cut.m" is the startup file and could be executed in MATLAB. The representative samples before and after auto-cutting is presented.
- All codes for deep-learning convolutional neural networks were executed in the Caffe (Convolutional Architecture for Fast Feature Embedding) framework with Ubuntu 14.04 64bit + CUDA (Compute Unified Device Architecture).
- The /DL-Source code/createdata contains the dataset for one-time training and testing. The training and testing records are saved as test.txt and train.txt. The script "create_imagenet.sh" is used to generate the dataset. The file "make_imagenet_mean.sh" is used to generate the mean file for dataset accordingly.
- The file "train.sh" in /DL-Source code/myself is used for network training.
- The file "test.sh" in /DL-Source code/myself is used for testing.
- The "yunxing_cnn.py" in /DL-Source code/python_script could be used to test and have the evaluation indices.


