function [ h ] = Entropy( x, n )
% Calculating the Entropy Image 
    x = double(x);
    xh = hist( x(:), n);
    xh = xh / sum(xh(:));
    i = find(xh);
    h = - sum(xh(i).*log2(xh(i)));
end
