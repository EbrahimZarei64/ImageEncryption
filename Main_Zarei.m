clear
clc
close all
format compact
%% Input Data
KeyHex = '6b679b3c77826d30a79e612114a8c18df984c176f4e529f684748ad052241b17'; %% s a 128 digital hex key
PlainImg=imread('Lena512.bmp');
[M,N]=size(PlainImg);
PlainImg=double(PlainImg);

%Crop=16 for 1/16 
%Crop=2  for 1/2
%Crop=4  for 1/4 
Crop=16; %Crop can be 16, 4 or 2
NoiseLevel=0.005; %NoiseLevel can be 0.005, 0.05 or 0.1

%% Encryption and Decryption
fprintf('\nTest Execution Time, Entropy and Correlation Coefficient ...')
%********** Encryption **********
tic
    HashPlainImage = HashSumRowSumCol(PlainImg,KeyHex);
    KeyDecimal = HashtoDecimal(KeyHex,HashPlainImage);
    KeyFeature = ExtractKeyFeature(KeyDecimal);
    KeyImage = KeyDNA5HyperchaoticSystem(M,N,KeyDecimal,KeyFeature);
    EncImg=Encryption(PlainImg,KeyImage,KeyDecimal,KeyFeature,M,N);
tEnc=toc;
fprintf('\nEncryption Time = %f',tEnc);

%********** Decryption **********
tic
    KeyDecimal = HashtoDecimal(KeyHex,HashPlainImage);
    KeyFeature = ExtractKeyFeature(KeyDecimal);
    KeyImage = KeyDNA5HyperchaoticSystem(M,N,KeyDecimal,KeyFeature);
    DecImg=Decryption(EncImg,KeyImage,KeyDecimal,KeyFeature,M,N);
tDec=toc;
fprintf('\nDecryption Time = %f',tDec);   

figure('Name','Plain, Cipher and Decrypted Image')
subplot(2,3,1),imshow(uint8(PlainImg)),  title('Plain Image');
subplot(2,3,2),imshow(uint8(EncImg)),    title('Cipher Image');
subplot(2,3,3),imshow(uint8(DecImg)),    title('Decrypted Image');
subplot(2,3,4),imhist(uint8(PlainImg)),  title('Histogram of Plain Image');
subplot(2,3,5),imhist(uint8(EncImg)),    title('Histogram of Cipher Image');
subplot(2,3,6),imhist(uint8(DecImg)),    title('Histogram of Decrypted Image');

%********** Test Parameter **********
DifPlainDec=sum(uint8(PlainImg(:))-uint8(DecImg(:)));
fprintf('\nPlainImage - DecryptedImage = %d',DifPlainDec);
PlainImg_Entropy = Entropy(PlainImg,N);
fprintf('\nPlainImage Entropy = %f',PlainImg_Entropy);
EncImg_Entropy = Entropy(EncImg,N);
fprintf('\nCipherImage Entropy = %f',EncImg_Entropy);
fprintf('\nCorrelation Coefficient:\n');
CC=AdjancyCorrPixelRand(PlainImg,EncImg);
disp(CC);

%% ****************************************************************************
% Test NPCR and UACI for 1 bit change in Plain Image
fprintf('\nTest NPCR and UACI for 1 bit change in Plain Image...')
PlainImg1bit=PlainImg;  
PlainImg1bit=double(PlainImg1bit);
pos1=1+floor(rand(1)*M);
pos2=1+floor(rand(1)*M);
pos3=1+floor(rand(1)*M);
pos4=1+floor(rand(1)*M);

