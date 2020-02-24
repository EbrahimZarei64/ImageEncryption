function DecImage=Decryption(EnImg,KeyImage,KeyDecimal,KeyFeature,M,N)
    
    Encoded_EnImg=EncodeImageinto4Subcell(M,N,EnImg);
   
    EncodedDNA_EnImg=EncodedImageIntoDNASeqence(M,N,Encoded_EnImg,KeyDecimal,KeyFeature);
   
    DifImgDNA=DiffusionDNA(EncodedDNA_EnImg,KeyImage,KeyDecimal,KeyFeature,M,N,'Decryption');
    
    PerImageDNA = PermutationDNA(DifImgDNA,KeyDecimal,KeyFeature,M,N,'Decryption');

    DecImage=DecodingDNAImage(M,N, PerImageDNA,KeyDecimal,KeyFeature);
    
end