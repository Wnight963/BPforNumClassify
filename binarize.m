%��ͼ����ж�ֵ������
loaddir = 'C:\Files\�о�ѧϰ\�о����γ�\��Ϣ���ܴ���\��д������ʶ��ѵ������\pics\';
savedir = 'C:\Files\�о�ѧϰ\�о����γ�\��Ϣ���ܴ���\��д������ʶ��ѵ������\pics1\';
for i = 0:0
   file_path = [loaddir,num2str(i),'\']; 
   for j = 500:500
      image_path = [file_path,num2str(j),'.jpg'];
      image = imread(image_path);
%       figure(1)
%       imshow(image)
%       title('ԭʼͼ��')
      thresh=graythresh(image); %graythreshΪ�Զ�ȷ����ֵ����ֵ���������ڸ���ֵ�ľͱ�ɰ�ɫ��С�ڸ���ֵ�ľͱ�ɺ�ɫ��������ֵԽ��Խ�ڣ���ֵԽСԽ��
      image_bv=uint8(imbinarize(image,thresh))*255;%�����Ҫ�Լ��趨��ֵ����ô�Ϳ�������дPic2=im2bw(original_picture,value);,value=[0,1]�м���κ���ֵ
%       figure(2);
%       imshow(image_bv);
%       title('��ֵ��ͼ��')
      
      save_path =  [savedir,num2str(i)];
      if exist(save_path)==0   %���ļ��в����ڣ���ֱ�Ӵ���
        mkdir(save_path);
      end
      imwrite(image_bv,[save_path,'\',num2str(j),'.jpg']);
   end
end