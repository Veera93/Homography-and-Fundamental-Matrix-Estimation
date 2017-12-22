function[img] = get_image(im, l)
    imd = im2double(im);
    imp = padarray(imd,[l l],'both');
    img = rgb2gray(imp);
end