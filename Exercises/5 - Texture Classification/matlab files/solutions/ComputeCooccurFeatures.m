function cooccurFeats = ComputeCooccurFeatures(img,offset)

% we can see some effects by setting large offset; if we set too small
% offset, the textures will be indistinguishable (you can convince youself)

glcm = graycomatrix(img,'Offset',offset);

% normalize glcm so that it contains probabilities rather than counts
glcm = glcm/(sum(sum(glcm)));
contrast = 0;
dissimilarity = 0;
homogeneity = 0;
% compute features
for i=1:size(glcm,1)
    for j=1:size(glcm,2)
            contrast = contrast + glcm(i,j)*(i-j)^2;
            dissimilarity = dissimilarity + glcm(i,j)*abs(i-j);
            homogeneity = homogeneity + glcm(i,j)/(1+(i-j)^2);
    end
end
    energy = sum(sum(glcm.^2));
    entropy = -sum(sum(glcm.*log(glcm+ eps)));

cooccurFeats = [contrast; dissimilarity; homogeneity; energy; entropy];

end
            