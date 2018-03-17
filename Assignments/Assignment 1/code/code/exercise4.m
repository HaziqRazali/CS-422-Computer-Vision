% Load image
img = imread('apples.jpg');
% Read individual channels
R = zeros(size(img,1),size(img,2));
G = zeros(size(img,1),size(img,2));
B = zeros(size(img,1),size(img,2));
% Show channels separately
figure(1)
subplot(1,3,1);
imshow(R);
subplot(1,3,2);
imshow(G);
subplot(1,3,3);
imshow(B);
% Investigate histogram of each channel
figure
imhist(G);
% Get binary image using the most appriopriate channel, try different thresholds 
th1 = 0;
th2 = 50;
thImg = zeros(size(R));
figure
imagesc(thImg);
colormap('gray');
% Find and count connected components according to the size of CC, try
% different thresholds
sizeTh = 150;
[imageColor, nConnectedComponents] = CountConnectedComponents(thImg,sizeTh);
figure
imagesc(imageColor);