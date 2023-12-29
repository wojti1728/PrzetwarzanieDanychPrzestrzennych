%%
close all; clear; clc;

% FILTR. - 
% 1. liniowa: 
% a) dolnoprzepustowe: LP, Vm >= 0, SUMA = 1
% b) górnoprzepustowe: SUMA = 0

% 2. nieliniowa: medianowy, veniera
% a) odszumiająca 
% b) krawędziowa
% c) inne

% FItracja PRZESTRZENNA!
% to była ścieżka dolnoprzepustowa
a = imread('cameraman.tif');

N = 5;
% maska = ones(N)/(N*N);
maska  = fspecial('gaussian', [N N], N/5); %rozmycie gaussowskie
% bierzemy piksel i zamieniamy ze srednia z otoczenia
% Funkcja imfilter
b = imfilter(a, maska, 'symmetric'); 


% teraz górnoprzepustowa
% pierwsza maska wykrywa nam krawedzie poziome
% druga pionowe i ukośne
a = double(a)/255;
maska2 = [1 1 1; 
          0 0 0; 
          -1 -1 -1];
maska22 = [1 0 -1; 
          1 0 -1; 
          1 0 -1];
b2 = abs(imfilter(a, maska2, 'symmetric'));
b22 = abs(imfilter(a, maska22, 'symmetric'));
a2 = sqrt(b2 .* b2 + b22 .* b22);

subplot(121), imshow(a);
subplot(122), imshow(a2);

%%
close all; clear; clc;
% Magnitude krawedzi znaleźć
a = imread('onion.png');

N = 5;
% maska = ones(N)/(N*N);
maska  = fspecial('gaussian', [N N], N/5); %rozmycie gaussowskie
% bierzemy piksel i zamieniamy ze srednia z otoczenia
% Funkcja imfilter
b = imfilter(a, maska, 'symmetric');

a = double(a)/255;
maska2 = [1 2 1; 0 0 0; -1 -2 -1];
maska22 = [1 0 -1; 2 0 -2; 1 0 -1];
b2 = abs(imfilter(a, maska2, 'symmetric'));
b22 = abs(imfilter(a, maska22, 'symmetric'));
a2 = sqrt(b2 .* b2 + b22 .* b22); % wedlug Normy L2
c = sqrt(a2(:,:,1).^2+a2(:,:,2).^2+a2(:,:,3).^2); % tak robimy aby ramki były monochromatyczne

subplot(121), imshow(a);
subplot(122), imshow(c);

%% pan sobel zmienil jedynki na 2

maska_pozioma = [1 2 1; 0 0 0; -1 -2 -1];
maska_pionowa = [1 0 -1; 2 0 -2; 1 0 -1];

%% sami se cuś powymyślamy - stwórz obraz 128x128, czarne tło, i naśrodku biały kwadrat 64x64
% stwórz filtracje która wykrywa tylko narożniki tego kwadratu ( może być
% kilka filtrów)
close all; clear; clc;

a = imread("onion.png");
N = 128;
kwadrat = zeros(N);
kwadrat(32:95, 32:95) = 1;
mask = [1 0 -1];

% filtracja filtracji - najpierw robie krawedzie pionowe i potem na n
% ich
% wyszukuje poziome czyli po 1 pikselu ( pikslu? pikserze )
b = abs(imfilter(imfilter(kwadrat, mask), mask'));

b = b & a;
c = uint8(a + b);
leg = [0 0 0; 1 1 1; 1 0 0];
imshow(c, leg);

%% Laplace - laplasian- suma drugich pochodnych cząstkowych
%   [0  -1  0]
%   [-1     -1] - suma równa 0 lub 1 - to w środku 4 lub 5
%   [0  -1  0]

%   [-1  -1  -1]
%   [-1      -1] - suma 1/0 wiec 8 lub 9
%   [-1  -1  -1] - dla 0 mamy krawędzie bez podziału na strony, dla 1
%   przeostrzenie ( do obrazu dodajemy krawedzie )

% mask1 = [0 -1 0; -1 4 -1; 0 -1 0];
% mask2 = [0 -1 0; -1 5 -1; 0 -1 0];
mask1 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
mask2 = [-1 -1 -1; -1 9 -1; -1 -1 -1];
a = imread("cameraman.tif");

b = imfilter(a, mask1, "symmetric");
b2 = imfilter(a, mask2, "symmetric");
subplot(131), imshow(a);
subplot(132), imshow(b);
subplot(133), imshow(b2);

%% filtry nieliniowe - filtracja odszumiająca
close all; clear; clc;

a = imread("cameraman.tif");
% filtracjamedianowa
%b = medfilt2(a, [9 9], "symmetric"); % rozmiar maski z której mamy liczyć mediane

% filtracja wienera
b = wiener2(a, [5 5]);

% metody filtracji odszumiającej
% imfilter ones(N) / (N*N)
% imfilter fspecial
% medfilt2
% wiener2
subplot(121), imshow(a);
subplot(122), imshow(b);

%%
a = imread("cameraman.tif");
as = imnoise(a, "speckle"); % zaszumienie - gaussian, salt & pepper, poisson, speckle
N = 5;
% zadanie - odszumiaj zaszumiony obraz
b1 = medfilt2(as, [N N], "symmetric");
b2 = wiener2(as, [N N]);
mask1 = ones(N) / (N*N);
b3 = imfilter(as, mask1, "symmetric");
maska2 = fspecial("gaussian", [N N], N/5);
b4 = imfilter(as, maska2, "symmetric");
% zadanire na kolosa - odszum i .... !!!! KOLOS !!!!
% liczbę błędów ? liczymy tylko na double

subplot(2,3,[1, 2]), imshow(a), title("Oryginal");
subplot(233), imshow(b1), title("Mediana");
subplot(234), imshow(b2), title("Wiener");
subplot(235), imshow(b3), title("Ones");
subplot(236), imshow(b4), title("FSpecial");

%% filtracja krawędziowa - 

% filtr  canny - jedna z najmocniejszych filtracji krawędziowych
a = imread("cameraman.tif");

b = edge(a, "canny");

subplot(121), imshow(a);
subplot(122), imshow(b);

%% filtry inne

a = imread("cameraman.tif");

% filtr porządku
b = ordfilt2(a, 1, ones(7)) % 1 zwraca minimum z obszaru, 49 - max, 25-mediana

% filtr odchylenia standardowego
b = stdfilt(a,ones(9));
% subplot(122), imagesc(b), axis image, colorbar("vertical");

% filtr entropii
b = entropyfilt(a, ones(3)); % entropie liczymy w duzych maksach
subplot(122), imagesc(b);
subplot(121), imshow(a);
% subplot(122), imshow(b);

%% dekonwolucja - odzyskiwanie obrazu oryginalnego
close all; clear; clc;

a = imread("cameraman.tif");

maska = fspecial("motion", 11, -35); % 11pikseli pod katem -35st
b = imfilter(a, maska, "symmetric");
% teraz chcemy odzyskac nieporuszony obraz
% dekonwolucja ślepa
an = deconvblind(b, maska)

% dekonwolucja Lucy Richarlsona???
%an = deconvlucy(b, maska);

% dekonwolucja Wienera
an = deconvwnr(b, maska);

% dekonwolucja Reg???/ regresja liniowa
an = deconvreg(b, maska);

subplot(121), imshow(b);
subplot(122), imshow(an);