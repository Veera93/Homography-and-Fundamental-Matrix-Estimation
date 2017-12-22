%Parameters
sigma = 3;
thresh = 0.1;
radius = 3;
disp = 0;
window_size = 25;
l = floor(window_size/2);

%Load Images
% im1o = imread('../../data/part1/uttower/left.jpg');
% im2o = imread('../../data/part1/uttower/right.jpg');

% im1o = imread('../../data/part1/hill/1.jpg');
% im2o = imread('../../data/part1/hill/2.jpg');

% im1o = imread('../../data/part1/ledge/1.jpg');
% im2o = imread('../../data/part1/ledge/2.jpg');

im1o = imread('../../data/part1/pier/1.jpg');
im2o = imread('../../data/part1/pier/2.jpg');

im1d = im2double(im1o);
im2d = im2double(im2o);

im1p = padarray(im1d,[l l],'both');
im2p = padarray(im2d,[l l],'both');

im1 = rgb2gray(im1p);
im2 = rgb2gray(im2p);

%Corner Detection
[~, r1, c1] = harris(im1, sigma, thresh, radius, disp);
[~, r2, c2] = harris(im2, sigma, thresh, radius, disp);

neighbourhood1 = cell(size(r1));
neighbourhood2 = cell(size(r2));

for i=1:size(neighbourhood1)
    neighbourhood1{i} = reshape(im1(r1(i)-l:r1(i)+l,c1(i)-l:c1(i)+l),[(l*2+1)^2 1]);
end

for i=1:size(neighbourhood2)
    neighbourhood2{i} = reshape(im2(r2(i)-l:r2(i)+l,c2(i)-l:c2(i)+l),[(l*2+1)^2 1]);
end

for i=1:size(neighbourhood1, 1)
    for j=1:size(neighbourhood2, 1)
        dist(i,j) = dist2(neighbourhood1{i}', neighbourhood2{j}');
    end
end 


[d1,d2] = find(dist<15);

for i=1:size(d1, 1)
    D1(:,i) = [c1(d1(i));r1(d1(i))];
    D2(:,i) = [c2(d2(i));r2(d2(i))];
end

%Plot the Putative matches
plot_matches(D1, D2, im1p, im2p)
threshold = 1;
num = 4;
iternations = 1000;
[H, inliers, point1, point2, residue] = ransac(D1, D2, threshold,  num, iternations);

%Plot Inliers
plot_matches(point1, point2, im1p, im2p);
sum(residue)
im1 = im1d;
im2 = im2d;

T = maketform('projective',H');
[im2t,x,y]=imtransform(im2,T,'XYScale',1);
x_out=[min(1,x(1)) max(size(im1,2),x(2))];
y_out=[min(1,y(1)) max(size(im1,1),y(2))];
im1t=imtransform(im1,T,'XData',x_out,'YData',y_out,'XYScale',1);
im2t=imtransform(im2,maketform('affine',eye(3)),'XData',x_out,'YData',y_out,'XYScale',1);

for i=1:size(im1t,1)
    for j=1:size(im1t,2)
        v1 = [im1t(i,j,1) im1t(i,j,2) im1t(i,j,3)];
        v2 = [im2t(i,j,1) im2t(i,j,2) im2t(i,j,3)];
        if (isequal(v1, [0 0 0]) == 0 && isequal(v2, [0 0 0]) == 1)
            im(i,j,:) = im1t(i,j,:);
        else if(isequal(v1,[0 0 0]) == 1 && isequal(v2,[0 0 0]) == 0)
            im(i,j,:) = im2t(i,j,:);
        else
            im(i,j,:) = max(im1t(i,j,:),im2t(i,j,:));
            end
        end
    end
end
figure();
imshow(im);