function[F] = fit_fundamental(matches, normalized)
    p1 = matches(:,1:2)'; %point in the first image
    p2 = matches(:,3:4)'; %corresponding point in the second image
    p1(3, :) = 1;
    p2(3, :) = 1;
    if(normalized == 1)
        [p1, T1] = normalize(p1);
        [p2, T2] = normalize(p2);
        
    end
    x = p1(1,:);
    y = p1(2,:);
    xp= p2(1,:);
    yp= p2(2,:);
    A = [];
    % x1*xp1 x1*yp1 x1 y1*xp1 y1*yp1 y1 xp1 yp1 1
    for i=1:size(x, 2)
        temp = [x(i)*xp(i),x(i)*yp(i),x(i),y(i)*xp(i),y(i)*yp(i),y(i),xp(i),yp(i),1];
        A = vertcat(A, temp);
    end
        
    [U,S,V] = svd(A);
    F = reshape(V(:,9),3,3);
    
    [U,S,V] = svd(F,0);
    dia = diag(S);
    low_pos = find(dia == min(dia));
    dia(low_pos) = 0;
    F = U*diag(dia)*V'; 
    if(normalized == 1 )
        F = T2'*F*T1;
    end
end