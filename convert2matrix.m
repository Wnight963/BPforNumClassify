%批量将图片数据转换成矩阵
clear
clc
loaddir = 'C:\Files\研究学习\研究生课程\信息智能处理\手写体数字识别训练数据\pics1\';
for i = 0:9
   file_path = [loaddir,num2str(i),'\']; 
   for j = 1:500
      image_path = [file_path,num2str(j),'.jpg'];
      image = imread(image_path);
%       figure(1)
%       imshow(image)
%       title('原始图像')
    vector = reshape(im2double(image),[1,400]);
    if i == 0 && j ==1
        X = vector;
    else
        X = vertcat(X,vector);
    end
   

   end
end
size(X)
if exist(loaddir)==0   %该文件夹不存在，则直接创建
    mkdir(loaddir);
end
save([loaddir,'\X.mat'],'X')
      