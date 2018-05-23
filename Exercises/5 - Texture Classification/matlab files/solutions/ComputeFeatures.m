function vect = ComputeFeatures(img,bank)

img = im2double(img);
vect = [];
for i=1:length(bank)
    % note: here we use only real part of Gabor filter
    convImg = imfilter(img,real(bank(i).SpatialKernel));
    % use mean and variance of resulting convolution image as features
    vect = [vect; mean(convImg(:)); var(convImg(:))];
end
end
        
    