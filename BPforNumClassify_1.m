%?实现一个手写体数字识别的神经网络训练程序
clc;
clear;
save_path = 'C:\Files\研究学习\研究生课程\信息智能处理\手写体数字识别训练数据\results\result';
load('data.mat', 'X');
load('data.mat','y');

%测试集100张图片
testData=[X(1:10,:);X(501:510,:);X(1001:1010,:);X(1501:1510,:);X(2001:2010,:);X(2501:2510,:);X(3001:3010,:);X(3501:3510,:);X(4001:4010,:);X(4501:4510,:)];
testResult=[y(1:10,:);y(501:510,:);y(1001:1010,:);y(1501:1510,:);y(2001:2010,:);y(2501:2510,:);y(3001:3010,:);y(3501:3510,:);y(4001:4010,:);y(4501:4510,:)];

% image = reshape(X(1,:),20,20);
% imshow(image)

%准备训练数据
num=200; %每个数字训练数据集的大小,最大490
trainingData=[X(11:10+num,:);X(511:510+num,:);X(1011:1010+num,:);X(1511:1510+num,:);X(2011:2010+num,:);X(2511:2510+num,:);X(3011:3010+num,:);X(3511:3510+num,:);X(4011:4010+num,:);X(4511:4510+num,:)];
trainingTarget=[y(11:10+num,:);y(511:510+num,:);y(1011:1010+num,:);y(1511:1510+num,:);y(2011:2010+num,:);y(2511:2510+num,:);y(3011:3010+num,:);y(3511:3510+num,:);y(4011:4010+num,:);y(4511:4510+num,:)];

trainingTarget(1:num) = zeros(1,num);
testResult(1:10) = zeros(1,10);
save('trainingTarget.mat','trainingTarget')

trainX = trainingData';
trainT = trainingTarget';
testX = testData';
testT = testResult';
algorithms = char('traingd','traingdx','trainrp','traincgf','traincgp','traincgb','trainscg','trainoss','trainbr','trainlm');
node_s = [20,30,40,50,60];
mc_s = [0.5,0.6,0.7,0.8,0.9];
lr_s = [0.01,0.005,0.001,0.0005,0.0001];
regression_test = zeros(1,5);
regression_train = zeros(1,5);
performance_test = zeros(1,5);
performance_train = zeros(1,5);
for i = 1:length(node_s)
    % [x,t] = building_dataset;
    net = feedforwardnet([node_s(i),10]);
%     net.trainFcn = strtrim(algorithms(3,:));
    net.trainFcn = 'traincgf';
%     net.divideParam.trainRatio = 70/100;
%     net.divideParam.valRatio = 15/100;
%     net.divideParam.testRatio = 15/100;
    net.trainParam.epochs = 10000; %设置训练回合数
    net.trainParam.goal = 0; %设置训练目标
%     net.trainParam.lr = lr_s(i); % 设置学习率
%     net.trainParam.mc = 0.9;
%     net.trainParam.max_fail = 100;
    net.divideFcn = '';
    
    % 训练神经网络
    [net,TR] = train(net,trainX,trainT);
    view(net)
   
    file_path_name_ = [save_path,num2str(i)];
    if exist(file_path_name_)==0   %该文件夹不存在，则直接创建
        mkdir(file_path_name_);
    end
    
    trainY = net(trainX);
    testY = net(testX);
    R_train = regression(trainT,trainY);
    R_test = regression(testT,testY);
    regression_train(i) = R_train;
    regression_test(i) = R_test;
    
    P_train = perform(net,trainT,trainY);
%     errors = gsubtract(testY,testT);
    P_test = perform(net,testT,testY);
    performance_train(i) = P_train;
    performance_test(i) = P_test;
    
    plotperform(TR);
    saveas(gcf,[file_path_name_,'\perform.fig'])
    saveas(gcf,[file_path_name_,'\perform.jpg'])
    plottrainstate(TR);
    saveas(gcf,[file_path_name_,'\trainstate.fig'])
    saveas(gcf,[file_path_name_,'\trainstate.jpg'])
    plotregression(trainT,trainY,'Regression');
    saveas(gcf,[file_path_name_,'\regression_train.fig'])
    saveas(gcf,[file_path_name_,'\regression_train.jpg'])
    plotregression(testT,testY,'Regression');
    saveas(gcf,[file_path_name_,'\regression_test.fig'])
    saveas(gcf,[file_path_name_,'\regression_test.jpg'])
    
    
end

file_path_name_ = [save_path,'result_data'];
if exist(file_path_name_)==0   %该文件夹不存在，则直接创建
    mkdir(file_path_name_);
end
save([file_path_name_,'\result_data.mat'],'regression_train','regression_test','performance_train','performance_test')



