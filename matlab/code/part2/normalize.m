function[new_points, T] = normalize(points)
    m = mean(points');
    maxi = max(points');
    
    T = [ 
        inv(maxi(1))    0            -m(1)*inv(maxi(1));
        0               inv(maxi(2)) -m(2)*inv(maxi(2));
        0               0            1;
        ];
    new_points = T*points;
end