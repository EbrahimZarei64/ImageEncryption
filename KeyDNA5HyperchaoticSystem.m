function key=KeyDNA5HyperchaoticSystem(M,N,KeyDecimal,KeyFeature)

    c1=30; c2=10; c3=15.7; c4=5; c5=2.5; c6=4.45; c7=38.5;
    % use the first 32 bits of 128 bits to obtain a initial value
    d1 = KeyDecimal(1); 
    d2 = KeyDecimal(2); 
    d3 = KeyDecimal(3);
    d4 = KeyDecimal(4); 
    d5 = KeyDecimal(5);
    d6 = KeyDecimal(6);
    x(1)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),KeyFeature)/256;

    d1 = KeyDecimal(7); 
    d2 = KeyDecimal(8); 
    d3 = KeyDecimal(9);
    d4 = KeyDecimal(10); 
    d5 = KeyDecimal(11);
    d6 = KeyDecimal(12);
    y(1)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),KeyFeature)/256;
       
    d1 = KeyDecimal(13); 
    d2 = KeyDecimal(14); 
    d3 = KeyDecimal(15);
    d4 = KeyDecimal(16); 
    d5 = KeyDecimal(17);
    d6 = KeyDecimal(18);
    z(1)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),KeyFeature)/256;
    
    
    d1 = KeyDecimal(19); 
    d2 = KeyDecimal(20); 
    d3 = KeyDecimal(21);
    d4 = KeyDecimal(22); 
    d5 = KeyDecimal(23);
    d6 = KeyDecimal(24);
    u(1)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),KeyFeature)/256;
    
    d1 = KeyDecimal(25); 
    d2 = KeyDecimal(26); 
    d3 = KeyDecimal(27);
    d4 = KeyDecimal(28); 
    d5 = KeyDecimal(29);
    d6 = KeyDecimal(30);
    w(1)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(d1,d2),d3),d4),d5),d6),KeyFeature)/256;
    
    discard=KeyDecimal(31)+KeyDecimal(32)+KeyFeature;
    sizeSignal=4*ceil(M*N/5)+discard;
    
    for i=2:discard
        x(i)=-c1*x(i-1)+c1*y(i-1);       
        y(i)=c2*x(i-1)+c2*y(i-1)+w(i-1)-x(i-1)*z(i-1)*u(i-1);      
        z(i)=-c3*y(i-1)-c4*z(i-1)-c5*u(i-1)+x(i-1)*y(i-1)*u(i-1);       
        u(i)=-c6*u(i-1)+x(i-1)*y(i-1)*z(i-1);      
        w(i)=-c7*x(i-1)-c7*y(i-1);
        x(i)=(x(i)*10000)-floor(x(i)*10000);
        y(i)=(y(i)*10000)-floor(y(i)*10000);
        z(i)=(z(i)*10000)-floor(z(i)*10000);
        u(i)=(u(i)*10000)-floor(u(i)*10000);
        w(i)=(w(i)*10000)-floor(w(i)*10000);
    end
 
    key=zeros(4*M*N,1);
    j=1;
    for i=discard+1:sizeSignal
        x(i)=-c1*x(i-1)+c1*y(i-1);       
        y(i)=c2*x(i-1)+c2*y(i-1)+w(i-1)-x(i-1)*z(i-1)*u(i-1);      
        z(i)=-c3*y(i-1)-c4*z(i-1)-c5*u(i-1)+x(i-1)*y(i-1)*u(i-1);       
        u(i)=-c6*u(i-1)+x(i-1)*y(i-1)*z(i-1);      
        w(i)=-c7*x(i-1)-c7*y(i-1);
        x(i)=(x(i)*10000)-floor(x(i)*10000);
        y(i)=(y(i)*10000)-floor(y(i)*10000);
        z(i)=(z(i)*10000)-floor(z(i)*10000);
        u(i)=(u(i)*10000)-floor(u(i)*10000);
        w(i)=(w(i)*10000)-floor(w(i)*10000);

        key(j)=x(i);
        key(j+1)= y(i);
        key(j+2)=z(i);
        key(j+3)=u(i);
        key(j+4)= w(i);

        j=j+5;

    end
    
     key=key(1:4*M*N);
     key=mod(floor(4*key),4);
     
     %key=reshape(key,[M,4*N]);
end