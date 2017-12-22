function[F, num_inlier, point1, point2] = ransac(D1, D2, threshold, num, iternations)
    count = 0;
    D1(3,:) = 1;
    D2(3,:) = 1;
    n = size(D1, 2);
    best_n_inlier = 0;
    best_F = [];
    
    for i=1:iternations
        matches = [];
        s = randsample(n, num);
        matches = horzcat(matches, D1(1:2,s)');
        matches = horzcat(matches, D2(1:2,s)');

        F = fit_fundamental(matches, 1);
        
        for j=1:n
            res(j) = (D2(:,j)'*F*D1(:,j)).^2;
        end
        
        inliers = find(res < threshold);
        num_inlier = length(inliers) ;
        if (num_inlier > best_n_inlier)
            best_F = F;
            best_n_inlier = num_inlier;
            point1 = D1(1:2,inliers);
            point2 = D2(1:2,inliers);
        end
        count = count + 1;
    end
    F = best_F;
    num_inlier = best_n_inlier;
    
end