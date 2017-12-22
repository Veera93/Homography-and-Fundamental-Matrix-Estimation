function without_ground_truth(im1o, im2o)
    sigma = 3;
    thresh = 0.01;
    radius = 3;
    disp = 1;
    window_size = 25;
    l = floor(window_size/2);


    im1d = im2double(im1o);
    im2d = im2double(im2o);

    im1p = padarray(im1d,[l l],'both');
    im2p = padarray(im2d,[l l],'both');

    im1 = rgb2gray(im1p);
    im2 = rgb2gray(im2p);

    [~, r1, c1] = harris(im1, sigma, thresh, radius, disp);
    [~, r2, c2] = harris(im2, sigma, thresh, radius, disp);

    neighbourhood1 = cell(size(r1));
    neighbourhood2 = cell(size(r2));

    for i=1:size(neighbourhood1)
        a = r1(i);
        b = c1(i);
        neighbourhood1{i} = reshape(im1(a-l:a+l,b-l:b+l),[(l*2+1)^2 1]);
    end
    for i=1:size(neighbourhood2)
        a = r2(i);
        b = c2(i);
        neighbourhood2{i} = reshape(im2(a-l:a+l,b-l:b+l),[(l*2+1)^2 1]);
    end
    for i=1:size(neighbourhood1, 1)
        for j=1:size(neighbourhood2, 1)
            dist(i,j) = dist2(neighbourhood1{i}', neighbourhood2{j}');
        end
    end 


    [d1,d2] = find(dist<3);

    for i=1:size(d1, 1)
        D1(:,i) = [c1(d1(i));r1(d1(i))];
        D2(:,i) = [c2(d2(i));r2(d2(i))];
    end
    plot_matches(D1, D2, im1, im2)
    
    threshold = 0.00001;
    num = 8;
    iternations = 10000;
    
    [F, inlayers, point1, point2] = ransac(D1, D2, threshold,  num, iternations);
    plot_matches(point1, point2, im1p, im2p);
    matches = [point1; point2]';
    N = size(matches,1);
    ground_truth(matches, im1, im2, N, 1)
end
