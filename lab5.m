% 1 -> 1
% X -> 0
% 0 -> -1

% Gdy zobaczymy u Pana [1 0; 0 1] to musimy w matlabie 
% zapisac jako [1 -1; -1 1]

% bwhitmiss


%% Zrobic obrazek 128x128 typu logicznego, z literka H w srodku 
% (wysokosc 60, szseroksoc 60), -> biala literka H na czarnym tle

N = 128;
kwadrat = false(N);
kwadrat(35:94, 35:54) = true;
kwadrat(35:94, 75:94) = true;
kwadrat(55:74, 55:74) = true;

SE = [1 1 1; 1 1 1; 1 1 -1];
wyn = false(128);

for k = 1:4
    wyn = wyn | bwhitmiss(kwadrat, SE);
    SE = rot90(SE);
end

wyn = uint8(wyn) + uint8(kwadrat); % zatem punktu bedą mialy wartosc 2
leg = [0 0 0; 1 1 1; 1 0 0]; % mapa kolorów
imshow(wyn, leg);

%%
close all; clear; clc;
% Aby zamienic naszą figure na figure wypukłą należy:
% Po dodaniu wyniku hitormiss do obrazu nalezy wykonac 
% a = bwmorph(a, 'clean')

N = 128;
a = false(N);
a(35:94, 35:54) = true;
%a(35:94, 75:94) = true;
a(55:74, 55:74) = true;
%imshow(a);
cd('D:\AGH-studia\Semestr_6\PDanychCyfrowych');
imwrite(a, 'figura_1.png');
SE1 = [1 1 0; 1 -1 0; 1 0 -1];
SE2 = [1 1 1; 1 -1 0; 0 -1 0];
b = false(128);
while ~isequal(a,b)
    b = a;
    for k = 1:4
        a = a | bwhitmiss(a, SE1); % suma logiczna
        a = bwmorph(a, 'clean');
        a = a | bwhitmiss(a, SE2);
        SE1 = rot90(SE1); SE2 = rot90(SE2);
    end
end

imshow(a)

%%
close all; clear; clc;

% clean oraz fill, jedna usuwa a druga wypełania
% bridge and hbreak, łączy jednopikselowe przerwy a przeciwieknstwo je
% rozłacza
% delete and erode
% 'thin' 'thicken'

a = imread('circles.png');
a1 = bwmorph(a, 'thin', Inf);
a2 = bwmorph(a, 'thicken', Inf);
a3 = bwmorph(a, "skel", Inf);
a2 = bwmorph(a, 'spur', Inf);

subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

%%
close all; clear; clc;

% tophat - slyzy do wyupuklenia jasnych obiektow na ciemnym tle
% bothat -> służy do wypuklania ciemnych na jasnym tle

% kwadrat 200x200, z kolkami w srodku, o promieniu r=5:5:70
% P = pi*r^2

N = 200;
a = zeros(N); % musi byc zeros bo odleglosc jest zmiennoprecinkowa a nie logiczna
for kz = 1:200
    for kx = 1 : 200
        a(kz, kx) = sqrt((kz-100)^2+(kx-100)^2);
    end
end

 imagesc(a);
r = 5 : 5 : 70;
pole_mat = pi*r.*r;
pole_px = zeros(size(r));
for k = 1:14
    tt = (a<=r(k));
    pole_px(k) = sum(tt(:));
end

imshow(tt);
%plot(r, pole_px, 'r', r, pole_mat, 'ok');

%%
close all; clear; clc;
% matematycznie, gradientem morfologiycznych, filtracja

N = 200;
a = zeros(N); % musi byc zeros bo odleglosc jest zmiennoprzecinkowa a nie logiczna
for kz = 1:200
    for kx = 1 : 200
        a(kz, kx) = sqrt((kz-100)^2+(kx-100)^2);
    end
end

% imagesc(a);
r = 5 : 5 : 70;
%pole_mat = pi*r.*r;
%pole_px = zeros(size(r));
obw_mat = 2 * pi * r;
obw_filt = zeros(size(r));
obw_grad = zeros(size(r));

for k = 1:14
    tt = (a<= r(k));
    temp = imdilate(tt, ones(3)) - imerode(tt, ones(3));
    obw_grad(k) = sum(temp(:))/2;
    temp = edge(tt, 'canny');
    obw_filt(k) = sum(temp(:));
    obw_pp(k) = bwarea(bwperim(tt));
end

plot(r, obw_grad, 'r', r, obw_filt, 'g', r, obw_mat, 'ok', r, obw_pp, 'b')

%% 
close all; clear; clc;

a = false(100);
for k = 1:3
    x = ceil(100*rand(1));
    z = ceil(100*rand(1));
    a(z,x) = true;
end

% imshow(a)

a1 = bwdist(a, 'euclidean');
a2 = bwdist(a, 'quasi-euclidean');
a3 = bwdist(a, 'cityblock');
a4 = bwdist(a, 'chessboard');

subplot(221), imagesc(a1); axis image; colorbar('vertical');
subplot(222), imagesc(a2); axis image; colorbar('vertical');
subplot(223), imagesc(a3); axis image; colorbar('vertical');
subplot(224), imagesc(a4); axis image; colorbar('vertical');

%% Strefa buforowa
close all; clear; clc;

% Poszukujemy miejsca do życia:
% 1-LAS (zawiera sie w lesie)
% 2-droga główna > 20px
% 3-droga poboczna <=10px
% woda  >= 15px

% znalezc las, droge poboczna i grogi glownej, oraz jezioro
% bwdist()
% bwdist()
% bwdist() dla wody 

a  = imread('new_map.bmp');
subplot(121), imshow(a);
las = a(:,:,1) == 185 & a(:,:,2) == 215 & a(:,:,3)==170;
d_g = a(:,:,1) == 255 & a(:,:,2) == 245 & a(:,:,3)==120;
d_g = imclose(d_g, ones(1,3));
d_p = a(:,:,1) == 255 & a(:,:,2) == 255 & a(:,:,3)==255;
d_p = imopen(d_p, ones(1,3));
d_p = imclose(d_p, ones(1,3));
woda = a(:,:,1) >= 64 & a(:,:,2) >= 159 & a(:,:,3)<=251;
woda = a(:,:,1) <= 170 & a(:,:,2) <= 200 & a(:,:,3)>=175;
woda = imopen(woda, ones(1,3));

wyn = las & bwdist(d_g)>20 & bwdist(d_p)<=10 & bwdist(woda)>=15;
wynik = imoverlay(a, wyn, 'r');
subplot(122), imshow(wynik);




