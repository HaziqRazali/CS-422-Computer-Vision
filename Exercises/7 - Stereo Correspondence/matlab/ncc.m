function score = ncc( template, sample )
    % INPUT:  template image of size h x w
    %         sample image of size h x w
    % OUTPUT: real number
    score = 0;
    
    mu_t = mean(single(template(:)));
    mu_s = mean(single(sample(:)));
    var_t = var(single(template(:)));
    var_s = mean(single(sample(:)));
    
    score = 0;
    for y = 1:size(template,1)
        for x = 1:size(template,2)            
            score = score + (single(template(y,x)) - mu_t)*(single(sample(y,x)) - mu_s)/(var_t*var_s);
        end
    end
    
    score = score/single((size(template,1)*size(template,1)));
    return

end

