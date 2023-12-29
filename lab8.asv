close all; clear; clc; 
% Transformata fouriera

a = imread("cameraman.tif");
a = double(a)/255; % musimy na doubla od razu skonwertowac
A = fftshift(fft2(a));
WA = abs(A);
subplot(121), imshow(a);
subplot(122), imagesc(log(WA+0.01)), axis image % musimy dodac cos by nie bylo samej kropki

%%
%pobieramy rozmiar naszego obrazka
[Nz, Nx] = size(a);
fx = linspace(-0.5, 0.5, Nx);
fz = linspace(-0.5, 0.5, Nz);
subplot(122), imagesc(fx, fz, log(WA+0.01)), axis image % musimy dodac cos by nie bylo samej kropki


% proszę stworzyć filtr cześtotliwościowy
% PROSZE Wykonac 4 filtracje idealne LP o odciecięciu f0
f0 = [0.05, 0.1, 0.2, 0.5];
% musimy obliczyc nasza odleglosc od srodka

[FX, FZ] = meshgrid(fx, fz);
f = sqrt(FX.^2 + FZ.^2);

for k = 1 : 4
    LP = f <= f0(k);
    an = real(ifft2(ifftshift(A .* LP)));
    subplot(2,2,k), imshow(an);
end
%%
% filtr Butterwortha
% wzor BT(f) = 1/(1+(f/f0)^(2N))

for k = 1 : 4
    LP = 1./(1+ (f/f0(k)).^4);
    an = real(ifft2(ifftshift(A .* LP)));
    subplot(2,2,k), imshow(an);
end

% obrazy 2D

%%
close all; clear; clc;
cd('D:\AGH-studia\Semestr_6\PDanychCyfrowych');
a = imread("F_dzieciol.png");
a = double(a)/255;
subplot(221), imshow(a);
% dla każdej palety osobno, R,G i B policzyć i wyświetlić widmo amp.
[Nz, Nx, k] = size(a);
fx = linspace(-0.5, 0.5, Nx);
fz = linspace(-0.5, 0.5, Nz);
[FX, FZ] = meshgrid(fx, fz);

BS = abs(FX)>0.17 & abs(FX)<0.24 & abs(FZ)>0.13 & abs(FZ)<0.24;
BS = 1 - BS;
b = a;
for k = 1 : 3
    A = fftshift(fft2(a(:,:,k)));
    WA = abs(A) .* BS;
    subplot(2,2,k+1), imagesc(fx, fz, log(WA+0.01));
    b(:,:,k) = real(ifft2(ifftshift(BS .* A)));
end

imshow(b);

%%
close all; clear; clc; 
% CORELACJA - Wyszukiwanie liter!!!

bw = imread('text.png');
a = bw(32:45, 88:98);
C = real(ifft2(fft2(bw) .* fft2(rot90(a,2), 256, 256)));

cmax = max(C(:));
wynik = C>0.95*cmax;
wynik = imdilate(wynik, ones(5,3));
wynik = imreconstruct(wynik, bw);
subplot(121), imshow(bw);
subplot(122), imshow(wynik);

%% PROSZĘ ZNALEŹĆ WSZYSTKIE POZIOME litery "r"

%%
close all; clear; clc; 
% CORELACJA

bw = imread('text.png');
a = bw(32:45, 4:13);
C1 = real(ifft2(fft2(bw) .* fft2(rot90(a,2), 256, 256)));
C2 = real(ifft2(fft2(~bw) .* fft2(rot90(~a,2), 256, 256)));
C = C1 + C2;

cmax = max(C(:));
wynik = C>0.95*cmax;
wynik = circshift(wynik, [0, -4]);
wynik = imdilate(wynik, ones(5,3));
wynik = imreconstruct(wynik, bw);
subplot(121), imshow(bw);
subplot(122), imshow(wynik);

%%
close all; clear; clc; 
% CORELACJA
a = imread("cameraman.tif");
[C, L] = wavedec2(a, 2, 'sym3')
L2 = L(:,1).*L(:,2); % skladowe dekompozycji
A2 = C(1:L2(1));
% detale horyzontalne
H2 = C(L2(1)+1:L2(1)+L2(2));
V2 = C(2*L2(1)+1:L2(1)+2*L2(2));
D2 = C(2*L2(1)+1:L2(1)+3*L2(2));
H1 = C(4*L2(1)+1: 4*L2(1) + L2(3));
V1 = C(4*L2(1)+L2(3)+1: 4*L2(1) + 3*L2(3));
D1 = C(4*L2(1)+2*L2(3)+1: 4*L2(1)+3*L2(3));
temp = reshape(D1, L(3,:));

% detale horyzontalne

imagesc(temp); axis image
% Wykonaj waverec2(C1, L, 'sym3'), A2=0, H1=0, D1=0
% i porownac z obrazem wyjsciowym
C1 = C;
C1(1:L2(1))=0;
an = waverec2(C1, L, 'sym3');
subplot(2,2,1), imagesc(an); axis image;

C1 = C;
C1(4*L2(1)+1: 4*L2())






