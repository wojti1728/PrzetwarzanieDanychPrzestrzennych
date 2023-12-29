%%
% Transformata Gabora
% Opiera się o bank filtrów (długość fali i jej orientacja)

cd('D:\AGH-studia\Semestr_6\PDanychCyfrowych\Projekt_1_Python\');
a = imread('Gabor.png');
a = imresize(a, 0.5);
dlug_fali = 2.^(1:3);
krok = 12.5;
katy = 0 : krok : 180-krok;

g = gabor(dlug_fali, katy); % Bank filtrów

%imagesc(abs(g(48).SpatialKernel));

% Robimy konolucje dla każdego obrazu
magn = imgaborfilt(a,g);
for k = 1 : length(g)
    odch = 1.5*g(k).Wavelength;
    magn(:,:,k) = imgaussfilt(magn(:,:,k),odch);
end
%%
[Nz, Nx] = size(a);
x = 1 : Nx;
z = 1 : Nz;
[XX, ZZ] = meshgrid(x, z);
zbior = cat(3, magn, XX);
zbior = cat(3, zbior, ZZ);
D2 = reshape(zbior, Nx*Nz, []);
D1 = D2 - mean(D2);
D1 = D1 ./ std(D1);
L = kmeans(D1, 2, 'Replicates', 5);
wynik = reshape(L, [Nz, Nx]);
imagesc(wynik);
%%
bw = (wynik==2);
bw = imclearborder(bw);

bw = bwareaopen(bw, 1000);
SE1 = strel('disk', 5);
bw = imopen(bw, SE1)
bw = bwareaopen(bw, 1000);
bw = imfill(bw, 'holes');
an = imoverlay(a, ~bw, 'k');
imshow(an)

%%
% Transformata Cosinusowa
a = imread("cameraman.tif")
a = double(a)./255;
A = dct2(a);
imshow(A);
subplot(121), imshow(a);
subplot(122), imagesc(log(abs(A)+0.01));

r = [5, 10, 25, 50, 100];
% Wykonac białe cwiartki na czarnym tle
% tworzymy naszą cwiartke
dyst = zeros(size(a))
dyst(1,1) = 1;
dyst = bwdist(dyst);
figure;
th = [ 0.01 0.05 0.1 0.5 1.0];
for k = 1 : length(r)
%    maska = dyst < r(k);
    maska = abs(A)>th(k);
    disp(100*sum(maska(:)==0));
    an = idct2(A .* maska); % odwrotna transformata
    subplot(2,3,k), imshow(an);
end

subplot(236), imshow(a)
%%
% KWANTYFIKACJA PODLEGA NA PODZIELENIU I ZAOKRĄGLENIU !!!

Qy = [16 11 10 16 24 40 51 61
12 12 14 19 26 58 60 55
14 13 16 24 40 57 69 56
14 17 22 29 51 87 80 62
18 22 37 56 68 109 103 77
24 35 55 64 81 104 113 92
49 64 78 87 103 121 120 101
72 92 95 98 112 100 103 99 ];

Qc = [17 18 24 47 99 99 99 99
18 21 26 66 99 99 99 99
24 26 56 99 99 99 99 99
47 69 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99
99 99 99 99 99 99 99 99 ];

skala = 2.5;
Qc = skala * Qc;
Qy = skala * Qy;


a = imread('peppers.png')
[Nz, Nx, k] = size(a);
N_zero = 0;

b = rgb2ycbcr(a);
b = double(b) - 128;

for kz = 1 : 8 : Nz
    for kx = 1 : 8 : Nx
        for k = 1 : 3

            tt = b(kz:kz+7, kx:kx+7, k);
            tt = dct2(tt);
            if k==1
                tt = round(tt ./ Qy);
            else
                tt = round(tt ./ Qc);
            end
            N_zero = N_zero + sum(tt(:)==0);
            if k==1
                tt = tt .* Qy;
            else
                tt = tt .* Qc;
            end
            tt = idct2(tt);
            b(kz:kz+7, kx:kx+7, k) = tt;
        end
    end
end

b = uint8(b+128);
b = ycbcr2rgb(b);
subplot(121), imshow(a);
subplot(122), imshow(b);
disp(100*N_zero)

%% TRANSFORMATA RADONA
close all; clear; clc;

% obraz 120wierszy x 200kolumn - czarne tło
% na środku biały prostokąt o wym. 60x100

a = zeros(120, 200);
a(31:90, 51:150)=1;
kat = 0 : 1 : 180;
[R, X] = radon(a, kat);
imagesc(kat, X, R);
colormap(hot(256));

an = iradon(R, kat);
imshow(an);

% Projekt 2:
% skala oblizcmay recznie bez skryptu, do imtoola, recznie zmierzyc a potem sobie przeliczyc
% w sprawozdaniu zamieszczamy tylko jedno zdjecie, jeden i xn
% minerały są z mare zwarte, usuwac nawet takie kilkunasto pikselowe
% czy dany minerał nie jest w dwoch klasach jednoczesie, muszą byc zbiory rozlaczne
% zdjęcia z rotacja, analizuejemy tylko czesc wspolna zdjec



    