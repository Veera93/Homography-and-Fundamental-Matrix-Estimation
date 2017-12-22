# Homography and Fundamental Matrix Estimation

#### INTRODUCTION:

The aim of this assignment is to implement robust Homography and Fundamental matrix estimation to register pairs of images separated either by a 2D or 3D projective transformation using matlab.

#### IMPLEMENTATION:

##### Homography Matrix Estimation and Image Stitching:

1.	Load the given images and convert them into double and then greyscale.
2.	Extract feature points from the images, in panorama camera scale is not varied much and hence can use Harris Corner detection for extracting the features. The optimal parameters found for Harris are sigma = 3; threshold = 0.1; radius = 3;
3.	After extracting the features, extract local neighborhoods (window size of 25 gave better results) around every keypoint in both images, and form descriptors simply by “flattening” the pixel values in each neighborhood to one-dimensional vectors. A single pixel value can have multiple matches and hence we are taking the neighborhood around the pixel and finding the distance.
4.	Compute distances between every descriptor in one image and every descriptor in the other image using Euclidian distance. This gives us how similar each descriptors are.
5.	Select putative matches based on the matrix of pairwise descriptor distances obtained above and select the points whose distances are below a specified threshold. The threshold of 15 gave better matches for the given images.
6.	Using RANSAC select four random points from the putative matches and estimate a homography mapping one image onto the other. 
  -	Select four random points.
  -	Calculate A matrix using the formula in the below mentioned figure
  -	Decompose the matrix using SVD and the last singular vector will be the homography matrix.
  -	Using this homography matrix compute transformed points and compare them with the matches to calculated the residue and report the points with residue less than a threshold as inliers. Optimal threshold could be 1.
  -	Find the inliers count and compare with the maximum inliers and save the best inliers. Repeat this process for N iterations.
<img hspace="33%" width="378" alt="screen shot 2017-12-22 at 1 48 42 am" src="https://user-images.githubusercontent.com/31252852/34288566-fb302564-e6bb-11e7-8c1d-ec2e8067560d.png">
  

7.	Using the homography matrix calculated warp one image onto the other using the estimated transformation using maketform and imtransform functions.
8.	Create a new image big enough to hold the panorama and composite the two images into it. In this implementation, I have considered the maximum pixel value in case of overlapping values.


##### Fundamental Matrix Estimation and Triangulation:

With Matching Points:
1.	Load the given images and matching point files.
2.	Fit a fundamental matrix using the matching points by decomposing the matrix form using svd. In this implementation, fundamental matrix had been calculated using both normalized and unnormalized matching points, in which normalization matrix is given by the formula 

<img hspace="33%" width="350" alt="screen shot 2017-12-22 at 1 48 31 am" src="https://user-images.githubusercontent.com/31252852/34288295-5c48c326-e6ba-11e7-9cc7-2030ef216e07.png">

Without Matching Points:
1.	Load the images.
2.	Now using the putative match generation and RANSAC code from Part 1 to find the matching points and then estimate fundamental matrices. Since 8 points are needed for matrix estimation we take random 8 points and calculate fundamental matrix. For Harris corner detection the threshold was 0.01.
3.	Using the residue calculate the inliers and return the fundamental matrix with highest inliers. In this implementation, Fundamental matrix is recalculated using the inlier matching points. The residue threshold of 0.0001 gave accurate inliers.
4.	The fundamental matrix calculated using the previous method gave an uniform result than this method due to the presence of outliers.

3D Reconstruction:
1.	Load the camera matrices for the two images and the matching points file.
2.	Find the centers of the two cameras using SVD. Triangular the points to get the points in  3D space. Decompose the following A to get the points in 3D.
<img hspace="33%" width="336" alt="screen shot 2017-12-22 at 1 48 52 am" src="https://user-images.githubusercontent.com/31252852/34288543-d089c9fa-e6bb-11e7-9dd5-7e44110bdb00.png">
3.	Display the two camera centers and reconstructed points in 3D using scatter3 plot.
