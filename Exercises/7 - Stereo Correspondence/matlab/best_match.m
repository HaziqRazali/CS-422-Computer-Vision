function [u2,v2] = best_match(x,y,im1,im2,psz)
    % INPUT:  (x,y) - coordinates of the point in the left image
    %         im1 - left image of the stereo pair of size HxW
    %         im2 - right image of the stereo pair of size HxW
    %         psz - half-of the size of the patch, extracted arounf the
    %               point for NCC estimation
    % OUTPUT: (u,v) - coordinates of the corresponding point in the right
    %                 image
    u2 = 0;
    v2 = 0;
  
    % x - col
    % y - row
    
    % get template
    t = im1(y-psz:y+psz,x-psz:x+psz);
    
    % initialize samples
    s = {}; 
    
    % start from psz+1 since matlab indexes start from 1
    % would be psz:size(im1,2)-psz-1 for python
    for j = psz+1:size(im1,2)-psz
        s{end+1} = im2(y-psz:y+psz,j-psz:j+psz);
    end
    
    % get ncc scores
    max_ncc_score = 0;
    max_pos = 0;
    for j = 1:size(s,2)
        score = ncc(t,s{j});
        if(score > max_ncc_score)
            max_ncc_score = score;
            max_pos = j+psz;
        end
    end
    
    % best match in im2
    u2 = max_pos;
    v2 = y;
    
    % best match in im1
    u1 = 0;
    v1 = 0;
    
    % get template and samples
    t = im1(v2-psz:v2+psz,u2-psz:u2+psz);
    s = {}; 
    for j = psz+1:size(im1,2)-psz
        s{end+1} = im2(v2-psz:v2+psz,j-psz:j+psz);
    end
    
    % get ncc scores
    max_ncc_score = 0;
    max_pos = 0;
    for j = 1:size(s,2)
        score = ncc(t,s{j});
        if(score > max_ncc_score)
            max_ncc_score = score;
            max_pos = j+psz;
        end
    end
    
    u1 = max_pos;
    v1 = y;
    
    if(abs(u1-u2) + abs(v1-v2) > 100)
        u2 = -1;
    end
    
    %% Answer the question below this point. Write your answer as a comment.
    
end