fprintf('\nBefore change 1 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,PlainImg1bit(pos1,pos2));
PlainImg1bit(pos1,pos2) =mod(PlainImg1bit(pos1,pos2)+1,255);
fprintf('\nAfter change 1 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,PlainImg1bit(pos1,pos2));

HashPlainImage1bit = HashSumRowSumCol(PlainImg1bit,KeyHex);
KeyDecimal1bit = HashtoDecimal(KeyHex,HashPlainImage1bit);
KeyFeature1bit = ExtractKeyFeature(KeyDecimal1bit);
KeyImage1bit = KeyDNA5HyperchaoticSystem(M,N,KeyDecimal1bit,KeyFeature1bit);
EncImg1bit=Encryption(PlainImg1bit,KeyImage1bit,KeyDecimal1bit,KeyFeature1bit,M,N);
DecImg1bit=Decryption(EncImg1bit,KeyImage1bit,KeyDecimal1bit,KeyFeature1bit,M,N);

[npcr1, uaci1]= NPCR_UACI(uint8(EncImg),uint8(EncImg1bit));
fprintf('\nNPCR = %f   UACI=%f \n',npcr1, uaci1);

% show
figure('Name','NPCR and UACI for 1 bit change in Plain Image ')
subplot(2,3,1),imshow(uint8(PlainImg1bit)),  title('Plain Image 1 bit');
subplot(2,3,2),imshow(uint8(EncImg1bit)),    title('Chiper Image 1 bit');
subplot(2,3,3),imshow(uint8(DecImg1bit)),    title('Decryped Image 1 bit');
subplot(2,3,4),imhist(uint8(PlainImg1bit)),  title('Histogram of Plain Image 1 bit');
subplot(2,3,5),imhist(uint8(EncImg1bit)),    title('Histogram of Chiper Image 1 bit');
subplot(2,3,6),imhist(uint8(DecImg1bit)),    title('Histogram of Decryped Image 1 bit');
%%
% Test NPCR and UACI for 2 bit change in Plain Image
fprintf('\nTest NPCR and UACI for 2 bit change in Plain Image...')
PlainImg2bit=PlainImg;      
PlainImg2bit=double(PlainImg2bit);

fprintf('\nBefore change 2 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,PlainImg2bit(pos1,pos2));
fprintf('\nAfter change 2 bit of PlainImage at location (%d,%d) = %d',pos3,pos4,PlainImg2bit(pos3,pos4));
PlainImg2bit(pos1,pos2) =mod(PlainImg2bit(pos1,pos2)+1,255);
PlainImg2bit(pos3,pos4) = mod(PlainImg1bit(pos3,pos4)-1,255);
fprintf('\nAfter change 2 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,PlainImg2bit(pos1,pos2));
fprintf('\nAfter change 2 bit of PlainImage at location (%d,%d) = %d',pos3,pos4,PlainImg2bit(pos3,pos4));


HashPlainImage2bit = HashSumRowSumCol(PlainImg2bit,KeyHex);
KeyDecimal2bit = HashtoDecimal(KeyHex,HashPlainImage2bit);
KeyFeature2bit = ExtractKeyFeature(KeyDecimal2bit);
KeyImage2bit = KeyDNA5HyperchaoticSystem(M,N,KeyDecimal2bit,KeyFeature2bit);
EncImg2bit=Encryption(PlainImg2bit,KeyImage2bit,KeyDecimal2bit,KeyFeature2bit,M,N);
DecImg2bit=Decryption(EncImg2bit,KeyImage2bit,KeyDecimal2bit,KeyFeature2bit,M,N);

[npcr2, uaci2]= NPCR_UACI(uint8(EncImg),uint8(EncImg2bit));
fprintf('\nNPCR = %f   UACI=%f \n',npcr2, uaci2);
% show
figure('Name','NPCR and UACI for 2 bit change in Plain Image ')
subplot(2,3,1),imshow(uint8(PlainImg2bit)),  title('Plain Image 2 bit');
subplot(2,3,2),imshow(uint8(EncImg2bit)),    title('Chiper Image 2 bit');
subplot(2,3,3),imshow(uint8(DecImg2bit)),    title('Decryped Image 2 bit');
subplot(2,3,4),imhist(uint8(PlainImg2bit)),  title('Histogram of Plain Image 2 bit');
subplot(2,3,5),imhist(uint8(EncImg2bit)),    title('Histogram of Chiper Image 2 bit');
subplot(2,3,6),imhist(uint8(DecImg2bit)),    title('Histogram of Decryped Image 2 bit');


%% Cropping attack
fprintf('\nCropping attack...')

EncImgCrop=EncImg;
if Crop==2 
    EncImgCrop(1:512, 1:256)=0;
elseif Crop==4
    EncImgCrop(1:256, 1:256)=0;
elseif Crop==16
        EncImgCrop(1:128, 1:128)=0;
end
DecImgCrop=Decryption(EncImgCrop,KeyImage,KeyDecimal,KeyFeature,M,N);

PSNRCrop=psnr(uint8(DecImgCrop),uint8(PlainImg));
fprintf('\nCrop=1/%d, PSNR of cropped cipher image = %f \n',Crop,PSNRCrop);

figure('Name','Cropping attack and Noise attack ') 
subplot(2,2,1), imshow(uint8(EncImgCrop)),  title('Cropted Chiper Image ');
subplot(2,2,2), imshow(uint8(DecImgCrop)),  title('Decryped Cropted Image ');

%% Salt and pepper noise attack
fprintf('\nSalt and pepper noise attack...')
EncImgNoise=double(imnoise(uint8(EncImg),'salt & pepper',NoiseLevel));
DecImgNoise=Decryption(EncImgNoise,KeyImage,KeyDecimal,KeyFeature,M,N);

PSNRnosie=psnr(uint8(DecImgNoise),uint8(PlainImg));
fprintf('\nNoise Level = %f, PSNR of nosiy cipher image = %f \n',NoiseLevel,PSNRnosie);

subplot(2,2,3), imshow(uint8(EncImgNoise)),  title('Noisy Chiper Image ');
subplot(2,2,4), imshow(uint8(DecImgNoise)),  title('Decryped noisy Image ');
