function r = getResidual(x,T,X)

    newx = (T*X);
    newx(1,:) = newx(1,:)./newx(3,:);
    newx(2,:) = newx(2,:)./newx(3,:);
    newx(3,:) = newx(3,:)./newx(3,:);
    r = sum(sqrt(sum((x - newx).^2)));

end