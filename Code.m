
% Image read
img = imread('A1H-17.tif');

%If image is rgb or not
if ndims(img) == 3
        img = rgb2gray(img);
end

level = graythresh(img); % Level set to binarize the image
BW = imbinarize(img,level);
%figure, imshow(BW)

%imshowpair(img,BW,'montage')
figure
imshow(BW)
stats = regionprops('table',BW,'Centroid',...
    'MajorAxisLength','MinorAxisLength') % Detects and localizes regular shapes in the given image

centers = stats.Centroid; % only store/access centres detected.

diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2); % Diameter calculation using Mean

% To detect lateral or ap
[centers2,radii2] = imfindcircles(img,[6 15],"ObjectPolarity","bright");

radii = diameters/2;
hold on
viscircles(centers,radii);
hold on

if length(centers2) == 2
       disp('The image is Lateral')
else
    disp('The image is AP')
end


%img = imread('D3-Lat-75-2.tif');

%If image is rgb or not
 if ndims(img) == 3
        img = rgb2gray(img);
 end
 
 level = graythresh(img)
 BW = imbinarize(img,level);
 se = strel('line',5,0); % We created a structural element with lenght 5, angle 0
 BW2 = imdilate(BW,se);
 BW3 = imerode(BW2,se);
 BWc2 = imclearborder(BW3,26);
 BWc2 = bwareaopen(BWc2, 25000);
 %figure
 %imshow(BWc2);
 
 BW1 = edge(BWc2,'sobel');
 figure
 imshow(BW1);
%  figure
%  imshowpair(img,BW1,'Circle and Edge Detection')
 


