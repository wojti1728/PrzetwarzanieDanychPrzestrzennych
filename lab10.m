%% Transformata Hougha
close all; clear; clc; 

% Sprowadza się do trzech czynności

a = imread("blobs.png");
%subplot(121), imshow(a);

[H, T, R] = hough(a); % H-tablcia dwuwymiarowa, T, R wektory 
pik = houghpeaks(H, 10); % te wartosci nalezy zamienic na linie
L = houghlines(a, T, R, pik, 'FillGap',5);
%subplot(122), imagesc(T,R,H);
imshow(a); hold on;
max_odl = -Inf;
for k = 1 : 10
    line([L(k).point1(1), L(k).point2(1)], ...
        [L(k).point1(2), L(k).point2(2)], 'color', 'g');
    odl = sqrt((L(k).point1(1) - L(k).point2(1))^2+...
        (L(k).point1(2) - L(k).point2(2))^2); % tak znajdujemy
    % najdluzsza linie spośród tych zeilonych
    if odl > max_odl
        max_odl = odl;
        n = k;
    end
end
k = n;
    line([L(k).point1(1), L(k).point2(1)], ...
        [L(k).point1(2), L(k).point2(2)], 'color', 'r');
hold off

%%
cd('D:\AGH-studia\Semestr_6\PDanychCyfrowych\Laby_notatki');
% Szukamy kół korzystając z metod analizy obrazu

close all; clear; clc; 
[map, pal] = imread('w_shape.png');
a = ind2rgb(map, pal); % obraz indeksowany
subplot(121), imshow(a);
bin = (map ~= 11); % sprawdzamy indeks tła za pomocą imagesc(map) !!!
subplot(122), imshow(bin);

% SZUKAMY KOŁA
% obliczamy wsółczynniki kształtu
% bezwymiarowy współczynnik kształtu 
% robimy etykietowanie, licznymy dla kazdego obiektu pole obwod
% potem liczmy wspolczynnik kształtu

[aseg, N] = bwlabel(bin); % robimy etykietowanie 
kolo = false(size(bin));
for k = 1 : N
    tt = (aseg == k);
    pole = bwarea(tt);
    obwod = bwarea(bwperim(tt));
    bwk = 4 * pi * pole / (obwod * obwod);
    if abs(bwk-1) < 0.05
        kolo = kolo | tt;
    end
end
imshow(kolo);

%%
% SZUKAMY KWADRATU
[aseg, N] = bwlabel(bin); % robimy etykietowanie 
kwadrat = false(size(bin));
for k = 1 : N
    tt = (aseg == k);
    pole = bwarea(tt);
    obwod = bwarea(bwperim(tt));
    bwk = 4 * pi * pole / (obwod * obwod);
    if abs(bwk-pi/4) < 0.02 % lepsza tolerancja, by być bardziej dokladnym
        kwadrat = kwadrat | tt;
    end
end
imshow(kwadrat);

% SZUKAMY ELIPSY
% musimy wyciągnąć półosie
pp = regionprops(aseg, 'all');
%%
elipsa = false(size(bin));
for k = 1 : N
    tt = (aseg == k);
    pole = bwarea(tt);
    obwod = bwarea(bwperim(tt));
    bwk = 4 * pi * pole / (obwod * obwod);
%     if abs(bwk-pi/4) < 0.02 % lepsza tolerancja, by być bardziej dokladnym
%         elipsa = elipsa | tt;
%     end
    pm = pi * pp(k).MinorAxisLength * pp(k).MajorAxisLength/4;
    if abs(pm/pole - 1)<0.02
        elipsa = elipsa | tt;
    end
end
imshow(elipsa);

% SZUKAMY GWIAZDEK
%%
kolo = false(size(bin));
wsp = zeros(size(bin));

for k = 1 : N
    tt = (aseg == k);
    pole = bwarea(tt);
    obwod = bwarea(bwperim(tt));
    bwk = 4 * pi * pole / (obwod * obwod);
    wsp = wsp + bwk * tt;
%     if abs(bwk-pi/4) < 0.02 % lepsza tolerancja, by być bardziej dokladnym
%         elipsa = elipsa | tt;
%     end
    pm = pi * pp(k).MinorAxisLength * pp(k).MajorAxisLength/4;
%     if abs(pm/pole - 1)<0.02
%         kolo = kolo | tt;
%     end
    if bwk > 0.24 & bwk < 0.27 & pp(k).EulerNumber > 0
        kolo = kolo | tt;
    end
end
imshow(kolo);

% w region props mamy wiele ciekawaych parametrów np. BoungingBox, 


%% KOLOKWIUM
% musimy sie podzielic po 15 osób
% sklada sie z dwóch cześci, teria i praktyka
% czesc teoretyczna
% teria,25 min, 6 pytań, wlasnosci dylatacji, wzór fereta, podac wzory/wlasnosci, 
% bardzo proste obliczneia, tylko z pdfu, nie uczyc sie masek na pamiec,
% tylko preuit i sobel

% Praktyka:
% 3 zadania w matlabi, jedno z analizy (a nawet dwa)
% mozna miec na czesci praktycznej pdfy wydrukowane
% nie bedzie mozna korzsytac z narzedzi z imagsegeskator czy cos (imtolla
% mozna)
% będzie filtracja itp

%% Wykres png
close all; clear; clc; 
% digitalizacja danych rastrowych
a = imread('wykres.png');
subplot(121), imshow(a);

kmin = 343;
wmin = 113;
kmax = 2375;
wmax = 1312;
bin = a(wmin:wmax, kmin:kmax, 1) == 126;
subplot(122), imshow(bin);
[Nz, Nx] = size(bin);
t = zeros(Nx,1);
p = zeros(Nx,1);
k = 1;
for kx = 1 : Nx
    suma = sum(bin(:,kx));
    if suma > 0
        pmin = find(bin(:,kx), 1, 'first');
        pmax = find(bin(:,kx), 1, 'last');
        pp(k) = (pmin+pmax)/2;
        tt(k) = kx;
        k = k+1;
    end
end

pp(k:end) = [];
tt(k:end) = [];
tt = tt*350/Nx;
pp = 35000 - 35000*pp/Nz;
tt2 = 0 : 2 : 336; % czas
pp2 = interp1(tt, pp, tt2); % ciśnienie
plot(tt, pp, 'r', tt2, pp2, 'go');

