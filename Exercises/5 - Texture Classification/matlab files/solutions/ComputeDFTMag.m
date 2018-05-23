function imageFeatures = ComputeDFTMag(img)

img = im2double(img);
% compute DFT
DFTimg = fft2(img);
% take magnitude of DFT
imageFeatures = abs(DFTimg(:));

end