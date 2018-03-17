% Load images
img1 = imread('street1.gif');
img2 = imread('street2.gif');

% Convert them to double and assign to img1d and img2d
img1d = zeros(size(img1));
img2d = zeros(size(img2));

% Subtract second image form the first one, store the result in imgSub and show
imgSub = zeros(size(img1));
figure(1)
imagesc(imgSub);
colormap('gray')

% Check whats the result using imsubtract, store in imgSub2 and show
imgSub2 = zeros(size(img1));
figure(2)
imagesc(imgSub2);
colormap('gray')