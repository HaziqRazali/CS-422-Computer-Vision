%% Introduction
%
%Let's read and view the image.
img = imread('figures/mountain.png');
%Image is small, so we will scale it when viewing. Tune this for your screen
imscale = 4;

%These are the start and end point between which we want to find a ridge
ridge_start_row = 67;
ridge_start_col = 15;
ridge_end_row = 35;
ridge_end_col = 150;

figure(1);
imshow(imresize(img, imscale));
viscircles([ridge_start_col ridge_start_row] * imscale, 5);
viscircles([ridge_end_col ridge_end_row] * imscale, 5);
title 'Original image with start and end of ridge annotated';


%% 1.1 Computing the gradient image
%
% Ex. 1.1 - 1. Convert image to grayscale and double
imgray = ...

% Ex. 1.1 - 2. Smooth the images using Gaussian filter of size 7x7, whats the trade-off of a bigger mask?
imsmooth = ...

% Ex. 1.1 - 3. Compute x- and y-gradients using Sobel mask, and gradient magnitude
my_grad_x = ...
my_grad_y = ...
my_grad_magnitude = ...

% Viewing results and comparing with the matlab gradient function, whats the difference?
[grad_x, grad_y] = gradient(imgray);
grad_magnitude = grad_x.^2 + grad_y.^2;

figure(2);
subplot 121;
imshow(imresize(imgray, imscale));
title 'Image converted to grayscale';
subplot 122;
imshow(imresize(imsmooth, imscale));
title 'Result after applying gaussian smoothing';

figure(3);
subplot 121;
imagesc(imresize(my_grad_magnitude, imscale));
title 'Gradient magnitude computed using Sobel filters';
subplot 122;
imagesc(imresize(grad_magnitude, imscale));
title 'Gradient magnitude computed via matlab gradient function';

% Ex 1.1 - 4. threshold the gradient image to see the most pronounced edges
threshold = ...

thresholded_grad = double(grad_magnitude > threshold);
figure(4);
imagesc(imresize(thresholded_grad, imscale));
title 'Thresholded gradient image';


%% 1.2 Computing the shortest paths
%
%Let's do the Dijkstra algorithm. Here we will compute the
%distances from the starting point, pixel (ridge_start_row, ridge_start_col)
%to all pixels in the image. We will also keep for each pixel previous pixel
%that lies on the shortest path to the starting point. For this
%particular problem, we will define the cost of the edge to pixel (i, j)
%from any of its 4-neighbors is defined as C - thresholded_grad(i, j)
%
%Complete the code in Dijkstra.m
%
C = 1.05;
[distance_mask, previous_pixel] =...
dijkstra(thresholded_grad, C, ridge_start_row, ridge_start_col);
%
% Let's view the distance matrix
figure(5);
imagesc(distance_mask);
colorbar;
title 'Distance matrix from Dijkstra algorithm';

%% Ex 1.3. Ridge deliniation
%
%Now let's use the obtained matrix of distances and the matrix that shows
%previous pixel in the shortest path to reconstruct the path from
%(ridge_end_row, ridge_end_col) back to (ridge_start_row, ridge_start_col)
%recovered_path should have non-zero entries for all pixels on the path
%from (ridge_end_row, ridge_end_col) back to (rige_start_row, ridge_start_col)
%
recovered_path = zeros(size(distance_mask));
recovered_path = ...
% Complete the code here

figure(6);
img_with_ridge = img;
img_with_ridge(recovered_path > 0) = 255;
imshow(imresize(img_with_ridge, imscale));
title 'Final result with outlined ridge';

%% Ex 1.4. Evaluating the edge cost
%
%Try various values of C in Dijkstra algorithm. How does the distance mask
%and the final detected ridge change? Do you understand why?
