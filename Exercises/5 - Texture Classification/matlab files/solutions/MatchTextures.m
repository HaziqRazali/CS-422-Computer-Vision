function label = MatchTextures(testFeatures, templateFeatures)
% NOTE: this function can be used to calculate the distance between test
% and template images using any of the three feature extraction methods

minDist = 10000000000;
for i=1:size(templateFeatures,1)
    % find distance between test image and given template image
    temp_dist = sqrt(sum((testFeatures - templateFeatures(i,:)).^2))/length(testFeatures);
    if temp_dist < minDist
        minDist = temp_dist;
        %assign to closest class
        label = i;
    end
end