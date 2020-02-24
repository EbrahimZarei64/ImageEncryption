function [DiffImg] = DiffusionDNA(Image,KeyImage,KeyDecimal,KeyFeature, m, n, Type)
   %% Logistic Map Signal
    d1 = KeyDecimal(1); 
    d2 = KeyDecimal(3); 
    d3 = KeyDecimal(5);
    d4 = KeyDecimal(7);
    d5 = KeyDecimal(9);
    d6 = KeyDecimal(11);
    d7 = KeyDecimal(13);
    d8 = KeyDecimal(15);
    xx=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),d7),d8),KeyFeature)/256;
  
    u = 3.89+xx*0.01;   
    Len=d1+d2+d3+KeyFeature;
    
    d1 = KeyDecimal(2); 
    d2 = KeyDecimal(4); 
    d3 = KeyDecimal(6);
    d4 = KeyDecimal(8);
    d5 = KeyDecimal(10);
    d6 = KeyDecimal(12);
    d7 = KeyDecimal(14);
    d8 = KeyDecimal(16);
    x=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),d7),d8),KeyFeature)/256;

    for i = 1:Len
        x = u * x * (1 - x);
    end
    
    Len4mn=4*n*m;
    x(1)=x;
    for i=2:Len4mn
        x(i) = u * x(i-1) * (1 - x(i-1));
    end
    ChaoticSignal=x;
    
    %%
    OPERATION = floor(7 * ChaoticSignal) + 1;
    
    DiffImg=zeros(Len4mn,1);
    
    XOR= [0 1 2 3; 1 0 3 2; 2 3 0 1; 3 2 1 0];
    ADD= [1 0 3 2; 0 1 2 3; 3 2 1 0; 2 3 0 1];
    MUL= [3 2 1 0; 2 3 0 1; 1 0 3 2; 0 1 2 3];
    XNOR=[3 2 1 0; 2 3 0 1; 1 0 3 2; 0 1 2 3];
    SUB= [1 2 3 0; 0 1 2 3; 3 0 1 2; 2 3 0 1];
    RShift=[0 1 2 3; 1 2 3 0;2 3 0 1; 3 0 1 2];
    LShift=[0 3 2 1; 1 0 3 2;2 1 0 3; 3 2 1 0];

    switch Type
        case 'Encryption'
            for i=1:Len4mn
                switch OPERATION(i)
                    case 1 
                         DiffImg(i)= ADD(Image(i)+1,KeyImage(i)+1);
                    case 2 
                         DiffImg(i)= SUB(Image(i)+1,KeyImage(i)+1);
                    case 3 
                         DiffImg(i)= XOR(Image(i)+1,KeyImage(i)+1);
                    case 4 
                         DiffImg(i)=XNOR(Image(i)+1,KeyImage(i)+1);
                    case 5 
                         DiffImg(i)=MUL(Image(i)+1,KeyImage(i)+1);
                    case 6 
                        DiffImg(i)=RShift(Image(i)+1,KeyImage(i)+1);
                    case 7
                        DiffImg(i)=LShift(Image(i)+1,KeyImage(i)+1);
                end
            end
        
        case 'Decryption'
            for i=1:Len4mn
                switch OPERATION(i)
                    case 1 
                         DiffImg(i)= ADD(Image(i)+1,KeyImage(i)+1);
                    case 2 
                         DiffImg(i)= SUB(Image(i)+1,KeyImage(i)+1);
                    case 3 
                         DiffImg(i)= XOR(Image(i)+1,KeyImage(i)+1);
                    case 4 
                         DiffImg(i)=XNOR(Image(i)+1,KeyImage(i)+1);
                    case 5 
                         DiffImg(i)=MUL(Image(i)+1,KeyImage(i)+1);
                    case 6 
                        DiffImg(i)=LShift(Image(i)+1,KeyImage(i)+1);
                    case 7
                        DiffImg(i)=RShift(Image(i)+1,KeyImage(i)+1);
                end
            end            
    end 
    
end