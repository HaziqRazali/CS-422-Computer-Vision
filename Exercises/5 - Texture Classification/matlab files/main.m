temp = dir('template_images/*.jpg');
test = dir('test_images/*.jpg');

cd template_images
for i=1:length(temp)
    templates(:,:,i) = rgb2gray(imread(temp(i).name));
end

cd ../test_images

for i=1:length(test)
    tests(:,:,i) = rgb2gray(imread(test(i).name));
end

cd ../

%% Ex 1.1 Create filter bank

wave = [2 5 10 15];
angle = [0 45 90 125 180];

offsets = [0 1; 0 10; 0 100];

[A,B] = meshgrid(wave,angle);
c=cat(2,A',B');
d=reshape(c,[],2);

filters = CreateFilterBank(d(:,1),d(:,2));

%% Ex 1.2 Extract Gabor filters features

for i=1:size(templates,3)
    templateFeatures(i,:) = ComputeFeatures(templates(:,:,i),filters);   
end

for i=1:size(tests,3)
    testFeatures(i,:) = ComputeFeatures(tests(:,:,i),filters);
end

%% Ex 1.3 Match test images to the closest template

for i=1:size(tests,3)
    label(i) = MatchTextures(testFeatures(i,:),templateFeatures);
end

%% Ex 1.4 Extract DFT features

for i=1:size(templates,3)
    templateFeaturesDFT(i,:) = ComputeDFTMag(templates(:,:,i));   
end

for i=1:size(tests,3)
    testFeaturesDFT(i,:) = ComputeFDFTMag(tests(:,:,i));
end

%% Ex 1.5 Match test images to the closest template

for i=1:size(tests,3)
    labelDFT(i) = MatchTextures(testFeaturesDFT(i,:),templateFeaturesDFT);
end

%% Ex 1.6 Extract cooccrance matrix features

% Investigate effect of different offsets

offset = offsets(1,:);

for i=1:size(templates,3)
    templateFeaturesCooccur(i,:) = ComputeCooccurFeatures(templates(:,:,i),offset);   
end

for i=1:size(tests,3)
    testFeaturesCooccur(i,:) = ComputeCooccurFeatures(tests(:,:,i),offset);
end

%% Ex 1.7 Match test images to the closest template

for i=1:size(tests,3)
    labelCooccur(i) = MatchTextures(testFeaturesCooccur(i,:),templateFeaturesCooccur);
end