function [rectifiedImageL, rectifiedImageR] = RectifyImages(imageL, imageR, pixelsImageL, pixelsImageR)
    % computes the rectified images. 
    % You don't have to touch anything here!
    addpath ./RectifKitU
    [width, height, c] = size(imageL);
    [TL,TR] = compRectif(pixelsImageL,pixelsImageR,width,height);
    bb = mcbb(size(imageL),size(imageR), TL, TR);
    for c = 1:size(imageL,3)
        [rectifiedImageL(:,:,c),bbL,alphaL] = imwarp(imageL(:,:,c), TL, 'bilinear', bb);
        [rectifiedImageR(:,:,c),bbR,alphaR] = imwarp(imageR(:,:,c), TR, 'bilinear', bb);
    end
end