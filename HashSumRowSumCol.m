function H=HashSumRowSumCol(PlainImg,KeyHex)
    SumRow=sum(PlainImg,2);
    SumCol=sum(PlainImg,1);
    SumDiag=sum(spdiags(rot90(PlainImg)));
    SumCol=SumCol';
    D=[HashFunction(SumRow,'MD5') HashFunction(SumCol,'MD5')     HashFunction(KeyHex,'MD5')];
    H=HashFunction(D,'SHA-256');
end