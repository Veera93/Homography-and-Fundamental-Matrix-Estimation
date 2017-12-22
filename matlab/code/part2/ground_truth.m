function residue = ground_truth(matches, im1, im2, N, isNorm)
    F = fit_fundamental(matches, isNorm); % this is a function that you should write
    visualization(F, matches,N, im1, im2);
    residue = 0;
    for i=1:N
        residue = residue + ([matches(i,3:4) ones(1,1)]*F*[matches(i,1:2) ones(1,1)]').^2;
    end
end