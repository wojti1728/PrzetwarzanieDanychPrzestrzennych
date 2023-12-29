
%Mikroskop, 11.04 oraz 18.04, pierwsze zajecia 
%sala 24 (nie 24a)
%Morfologia będzie zdalna 

%Przekształcenia punktowe i geometryczne
%%
close all; clear; clc;

a = imread('cameraman.tif'); 
%imshow(a); gam = [0.1 0.25 0.5 1 2 4]
a = double(a)/255;
gam = [0.1 0.25 0.5 1 2 4];
%jak jest ponizej 1 gdy chcemy cos wyciagnac z cienia, z szarosci itp
% Dla γ < 1 zwiększony jest kontrast dla "ciemnej" części obrazu
% kosztem "jasnej" części. Dla γ > 1 efekt jest odwrotny: zyskujemy kontrast w części "jasnej% kosztem
%"ciemnej".

% korekcja gammy jest stosowana w profesjonalnej kalibracji fotografii

for k=1:6
    a1 = a .^ gam(k);
    subplot(2,3,k), imshow(a1);
end

%%
close all; clear; clc;
%Normalizacja (rozciągniecie histogramu)

%a = imread('pout.tif');
a = imread('cameraman.tif');
subplot(221), imshow(a);
subplot(222), imhist(a, 256);
b = imadjust(a); %polcenie do normalizacji
subplot(223), imshow(b); %zyskalismy dynamike, poprawlismy kontrast
subplot(224), imhist(b, 256);

%%
close all; clear; clc;
%operacja wyrownania histogramu


a = imread('pout.tif');
subplot(221), imshow(a);
subplot(222), imhist(a, 256);
b = histeq(a, 256); %polcenie do normalizacji
subplot(223), imshow(b); %zyskalismy dynamike, poprawlismy kontrast
subplot(224), imhist(b, 256);

%Piki oznaczaja ile posiadamy pikseli w danym kolorze

%%
close all; clear; clc;
%operacja wyrownania histogramu


a = imread('saturn.png');
a = rgb2gray(a);
subplot(221), imshow(a);
subplot(222), imhist(a, 256);
b = adapthisteq(a,'ClipLimit',0.5); %polcenie do normalizacji
subplot(223), imshow(b); %zyskalismy dynamike, poprawlismy kontrast
subplot(224), imhist(b);

%clahe, adaptacyjne wyrownanie histogramu

%Piki oznaczaja ile posiadamy pikseli w danym kolorze


%%
close all; clear; clc;
%bineralizacja (zamiana na true and false) jest obiekt, nie ma obiektu

a = imread('coins.png');

subplot(121), imshow(a);
bin = a>90; %tym wyciagamy to co chcemy
bin = medfilt2(bin, [3 3]); %tym filtrujemy jakies bledy itp
subplot(122), imshow(bin);

%%
close all; clear; clc;
%bineralizacja (zamiana na true and false) jest obiekt, nie ma obiektu

a = imread('peppers.png');

subplot(121), imshow(a);
%bin = a(:,:,1)>180 & a(:,:,2)>130 & a(:,:,3) < 120 ; %tym wyciagamy to co chcemy
bin = (a(:,:,1)>a(:,:,2)) & (a(:,:,2)>a(:,:,3));
bin = a(:,:,1)>200 & a(:,:,3)<100 & a(:,:,2)>145;
bin = medfilt2(bin, [5 5]); %tym filtrujemy jakies bledy itp
bin = imfill(bin, 'holes');
bin = bwareaopen(bin, 150);
bin = imclose(bin, ones(80))
subplot(122), imshow(bin);

%%
close all; clear; clc;
%Przekształcenie geometryczne
a = imread('cameraman.tif');
subplot(121), imshow(a);
b = circshift(a, [50, 100]);
%b = imrotate(a, 30, 'loose', 'bicubic'); % Rotacja
%b = flipud(a); %fliplr(a); odbicie lustrzane w pionie i poziomie
%b = padarray(a, [512 512], 'symmetric', 'both'); 
% Opcje poszerzanie: replicute, symmetric, circular, 
% Opcje pre, post, both.
subplot(122), imshow(b);

%subplot(122), imshow(bin);

%%
close all; clear; clc;
%Przekształcenie afiniczne i projekcja 
a = imread('cameraman.tif');
subplot(121), imshow(a);

% macierz nie moze być osobliwa, wyznacznik nie moze byc zero
%mac = affine2d([2 0 0; 0 4 0; 0 0 1]);
mac = projective2d([1 1 0; 0 2 0; 0.01 -0.01 1]);
b = imwarp(a, mac);

subplot(122), imshow(b);

%%
close all; %clear; clc;
% 
a = imread('cameraman.tif');
subplot(121), imshow(a);

mac = projective2d([1 1 0; 0 2 0; 0.01 -0.01 1]);
b = imrotate(a, 60);
%cpselect(a,b);
T=fitgeotrans(movingPoints, fixedPoints, 'affine')
T.T
subplot(122), imshow(b);

%subplot(122), imshow(bin);

% PRZYPOMNIEC SOBIE SPLOTY I FILTRACJE W DOMENIE CZASU! na za tydzień

