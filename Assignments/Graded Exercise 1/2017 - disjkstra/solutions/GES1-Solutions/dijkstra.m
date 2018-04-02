function [distance_mask, previous_pixel] = dijkstra(thresholded_grad, C, ridge_start_row, ridge_start_col)
%In this particular implementation of Dijkstra algorithm, we need to find the
%mask of shortest distances from the start point to all pixels. We can only
%travel between pixels that share a common border. The cost of going to pixel
%(i, j) is C - thresholded_grad(i, j).
%
%We need to return two values:
%distance_mask(i, j) should contain shortest distance from starting pixel
%to pixel (i, j). Distance mask should have the same size as the input
%thresholded gradient mask.
%
%previous_pixel(i, j, :) contains for every pixel (i, j) the previous pixel
%on the shortest path back to the starting pixel. In other words,
%previous_pixel(i, j, 1) = i', previous_pixel(i, j, 2) = j', where
%(i', j') is one of four neighbors of (i, j).

% Going through 
% - edges require cost of 0.05
% - non edges require cost of 1.05
edge_cost = C - thresholded_grad;

num_rows = size(thresholded_grad, 1);   % row of input image
num_cols = size(thresholded_grad, 2);   % col of input image

distance_mask = ones(num_rows, num_cols) * inf;  % distance image
visited_pixels = zeros(num_rows, num_cols);      % visited pixels
previous_pixel = zeros(num_rows, num_cols, 2);   % stores for each pixel, the [row,col] of the previous pixel

% initialize distance to starting point to be 0
distance_mask(ridge_start_row, ridge_start_col) = 0;

while(sum(visited_pixels(:)) < num_rows * num_cols)
  %Find the pixel that is not visited yet and
  %that contains minimum distance_mask value
  %cur_row=...
  %cur_col=...

  % 1. set pixels that have already been visited to infinity as to avoid 
  %    visiting them again since in 2, we locate the pixel with the
  %    smallest distance
  active_distances = distance_mask;
  active_distances(visited_pixels == 1) = inf;
  
  % 2. locate the position with the minimum distance and
  %    compute its row,col position via ind2sub
  [cur_dist, cur_pos] = min(active_distances(:));
  [cur_row, cur_col] = ind2sub(size(distance_mask), cur_pos);

  % 3. set current position to visited
  visited_pixels(cur_row, cur_col) = 1;

  %Now update the distance_mask and previous_pixel for all neighbours (i, j)
  %of current pixel based on the condition:
  %distance_mask(i, j) > distance_mask(cur_row, cur_pos) + edge_cost(i, j)
  %You should have here 4 similar statements for pixel above, below, to the
  %left and to the right of (cur_row, cur_col).
  %Remember to check if you are getting outside of the array bounds

  % 4. compute distance to neighbors. Note that the total distance must be
  %    greater than the previous distance as to avoid going back to the
  %    previous pixel
  if (cur_row > 1 && distance_mask(cur_row - 1, cur_col) > cur_dist + edge_cost(cur_row - 1, cur_col))
    previous_pixel(cur_row - 1, cur_col, 1) = cur_row;
    previous_pixel(cur_row - 1, cur_col, 2) = cur_col;
    distance_mask(cur_row - 1, cur_col) = cur_dist + edge_cost(cur_row - 1, cur_col);
  end

  if (cur_row < num_rows && distance_mask(cur_row + 1, cur_col) > cur_dist + edge_cost(cur_row + 1, cur_col))
    previous_pixel(cur_row + 1, cur_col, 1) = cur_row;
    previous_pixel(cur_row + 1, cur_col, 2) = cur_col;
    distance_mask(cur_row + 1, cur_col) = cur_dist + edge_cost(cur_row + 1, cur_col);
  end

  if (cur_col > 1 && distance_mask(cur_row, cur_col - 1) >...
    cur_dist + edge_cost(cur_row, cur_col - 1))
    previous_pixel(cur_row, cur_col - 1, 1) = cur_row;
    previous_pixel(cur_row, cur_col - 1, 2) = cur_col;
    distance_mask(cur_row, cur_col - 1) = cur_dist + edge_cost(cur_row, cur_col - 1);
  end

  if (cur_col < num_cols && distance_mask(cur_row, cur_col + 1) >...
    cur_dist + edge_cost(cur_row, cur_col + 1))
    previous_pixel(cur_row, cur_col + 1, 1) = cur_row;
    previous_pixel(cur_row, cur_col + 1, 2) = cur_col;
    distance_mask(cur_row, cur_col + 1) = cur_dist + edge_cost(cur_row, cur_col + 1);
  end
end
