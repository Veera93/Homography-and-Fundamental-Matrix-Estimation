function[local_region] = find_neighbourhood(img, window_size, x, y)
    rI = x+window_size;
    cI = y+window_size;

    img = padarray(img,[window_size window_size],'both');
    rILo               = rI - window_size; % lower row index of window
    rIHi               = rI + window_size; % upper row index of window
    cILo               = cI - window_size; % lower column index of window
    cIHi               = cI + window_size; % upper column index of window
    local_region = img((rILo : rIHi) , (cILo : cIHi));
end