%对图像进行二值化处理
loaddir = 'C:\Files\研究学习\研究生课程\信息智能处理\手写体数字识别训练数据\pics\';
savedir = 'C:\Files\研究学习\研究生课程\信息智能处理\手写体数字识别训练数据\pics1\';
for i = 0:0
   file_path = [loaddir,num2str(i),'\']; 
   for j = 500:500
      image_path = [file_path,num2str(j),'.jpg'];
      image = imread(image_path);
%       figure(1)
%       imshow(image)
%       title('原始图像')
      thresh=graythresh(image); %graythresh为自动确定二值化阈值函数，大于该阈值的就变成白色，小于该阈值的就变成黑色，所以阈值越大越黑，阈值越小越白
      image_bv=uint8(imbinarize(image,thresh))*255;%如果想要自己设定阈值，那么就可以这样写Pic2=im2bw(original_picture,value);,value=[0,1]中间的任何数值
%       figure(2);
%       imshow(image_bv);
%       title('二值化图像')
      
      save_path =  [savedir,num2str(i)];
      if exist(save_path)==0   %该文件夹不存在，则直接创建
        mkdir(save_path);
      end
      imwrite(image_bv,[save_path,'\',num2str(j),'.jpg']);
   end
end