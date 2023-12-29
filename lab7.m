%% Wprowadzenie do analizy obrazu:

%%
close all; clear; clc;

% Stwórz obraz o nastepującym krztałcie i rozmiarze

a = false(100, 200);
a(50, [72, 128]) = true;
a = (bwdist(a)<=30);
imshow(a)

%% Musimy rodzielic te dwa kólka (metoda watershed) 
% watershed wewnątrz obiektu

D = -bwdist(~a);
L = watershed(D);
imagesc(L);

a = a & (L>0);
imshow(a);

close all;
% watershed na zewnątrz obiektu
% 1) do zmiennej pomocniczej wykonac erozje rodzielajacą koła
% 2) policzyć bwdista
% 3) wyznaczyć dział wodny
% 4) linia 10

temp = imerode(a, ones(23));
D = bwdist(temp);
L = watershed(D);
a = a & (L>0);
imshow(a);

%% etykietowanie
% wczytac obraz coins.png i zbinaryzować
close all; clear; clc;

a = imread('coins.png');

subplot(121), imshow(a);
bin = a>90;
bin = medfilt2(bin, [3 3]);
subplot(122), imshow(bin);

[aseg, N] = bwlabel(bin);

imagesc(aseg); axis image

% dla kazdej monety policzyc pole i obwód 
% Wynik wyświetlić w konsoli
pole = zeros(N, 1);
obwod = zeros(N, 1);
for k = 1:N
    temp = (aseg==k);
    pole(k,1) = sum(temp(:));
    obwod(k,1) = bwarea(bwperim(temp));
end

disp(pole);
disp(obwod);
%%
% Zadanie, stworzyć:
% obraz: na podstawie coins.png stworzyć obraz, który zawiera
% 5 największych monet w kolorze naturalnym, 
% 5 najmniejszych ma byc białe, tło czarne

prog = median(pole);
wynik = zeros(size(a), 'uint8');
for k = 1 : N
    if pole(k,1)>prog
        wynik = wynik + uint8(aseg==k).*a;
    else
        wynik = wynik + 266*uint8(aseg==k);
    end
end

imshow(wynik);

%% Analiza obrazu:
% 1) Akwizycja
% 2) Przetwarzanie wstępne
% - f. 
% - korekcje geometryczne
% - odszumianie
% - przycinanie
% 3) Segmentacja (binaryzacje, etykietowanie, operacje na oobrazach logicznych)
% 4) Analiza -> przypisanie watosci liczbowych
% 5) Wizualizacja
% Po każdym w powyższych etapów musi być WERYFIKACJA!

%%
close all; clear; clc;
a  = imread('rice.png');
subplot(121), imshow(a)
% Policzenie pól i obwodów każdego ziaren
% wyświetlenie histogramów pól i obwodów
%bin = a>120;
b = imtophat(a, strel('disk', 10)); % słuzy aby przyciemnic ciemne a rozjasnic jasne elementy
b = imadjust(b); % poprawiamy normalizacja
bin = b>95;
bin = bwareaopen(bin, 10, 4); %usuwamy niewielkie szumy (w tym wypadku małe kropki)

% Rozdzielamy nasze obiekty (przez erozje w tym wypadku)
subplot(122), imshow(bin);

temp = imerode(bin, ones(5));
imshow(temp);

D = bwdist(temp);
L = watershed(D);
bin = bin & (L>0);

bin = imclearborder(bin); % usuwamy wszsytkie ziarna które mają coś wspolnego z granicami naszego obrazu

[aseg, N] = bwlabel(bin);
pole = zeros(N,1);
obwod = pole;

for k = 1 : N
    temp = aseg==k;
    pole(k) = sum(temp(:));
    obwod(k, 1) = bwarea(bwperim(temp));
end
figure;
jk = uint8(bin).*a;
kj = uint8(~bin).*a;
%subplot(121), hist(pole, 10); %imshow(jk);
%subplot(122), hist(obwod, 10); %imshow(kj);
 subplot(121), imshow(jk);
 subplot(122), imshow(kj);






