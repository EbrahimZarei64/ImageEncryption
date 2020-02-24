function PerImage = PermutationDNA(Image,KeyDecimal,KeyFeature,m,n,Type)
    d1 = KeyDecimal(17); 
    d2 = KeyDecimal(18); 
    d3 = KeyDecimal(19);
    d4 = KeyDecimal(20);
    d5 = KeyDecimal(21);
    d6 = KeyDecimal(22);
    d7 = KeyDecimal(23);
    d8 = KeyDecimal(24);
    xx=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),d7),d8),KeyFeature)/256;
  
    u = 3.89+xx*0.01;   
    Len=d1+d2+d3+KeyFeature;
    
    d1 = KeyDecimal(25); 
    d2 = KeyDecimal(26); 
    d3 = KeyDecimal(27);
    d4 = KeyDecimal(28);
    d5 = KeyDecimal(29);
    d6 = KeyDecimal(30);
    d7 = KeyDecimal(31);
    d8 = KeyDecimal(32);
    x=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),d7),d8),KeyFeature)/256;

    
    for i = 1:Len
        x = u * x * (1 - x);
    end
    
    Len4mn=4*n*m;
    ChaoticSignal(1)=x;
    for i=2:Len4mn
        ChaoticSignal(i) = u * ChaoticSignal(i-1) * (1 - ChaoticSignal(i-1));
    end
      
    %% permutated process
    [B,Pos]=sort(ChaoticSignal);
    Pos=Pos';
    PerImage=zeros(Len4mn,1,'uint8');
    switch Type
        case 'Encryption'          
            PerImage=Image(Pos);
        case 'Decryption'
            PerImage(Pos)=Image(:);         
    end

end