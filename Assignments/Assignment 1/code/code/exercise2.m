% Get the names of all images and store in list_images
img_folder = 'sequence1/';
img_ext = '*.jpg';
list_images = [];

% Read all images and store them as a 4D array, you can access the i-th
% image name using list_images(i).name
for i = 1:length(list_images)
    imgs(:,:,:,i) = [];
end

%% Method 1: subtract mean background image

% Calculate the mean (background) image  mean_img for each channel
mean_img = zeros(size(imgs,1),size(imgs,2),size(imgs,3));
figure, imshow(uint8(mean_img))

% Subtract background image from image at a given frame and find average
% difference image
frame_no=1;
diff_img = zeros(size(mean_img)); 
avg_diff_img = mean(diff_img, 3);
figure, imshow(uint8(avg_diff_img))

% Calculate std_dev image for each channel
std_dev = zeros(size(mean_img));

% Calculate threshold image using diff_img, std_dev img and th
th =  1.5;
thresh_img = zeros(size(diff_img));

% Calculate average threshold image
avg_thresh = mean(thresh_img, 3);
figure, imshow(avg_thresh, [])