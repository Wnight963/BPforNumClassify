%������ͼƬ����ת���ɾ���
clear
clc
loaddir = 'C:\Files\�о�ѧϰ\�о����γ�\��Ϣ���ܴ���\��д������ʶ��ѵ������\pics1\';
for i = 0:9
   file_path = [loaddir,num2str(i),'\']; 
   for j = 1:500
      image_path = [file_path,num2str(j),'.jpg'];
      image = imread(image_path);
%       figure(1)
%       imshow(image)
%       title('ԭʼͼ��')
    vector = reshape(im2double(image),[1,400]);
    if i == 0 && j ==1
        X = vector;
    else
        X = vertcat(X,vector);
    end
   

   end
end
size(X)
if exist(loaddir)==0   %���ļ��в����ڣ���ֱ�Ӵ���
    mkdir(loaddir);
end
save([loaddir,'\X.mat'],'X')
      