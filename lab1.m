close all; clear; clc

%Przetwarzanie obrazów cyfrowych:
% zaliczenie:
% dwa projekty, jeden z tych zajęć z mikroskopami, a ten pierwszy w jakim
% tylko chcemy języku
% dwa kolokwia, teoria (definicje, wzory), drugie prkatyczne (matlab, dwa
% zadania, przetwarzania, analiza)

% Ze strony warto sobie obczaic jakie, wchodzimy w ADD-ons, get add-ons,
% image-processing


%Obraz monochromatyczny
a = imread('cameraman.tif');
%imshow(a);

subplot(121), imshow(a);
% b= a -50;
% b = b +100;
% b = b-50;
b = double(a)/255; % waÅ¼ne! (z intów na double)
a = uint8(255*b); % waÅ¼ne ! (z doubli na inty)
subplot(122), imshow(b); % wszystkie liczby matlab dopasowuje do 0-255 
% i  dlatego mamy taki rezultat (przez integery 0-255) bo inaczej najlepiej robic przez double (0-1) 

%%
close all;clear;clc;

a = imread('peppers.png');
imshow(a); % w wokrspace widzimy zmienna 3-wymiarowÄ…

% Pierwsza metoda na zapis obrazu kolorowego
for k=1:3
    subplot(2,2,k), imshow(a(:,:,k));
end

% Druga metoda to zapis indeksowany:
% Dekomponujemy nasz obraz na mape i legende
% bierzemy pierwszy piksel naszego obrazka itp...

[map, leg] = rgb2ind(a, 300);
b = ind2rgb(map, leg);
subplot(121), imshow(a);
subplot(122), imshow(b);

imtool(a);

% inspect pixels values (druga ikonka od lewej)
% linijka

%%
close all;clear;clc;

a = imread('cameraman.tif');
%imtool(a) % w wokrspace widzimy zmienna 3-wymiarowÄ…
%b = imfinfo(a);
%b = regionprops(a, 'area'); % waÅ¼ne pozniej, wybierjamy slelektywnie
a = imread('peppers.png');
[Nz, Nx, k] = size(a);

%Profilowanie:
subplot(121), imshow(a);
subplot(122), improfile(a, [1 Nx], [1 Nz]);

%%
close all;clear;clc;

a = imread('peppers.png');
[Nz, Nx, k] = size(a);

%a = a(:, :, 1);
%a = a(:, :, 2);

%Profilowanie:
subplot(121), imshow(a);
subplot(122), 
b = improfile(a, [1 Nx/2 Nx Nx], [1 Nz 1 Nz]);
N = size(b, 1);
plot(1:N, b(:, 1, 1), 'r', 1:N, b(:, :, 2), 'g');

%%
close all;clear;clc;
%Interpolacja
%Zmniejszenie obrazka:
%a = imread('peppers.png');
a = imread('cameraman.tif');
%a = checkerboard(8, 4, 4);
subplot(221), imshow(a);
skala = 4.42;
b1 = imresize(a, skala, 'nearest');
b2 = imresize(a, skala, 'bilinear');
b3 = imresize(a, skala, 'bicubic');
subplot(222), imshow(b1);
subplot(223), imshow(b2);
subplot(224), imshow(b3);