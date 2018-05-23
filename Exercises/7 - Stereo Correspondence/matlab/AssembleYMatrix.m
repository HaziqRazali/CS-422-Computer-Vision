function Y = AssembleYMatrix(pixelsNormImageL, pixelsNormImageR)
    % inputs : 3 x nPoints arrays of corresponding pixels on the left and
    % right image, respectively.
    % output : matrix Y of the linear system for the estimation of the
    % fundamental matrix
    
    xl = pixelsNormImageL(1,:);
    xr = pixelsNormImageR(1,:);
    yl = pixelsNormImageL(2,:);
    yr = pixelsNormImageR(2,:);
        
    nPoints = size(pixelsNormImageL, 2);
    
    %Y = [xr.*xl; xr.*yl]
    Y = [xr.*xl; xr.*yl; xr; yr.*xl; yr.*yl; yr; xl; yl; ones(1,nPoints)];
    Y = Y';
    
end