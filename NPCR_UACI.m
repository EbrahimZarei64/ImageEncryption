function [npcr, uaci] = NPCR_UACI(ChiperImg,ChiperImg1bit)
    f1 = double(ChiperImg);
    f2 = double(ChiperImg1bit);
    [M, N] = size(f1);
    %% NPCR
    
    d = 0.000000;
    for i = 1 : M
        for j = 1 : N
            if f1(i, j) ~= f2(i, j)         
               d = d + 1;
            end
        end
    end
    npcr = d / (M * N);

    %% UACI
    c = 0.000000;
    for i = 1 : M * N
         c = c + abs( double( f1(i)) - double( f2(i)));
    end
    uaci = c / (255 * M * N);
