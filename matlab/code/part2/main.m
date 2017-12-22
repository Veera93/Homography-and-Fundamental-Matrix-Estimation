
%%
%% load images and match files for the first example
%%

% 
im1 = imread('../../data/part2/house1.jpg');
im2 = imread('../../data/part2/house2.jpg');
matches = load('../../data/part2/house_matches.txt'); 


% im1 = imread('../../data/part2/library1.jpg');
% im2 = imread('../../data/part2/library2.jpg');
% matches = load('../../data/part2/library_matches.txt'); 

% this is a N x 4 file where the first two numbers of each row
% are coordinates of corners in the first image and the last two
% are coordinates of corresponding corners in the second image: 
% matches(i,1:2) is a point in the first image
% matches(i,3:4) is a corresponding point in the second image

N = size(matches,1);


%%
%% display two images side-by-side with matches
%% this code is to help you visualize the matches, you don't need
%% to use it to produce the results for the assignment
%%
%{
figure();
imshow([im1 im2]); hold on;
plot(matches(:,1), matches(:,2), '+r');
plot(matches(:,3)+size(im1,2), matches(:,4), '+r');
line([matches(:,1) matches(:,3) + size(im1,2)]', matches(:,[2 4])', 'Color', 'r');
%}
%%
%% display second image with epipolar lines reprojected 
%% from the first image
%%

% first, fit fundamental matrix to the matches
if(0)
    ground_truth(matches, im1, im2, N, 0)
    ground_truth(matches, im1, im2, N, 1)
end

if(1)
    without_ground_truth(im1, im2)
end
if(0)
    
    P1 = load('../../data/part2/house1_camera.txt');
    P2 = load('../../data/part2/house2_camera.txt');

%     P1 = load('../../data/part2/library1_camera.txt');
%     P2 = load('../../data/part2/library2_camera.txt');

    camera(matches, P1, P2);
    
end




