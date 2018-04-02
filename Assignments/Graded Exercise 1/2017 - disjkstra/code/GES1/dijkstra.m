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

edge_cost = C - thresholded_grad;
num_rows = size(thresholded_grad, 1);
num_cols = size(thresholded_grad, 2);

distance_mask = ones(num_rows, num_cols) * inf;
visited_pixels = zeros(num_rows, num_cols);
previous_pixel = zeros(num_rows, num_cols, 2);

distance_mask(ridge_start_row, ridge_start_col) = 0;

while(sum(visited_pixels(:)) < num_rows * num_cols)
  % Find the pixel that is not visited yet and
  % that contains minimum distance_mask value
  cur_row=...
  cur_col=...


  % Mark this pixel as visited
  visited_pixels(cur_row, cur_col) = 1;

  %Now update the distance_mask and previous_pixel for all neighbours (i, j)
  %of current pixel based on the condition:
  %distance_mask(i, j) > distance_mask(cur_row, cur_pos) + edge_cost(i, j)
  %You should have here 4 similar statements for pixel above, below, to the
  %left and to the right of (cur_row, cur_col).
  %Remember to check if you are getting outside of the array bounds
  %
  % Complete the code here

end
