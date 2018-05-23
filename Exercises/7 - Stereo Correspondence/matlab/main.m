%% main.m 

% You should not change anything here !!!!!!!!!!!!!!!!!!

clear
close all;

% Load the images.
imageL = imread('frame0.png');
imageR = imread('frame1.png');
[height, width] = size(imageL);

load Correspondences
% contains pixelsImageL and pixelsImageR

F = EstimateFundamentalMatrix(pixelsImageL, pixelsImageR);

% Show an example of epipolar line computed with the fundamental matrix
aPixelOnLeftImage = [164, 117, 1]';
lineCoeff = F * aPixelOnLeftImage;
x = 1:size(imageR, 2);
y = (-lineCoeff(1)/lineCoeff(2)).*x -(lineCoeff(3)/lineCoeff(2));
figure,
subplot(1,2,1)
imshow(imageL), hold all, plot(aPixelOnLeftImage(1), aPixelOnLeftImage(2), '.r')
subplot(1,2,2)
imshow(imageR),hold all,plot(x,y,'b')

% compute and shows rectified images.
% For making the 2 exercices independent, you don't need to enter F in the rectification function 
[rectifiedImageL, rectifiedImageR] = RectifyImages(imageL, imageR, pixelsImageL, pixelsImageR);

aPixelOnLeftImage = [205, 149];
figure
subplot(1,2,1)
imshow(rectifiedImageL,[]);
hold all
plot(aPixelOnLeftImage(1), aPixelOnLeftImage(2), '.r')
title('Rectified left image');
subplot(1,2,2)
imshow(rectifiedImageR,[]);
hold all
plot(1:size(rectifiedImageR,2), aPixelOnLeftImage(2).*ones(1, size(rectifiedImageR,2)),'b')
title('Rectified right image')



%% implement find the best match function
disp('click on a figure to continue');
waitforbuttonpress;
close all;
clc;
disp('Press ESC to exit ! ')
patchSize = 15;
ClickedPntObj1 = 0;
ClickedPntObj2 = 0;
ClickedPntObj3 = 0;
EpipolarLinePntsObj = 0;
DepthTextObj = 0;

Fig1 = figure;
imshow(rectifiedImageL);
title('Rectified image 1');
hold on;
Fig2 = figure;
imshow(rectifiedImageR);
title('Rectified image 2');
hold on;
Width = size(rectifiedImageL,2);
Height = size(rectifiedImageL,1);

while( 1 )
    figure( Fig1 );
    % Get a point from the user
    [ClickedX, ClickedY, PressedKey] = ginput(1);
    pause(0.001);
    if PressedKey == 1 
        ClickedY = round(ClickedY);
        ClickedX = round(ClickedX);
        if (ClickedX > patchSize) && ...
           (ClickedY > patchSize) && ...
           (ClickedX <= Width-patchSize) && ...
           (ClickedY <= Height-patchSize)
            x = ClickedX;
            y = ClickedY;
        end
    elseif PressedKey == 28
        if x > 1
            x = x - 1;
        else
            continue;
        end
    elseif PressedKey == 29
        if x < Width
            x = x + 1;
        else
            continue;
        end
    elseif PressedKey == 30
        if y > 1
            y = y - 1;
        else
            continue;
        end
    elseif PressedKey == 31
        if y < Height
            y = y + 1;
        else
            continue;
        end
    elseif (PressedKey == 113 || PressedKey == 27)
        break;
    else
        continue;
    end
    
    % Display the clicked point
    if( ClickedPntObj1 ~= 0 )
        delete(ClickedPntObj1);
    end
    ClickedPntObj1 = plot(x, y, 'rx', 'MarkerSize', 10);
    
    [u,v] = best_match(x,y,rectifiedImageL,rectifiedImageR,patchSize);
    
    if( DepthTextObj ~= 0)
        delete(DepthTextObj);
    end
    if( ClickedPntObj2 ~= 0 )
        delete(ClickedPntObj2);
    end
        
    if(v ~= -1)
        DepthTextObj = text( 20, 20, ['Disparity: ' num2str(abs(x-u))], 'Color', [1 0 0] );
    else
        DepthTextObj = text( 20, 20, 'Little confidence', 'Color', [1 0 0] );
    end
    
    figure( Fig2 );
    ClickedPntObj2 = plot(u, v, 'rx', 'MarkerSize', 10);
    
end


