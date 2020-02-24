function EncodeDNA=EncodedImageIntoDNASeqence(m,n,I,KeyDecimal,KeyFeature)
%     DNArules = [1,1,0,0,3,3,2,2;
%                 0,3,1,2,1,2,0,3;
%                 3,0,2,1,2,1,3,0;
%                 2,2,3,3,0,0,1,1];

    %%
    d1 = KeyDecimal(1); 
    d2 = KeyDecimal(2); 
    d3 = KeyDecimal(3);
    d4 = KeyDecimal(4);
    d5 = KeyDecimal(5);
    d6 = KeyDecimal(6);
    d7 = KeyDecimal(7);
    d8 = KeyDecimal(8);
    xx=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),d7),d8),KeyFeature)/256;
  
    u = 3.89+xx*0.01;   
    
    d1 = KeyDecimal(9); 
    d2 = KeyDecimal(10); 
    d3 = KeyDecimal(11);
    d4 = KeyDecimal(12);
    d5 = KeyDecimal(13);
    d6 = KeyDecimal(14);
    d7 = KeyDecimal(15);
    d8 = KeyDecimal(16);
    x=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),d7),d8),KeyFeature)/256;
  
    
    
    Len=d1+d2+d3+KeyFeature;
    for i = 1:Len
        x = u * x * (1 - x);
    end
    
    Len4mn=4*n*m;
    x(1)=x;
    for i=2:Len4mn
        x(i) = u * x(i-1) * (1 - x(i-1));
    end
    LogisticSeq=x;

    %%
    R=floor(8 * LogisticSeq) + 1;  
      
    EncodeDNA=zeros(Len4mn,1);
    for i = 1:Len4mn
        switch R(i)
            case 1            
                switch I(i)
                    case 0
                        EncodeDNA(i) = 1;
                    case 1
                        EncodeDNA(i) = 0;
                    case 2
                        EncodeDNA(i) = 3;
                    case 3
                        EncodeDNA(i) = 2;
                end

            case 2
                switch I(i)
                    case 0
                        EncodeDNA(i) = 1;
                    case 1
                        EncodeDNA(i) = 3;
                    case 2
                        EncodeDNA(i) = 0;
                    case 3
                        EncodeDNA(i) = 2;
                end

            case 3

                switch I(i)
                    case 0
                        EncodeDNA(i) = 0;
                    case 1
                        EncodeDNA(i) = 1;
                    case 2
                        EncodeDNA(i) = 2;
                    case 3
                        EncodeDNA(i) = 3;
                end

            case 4
                switch I(i)
                    case 0
                        EncodeDNA(i) = 0;
                    case 1
                        EncodeDNA(i) = 2;
                    case 2
                        EncodeDNA(i) = 1;
                    case 3
                        EncodeDNA(i) = 3;
                end

            case 5
                switch I(i)
                    case 0
                        EncodeDNA(i) = 3;
                    case 1
                        EncodeDNA(i) = 1;
                    case 2
                        EncodeDNA(i) = 2;
                    case 3
                        EncodeDNA(i) = 0;
                end

            case 6
                switch I(i)
                    case 0
                        EncodeDNA(i) = 3;
                    case 1
                        EncodeDNA(i) = 2;
                    case 2
                        EncodeDNA(i) = 1;
                    case 3
                        EncodeDNA(i) = 0;
                end

            case 7
                switch I(i)
                    case 0
                        EncodeDNA(i) = 2;
                    case 1
                        EncodeDNA(i) = 0;
                    case 2
                        EncodeDNA(i) = 3;
                    case 3
                        EncodeDNA(i) = 1;
                end

          case 8
                switch I(i)
                    case 0
                        EncodeDNA(i) = 2;
                    case 1
                        EncodeDNA(i) = 3;
                    case 2
                        EncodeDNA(i) = 0;
                    case 3
                        EncodeDNA(i) = 1;
                end
         end
    end
   
end