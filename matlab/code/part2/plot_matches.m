function plot_matches(D1, D2, im1, im2)
    figure();
    imshow([im1 im2]); hold on;
    matches(:,1:2) = D1';
    matches(:,3:4) = D2';
    plot(matches(:,1), matches(:,2), '+r');
    plot(matches(:,3)+size(im1,2), matches(:,4), '+r');
    line([matches(:,1) matches(:,3) + size(im1,2)]', matches(:,[2 4])', 'Color', 'y');
end
