function [x_normalized, T] = normalizePoints(x)
    % This function normalizes the 2d points expressed in homogeneous
    % coordinates such that they have a mean (0,0) and have an
    % average norm of 1.
    % inputs :
    % x : 2xN matrix of 2d points, or 3xN matrix of 2d points in homogeneous coordinates.
    % outputs:
    % x_normalized : 3xN matrix of normalized 2d points in
    % homogeneous coordinates.
    % T : 3x3 transformation matrix that normalizes the input points.
    
    
    % You don't have to touch anything here !!!
    
    if (size(x,1) ==2)
        x = [x; ones(1, size(x,2))];
    end
    m = mean(x,2);
    T = inv([m(1)+m(2) 0 m(1)/2;0 m(1)+m(2) m(2)/2;0 0 1]);
    x_normalized = T * x;
    x_normalized = x_normalized(1:2,:);
end

