function F = EstimateFundamentalMatrix(pixelsImageL, pixelsImageR)
    % input : 2 x N arrays of pixels on the left and right image
    % output F : 3x3 fundamental matrix
    
    % You don't have to touch anything here !!!
    
    
    % 1. normalize points st their mean is 0 and their average norm is 1
    [pixelsImageLNorm, TL] = normalizePoints(pixelsImageL);
    [pixelsImageRNorm, TR] = normalizePoints(pixelsImageR);
    
    %2. Assemble Y matrix
    Y = AssembleYMatrix(pixelsImageLNorm, pixelsImageRNorm);
    
    %3. Solve linear system and enforce 2-rank constraint
    [U,S,V] = svd(Y);
   
    F_norm = reshape(V(:,end),3,3)';
    
    [uf,sf,vf] = svd(F_norm);
    F_norm_prime = uf*diag([sf(1) sf(5) 0])*(vf');
    
    %4. de-normalize F
    F = TR' * F_norm_prime* TL;
end

