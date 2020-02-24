function EncImage=Encryption(PlainImg,KeyImage,KeyDecimal,KeyFeature,M,N) 

    Encoded_DifImg=EncodeImageinto4Subcell(M,N,PlainImg);
   
    EncodedDNA_DifImg=EncodedImageIntoDNASeqence(M, N, Encoded_DifImg, KeyDecimal, KeyFeature);
 
    EncodedDNA_PerImage = PermutationDNA(EncodedDNA_DifImg,KeyDecimal,KeyFeature,M,N,'Encryption');
    
    DifImgDNA=DiffusionDNA(EncodedDNA_PerImage,KeyImage,KeyDecimal,KeyFeature,M,N,'Encryption');
    
    EncImage=DecodingDNAImage(M,N,DifImgDNA,KeyDecimal,KeyFeature);

end
