function Key=HashtoDecimal(KeyHex,HashVal)
    %%Convert HexBin to Hex Decimal  
    n=size(KeyHex,2)/2;
    HexBin=Hex2Bin(KeyHex,4);
    HexBin=HexBin(:)';
    HexDecimal=zeros(1,n);
    for i=1:1:n
        HexDecimal(i)=bin2dec(HexBin((i-1)*8+1:i*8));
    end
    
    %%Convert HashVal to Decimal
    HashBin=Hex2Bin(HashVal,4);
    HashBin=HashBin(:)';
    HashDecimal=zeros(1,n);
    for i=1:1:n
        HashDecimal(i)=bin2dec(HashBin((i-1)*8+1:i*8));
    end
    
    Key=bitxor(HexDecimal,HashDecimal);
    
end