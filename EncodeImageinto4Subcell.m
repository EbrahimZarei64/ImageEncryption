function I=EncodeImageinto4Subcell(m,n,PlainImg)
   % Encode each cell of Plain Image into 4 subcells 
    I = zeros(4*n*m,1);
    PlainImg=PlainImg(:);
    Imgsize=n*m;
    
    for i=1:Imgsize
        num2decomposed = PlainImg(i);
        for z = 1:4
            rem = mod(num2decomposed,4);
            I(4*(i-1)+(5-z)) = rem;
            num2decomposed = fix(num2decomposed/4);
        end
        
    end
    
end