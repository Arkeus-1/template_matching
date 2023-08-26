clear all;
clc; 
rgb_image=imread('america.jpg');
template_image=imread('Capture.jpg');
g_img=rgb2gray(rgb_image);
g_template=rgb2gray(template_image);

[Img_r Img_c]=size(g_img);
[Temp_r Temp_c]=size(g_template);
imshow(g_template)

diff_row=Img_r-Temp_r+1;
diff_col=Img_c-Temp_c+1;
C=zeros(diff_row,diff_col);
for j=1:diff_col
    for i=1:diff_row
        Sub=g_img(i:i+Temp_r-1, j:j+Temp_c-1)-g_template;
        C(i,j)=sqrt(sumsqr(Sub));
    end
end


[ymax,xmax] = find(C==min(C(:)))
image= insertShape(g_img,'rectangle',[xmax ymax Temp_c Temp_r],'LineWidth',3,'Color','r');        
figure;
imshow(image)




