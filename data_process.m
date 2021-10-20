% ��NUS-WIDE-OBJԭʼtxt���ݼ�����ȡ���������ű�ʾ��һά��ǩ��Ϣtrain_label/test_label
% ����ԭʼ�ļ���������ȡ��ÿһ��ı�ǩ����label_name
% Written by Liu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

labelpath='E:\3-Datesets\4-NUS-WIDE-OBJECT\ground truth\';
feapath = 'E:\3-Datesets\4-NUS-WIDE-OBJECT\low level features\';
%�˴��ļ���ַ��Ϊ��Ҫ���ļ���·��
labelfiles = dir(strcat(labelpath,'*.txt')); trfeafiles = dir(strcat(feapath, 'Train*.txt')); tefeafiles = dir(strcat(feapath, 'Test*.txt')); 
labelLengthFiles = length(labelfiles); fealengthFiles = 5;
trfea = cell(1, 5); tefea = cell(1, 5);
%��ȡѵ�������Ͳ�������������
for i = 1: fealengthFiles
    trfea{1, i} = readmatrix(strcat(feapath, trfeafiles(i).name));
    tefea{1, i} = readmatrix(strcat(feapath, tefeafiles(i).name));
end

total_label = cell(labelLengthFiles,1);
TrainLabel = cell(31, 1); TestLabel = cell(31, 1);
label_name = cell(31, 1);

%��ȡ��ÿһ���0/1��ʾ�ı�ǩ����
nl = 1; tl = 1;
for i = 1:labelLengthFiles
    total_label{i} = readmatrix(strcat(labelpath,labelfiles(i).name));   
    if mod(i, 2)==0
        TrainLabel{nl} = total_label{i}'; str = labelfiles(i).name;
        splitstr = regexp(str, 'Train', 'split');  % ����������ȡ�������
        label_name{nl} = splitstr{1};
        nl = nl + 1;
    else
        TestLabel{tl} = total_label{i}';
        tl = tl + 1;
    end
end
clear tl nl i Files str splitstr

TrainLabel = cell2mat(TrainLabel); TestLabel = cell2mat(TestLabel);
[class_num, train_sample_num] = size(TrainLabel);
train_label = zeros(train_sample_num, 5); 
[~, test_sample_num] = size(TestLabel);
test_label = zeros(test_sample_num, 5);
tr_sam_cla_num = zeros(train_sample_num, 1);
te_sam_cla_num = zeros(test_sample_num, 1);

% ��Щ�������ڶ���࣬���ﰴ��label_name�е����˳����ȡ��ÿ������������������𣬴洢��train_label��test_label��
for n = 1: class_num
    % train samples
    tr_sample_idx = find(TrainLabel(n, :));
    tr_sam_cla_num(tr_sample_idx) = tr_sam_cla_num(tr_sample_idx) + 1;
    tr_co_idx = tr_sam_cla_num(tr_sample_idx);
    for m = 1:size(tr_sample_idx, 2)  % ��������������λ�ö�Ӧ
        train_label(tr_sample_idx(m), tr_co_idx(m)) = n;
    end
    % test samples
    te_sample_idx = find(TestLabel(n, :));
    te_sam_cla_num(te_sample_idx) = te_sam_cla_num(te_sample_idx) + 1;
    te_co_idx = te_sam_cla_num(te_sample_idx);
    for m = 1:size(te_sample_idx, 2)
        test_label(te_sample_idx(m), te_co_idx(m)) = n;
    end
end




