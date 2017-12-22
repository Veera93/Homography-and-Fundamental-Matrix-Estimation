function camera(matches, P1, P2)
    N = size(matches,1);
    p1 = matches(:,1:2)'; %point in the first image
    p2 = matches(:,3:4)'; %corresponding point in the second image
    p1(3, :) = 1;
    p2(3, :) = 1;
    
    x = p1(1,:);
    y = p1(2,:);
    xp= p2(1,:);
    yp= p2(2,:);

    [U,D,V] = svd(P1,0);
    c1 = V(:,end);
    c1 = c1./c1(4);
    [U,D,V] = svd(P2,0);
    c2 = V(:,end);
    c2 = c2./c2(4);

    X = zeros(4,N);
    for i=1:N
        A = [x(i)*P1(3,:) - P1(1,:);
             y(i)*P1(3,:) - P1(2,:);
             xp(i)*P2(3,:) - P2(1,:);
             yp(i)*P2(3,:) - P2(2,:)];
        
        [U,D,V] = svd(A,0);
        X(:,i) = V(:,end);
        X(:,i) = X(:,i)./X(4,i);
    end

    Total_Residual = getResidual(p1,P1,X) + getResidual(p2,P2,X)
    figure, scatter3(X(1,:),X(2,:),X(3,:),8,'b','fill');
    hold on
    scatter3(c1(1),c1(2),c1(3),'r','fill');
    scatter3(c2(1),c2(2),c2(3),'g','fill');
    legend('Reconstructed Points','Camera 1','Camera 2')
    axis equal
end