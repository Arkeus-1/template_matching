
clear all;
clc; 
rgb_image=imread('car.jpg');
template_image=imread('rotated_template.jpg');
g_img=rgb2gray(rgb_image);
g_template=rgb2gray(template_image);
rotation=[90 45 34];

[Img_r Img_c]=size(g_img);
imshow(g_template)
Coordinate=zeros(length(rotation),2);
C_values=zeros(1,length(rotation));
Temp=zeros(length(rotation),2);

for rotn=1:length(rotation)
    g_template_rot= imrotate(g_template,rotation(rotn));
    [Temp_r Temp_c]=size(g_template_rot);
    Temp(rotn,:)=[Temp_r,Temp_c];
    diff_row=Img_r-Temp_r+1;
    diff_col=Img_c-Temp_c+1;
    C=zeros(diff_row,diff_col);
    for j=1:diff_col
        for i=1:diff_row
            Sub=g_img(i:i+Temp_r-1, j:j+Temp_c-1)-g_template_rot;
            C(i,j)=sqrt(sumsqr(Sub));
        end
    end
    [ymin,xmin] = find(C==min(C(:)))
    Coordinate(rotn,:)=[ymin,xmin];
    C_values(rotn)= min(C(:));
end
MIN=find(C_values==min(C_values))
CD =Coordinate(MIN,:);
rotated_template= imrotate(g_template,rotation(MIN));
[Temp_r Temp_c]=size(rotated_template);
image= insertShape(g_img,'rectangle',[CD(2) CD(1) Temp_c Temp_r],'LineWidth',3,'Color','r');        
figure;
imshow(image)