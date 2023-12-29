%%
close all; clear; clc;

SE1 = strel('disk', 6);
SE2 = strel('line', 11, 60);
SE3 = strel('arbitrary', [0 1 0; 1 1 1; 0 1 0]); % +

%Operacje morfologiczne

% EROZJA
% a = imread('circles.png');
% a = imread('cameraman.tif'); % dla obrazu monochromatyczny
a = imread('peppers.png'); % dla obrazu kolorowego
a1 = imerode(a, SE1);
a2 = imerode(a, SE2);
a3 = imerode(a, SE3);

subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);



%%
%Dylacja/dylatacja

%a = imread('circles.png');
% a = imread('cameraman.tif'); % dla obrazu monochromatyczny
 a = imread('peppers.png'); % dla obrazu kolorowego
a1 = imdilate(a, SE1);
a2 = imdilate(a, SE2);
a3 = imdilate(a, SE3);

subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

%%
% circles.png, SE1 = ones(11), SE2 = ones(3);
% dylacji SE1, serie dylacji SE2, dopuki nie bedzie identyczny z wynikiem
% dylacji SE1. Prosze podac ilosc iteracji aby wynik był równy
% (isequal(a,b))

close all;

a = imread('circles.png');
SE1 = ones(11);  SE2 = ones(3);
b = imdilate(a, SE1);
n=0;
while ~isequal(a,b);
    a = imdilate(a, SE2);
    n = n+1;
end
n

%%
close all; clear; clc;

% Otwarcie - najlpeir erozja potem dylacja

SE1 = strel('disk', 1);
SE2 = strel('line', 5, 45);
SE3 = strel('arbitrary', [0 1 0; 1 1 1; 0 1 0]); % +

% a = imread('circles.png');
%a = imread('cameraman.tif'); % dla obrazu monochromatyczny
%a = imread('peppers.png'); % dla obrazu kolorowego
a = imread('blobs.png')
%a = imread('cameraman.tif');
%cd('D:\AGH-studia\Semestr_6\PDanychCyfrowych');
%imwrite(a, 'tire_1.png');
a1 = imopen(a, SE1);
a2 = imopen(a, SE2);
a3 = imopen(a, SE3);

subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

imshow(a2)

%%
close all; clear; clc;

% Zamkniecie - najlpeir dylacja potem erozja

SE1 = strel('disk', 6);
SE2 = strel('line', 5, 60);
SE3 = strel('arbitrary', [0 1 0; 1 1 1; 0 1 0]); % +

% a = imread('circles.png');
 a = imread('cameraman.tif'); % dla obrazu monochromatyczny
%a = imread('peppers.png'); % dla obrazu kolorowego
a1 = imclose(a, SE1);
a2 = imclose(a, SE2);
a3 = imclose(a, SE3);

subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

%%
close all; clear; clc;

a = imread('blobs.png');
subplot(121), imshow(a);
% usunąć wszystkie poziome elementy, pionowe mają ocaleź, ukośne jak się
% uda
SE =ones(11,1);
b = imopen(a, SE);
subplot(122), imshow(b);

%% gradient morf. SE - jeden. ones(3), "+", I - obraz
% 1) D - I
% 2) I - E
% 3a) D - E
% 3b) (D-E)/2
% circles. png

%%
close all; clear; clc;

a = imread('circles.png');
SE = ones(3);
a1 = imdilate(a, SE) - a;
a2 = a - imerode(a, SE);
a3 = a1 + a2;

subplot(221), imshow(a);
subplot(222), imshow(a1);
subplot(223), imshow(a2);
subplot(224), imshow(a3);

% E <= O <= In <= C <= D

% E == D (gdy obraz jest jednostajny oraz gdy nasz element jest deltą
% diracka)

%% rekonstrukcja morf.
% cykliczenie wykonywana dylacja marekru elemenru jednostajego połaczona z
% iloczynem logicznym z obrazem wejściowym 

% 1) blobs.png
% 2) tworzymy marker - kopiujac skarajne wiersze/kolumny z blobs, reszta false
% 3) dopóki pomiędzy sąsiednimi iteracjami będą zmiany:
% -dylatacja markera ones(3)
% -iloczyn logiczny wyniku z blobs
% 4) od obrazu wejściowego odejmujecie wynik kroku 3.


%%
close all; clear; clc;

a = imread('blobs.png');
[Nz, Nx] = size(a);
marker = a;
marker(2:Nz-1, 2:Nx-1)=false;
b = a;
SE = ones(3);
while ~isequal(b, marker)
    b = marker;
    marker = imdilate(marker, SE) & a;
end
a = a & ~marker;
subplot(121), imshow(a);
subplot(122), imshow(marker);
% imclearborder(a); robi to samo co wyzej ale szybko
%%
%figura wypukła - dzielimy l prostą to cała jest w środku figury

%wypełniamy literę H
%maska: [1 1 1; 1 0 X; X X 0]

%rotacja o 45* -> przesuwamy po jednym elemencie dookoła
%2 elementy SE -> jeden przesunięty względem drugiego o 45*,  przesuwamy na
%zmianę co 90*
close all; clear; clc;
h=false(128);
h(35:94, 35:54)=true;
h(35:94, 75:94)=true;
h(55:74, 35:94)=true;
a=h;
imshow(h);
SE1=[1 1 0; 1 -1 0; 1 0 -1];
SE2=[1 1 1; 1 -1 0; 0 -1 0];
b=false(128);

while ~isequal(a,b)
    b=a;
    for k=1:4
        a=a | bwhitmiss(a,SE1);
        a=bwmorph(a, 'clean');
        a=a | bwhitmiss(a, SE2);
        SE1=rot90(SE1);
        SE2=rot90(SE2);
    end
end

%imshow(a);
%a=bwmorph(a, 'clean') ->  po hit miss żeby usunąć wypełnione rogi
%% Odległość geodezyjna:
close all; clear; clc;
a = imread("circles.png");
imshow(a);

% start (W,K) = 169, 180
% stop (w,k) = 131, 129
% SE = ones(3);
SE = [ 0 1 0; 1 1 1; 0 1 0];
% sa identyczne gdy znajduja sie w jednej linii i gdy nie ma żadnej przerwy
% pomiedzy nimi
% marker - true w start, reszta false
% zliczamy iteracje, dopóki w stop false -> true

marker = false(size(a));
marker(169, 180) = true;
iter = 0;
while ~marker(131, 129)
    marker = imdilate(marker, SE) & a;
    iter = iter + 1;
end

%%
% Zastosowanie rekonstrukcji -> WYPEŁNIENIE DZIUR w obiektach bez zmiany
% kszstałtu obiektu (by nie niszczyc zewnetrzych kontur)

% 1) negacja
% 2) usuniecie tła
% 3) dodanie dziury do obiektu

% Korzystając z rekonstrukcji usunąc dziury w circles.png 
close all; clear; clc;
a = imread("circles.png");
b = ~a;
b = imclearborder(b);
a = a | b;
imshow(b);

% imfill(obraz, 'holes')
% imreconstruct()

% Pamietac co to jest otwarcie i zamkniecie, dylacja i erozja, otwarcie do
% czyszczenia obrazu oraz do rozlaczenia elemetnwó
% zaMKNIEcie do polaczenia elementów

