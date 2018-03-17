% Read and show image
im = imread('wdg.png');
figure, imshow(im)

% Convert image from RGB to grey and show its histogram
imG = zeros(size(im,1),size(im,2));
figure, imhist(imG);

% Segment image according to its grey level thresholds 
low_thresh = 120;
high_thresh = 180;
seg_im = zeros(size(im));

figure, imshow(seg_im)