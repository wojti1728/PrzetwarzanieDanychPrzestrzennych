%% Projetk 2 - do odnalezienia glaukonit, kwarc oraz węglany
%% GLAUKONIT
close all; clear; clc;

cd('D:\AGH-studia\Semestr_6\PDanychCyfrowych\Projekt_2\406288\406288');

an = imread("1N.jpg");
imshow(an);
an = imgaussfilt(an, 2);
subplot(121), imshow(an);
r = an(:, :, 1);
g = an(:, :, 2);
b = an(:, :, 3);

bin = r > 110 & r < 150 & g > 130 & g < 160 & b > 30 & b < 60;

bin = bin - bwmorph(bin, 'tophat');
bin = imclose(bin, ones(10));
bin = bwareaopen(bin, 800);
bin = imclose(bin, ones(5));
bin = imfill(bin, 'holes');
bin = imopen(bin, ones(12));
bin = imdilate(bin, ones(3));
bin = bwareaopen(bin, 1200);
bin = imclose(bin, ones(10));
SE2 = strel('disk', 12);
bin = imdilate(bin, SE2);
bin = imclose(bin, ones(5));
subplot(122), imshow(bin);

% Według skali 180px = 50um =0.05mm -> 360px = 100um = 0.1mm
pole_glaukolit=bwarea(bin) / 3600^2;
pole_glaukolit


%% KWARC
close all; clear; clc;


ak = imread("30.jpg");
imshow(ak);

subplot(121), imshow(ak);
r = ak(:, :, 1);
g = ak(:, :, 2);
b = ak(:, :, 3);

% Kwarc jasnoszary oraz średnio szary
bin = r > 110 & r < 220 & g > 120 & g < 230 & b > 110 & b < 220;
bin = bin - bwmorph(bin, 'tophat');
bin=bwareaopen(bin, 1000);
bin=imfill(bin,'holes');
bin=imopen(bin,strel('disk',5));
bin=imdilate(bin, strel('disk', 5));
bin=imclose(bin,strel('disk',5));

% Kwarc bardzo jasno szary (brakujacy)
bin5 = r > 220 & r < 250 & g > 210 & g < 250 & b > 200 & b < 240;
bin5 = bin5 - bwmorph(bin5, 'tophat');
bin5=imclose(bin5,strel('disk',7));
bin5=bwareaopen(bin5, 300);
bin5=imdilate(bin5, strel('disk', 4));
bin5=imfill(bin5,'holes');
bin5=bwareaopen(bin5, 3000);
bin5=imdilate(bin5, strel('disk', 5));

% Kwarc bardzo ciemny, nie czarny (brakujacy)
bin6 = r > 25 & r < 50 & g > 30 & g < 50 & b > 15 & b < 50;
bin6 = bin6 - bwmorph(bin6, 'tophat');
bin6=imclose(bin6,strel('disk',5));
bin6=bwareaopen(bin6, 200);
bin6=imdilate(bin6, strel('disk', 12));
bin6=bwareaopen(bin6, 3000);
bin6=imdilate(bin6, strel('disk', 8));
bin6=imopen(bin6,strel('disk',5));


% Kwarc ciemny szary oraz bardzo ciemny szary
bin2 = r > 40 & r < 160 & g > 60 & g < 150 & b > 50 & b < 170;
bin2 = bin2 - bwmorph(bin2, 'tophat');
bin2=bwareaopen(bin2, 1000);
bin2=imfill(bin2,'holes');
bin2=imopen(bin2,strel('disk',5));
bin2=bwareaopen(bin2, 1300);
bin2=imdilate(bin2, strel('disk', 5));
bin2=imclose(bin2,strel('disk',5));
bin2=imfill(bin2,'holes');
bin2=(bin2 & (~bin));

% Kwarc bardzo jasny i biały
bin3 = r > 240 & r <= 255 & g > 240 & g <= 255 & b > 215 & b <= 255;
bin3 = bin3 - bwmorph(bin3, 'tophat');
bin3=bwareaopen(bin3, 1500);
bin3=imfill(bin3,'holes');
bin3=imopen(bin3,strel('disk',5));
bin3=imdilate(bin3, strel('disk', 4));
bin3=imclose(bin3,strel('disk',5));
bin3=(bin3 & (~bin2));

% Chyba Mika (napewno nie kwarc)
bin4 = r > 45 & r <= 120 & g > 50 & g <= 110 & b > 100 & b <= 140;
bin4 = bin4 - bwmorph(bin4, 'tophat');
bin4=imclose(bin4,strel('disk',5));
bin4=bwareaopen(bin4, 1000);
bin4=imdilate(bin4, strel('disk', 6));

bin_sum = (bin3 | bin2 | bin | bin6 | bin5) & (~bin4);
bin_sum = bwareaopen(bin_sum, 1400);
bin_sum = imfill(bin_sum, 'holes');

subplot(122), imshow(bin_sum);

% Według skali 180px = 50um =0.05mm -> 360px = 100um = 0.1mm
pole_kwarc=bwarea(bin_sum) / 3600^2;
pole_kwarc

%% WĘGLANY
close all; clear; clc;

aw = imread("0.jpg");
imshow(aw);
subplot(121), imshow(aw);

%aw = rgb2lab(aw):
r = aw(:, :, 1);
g = aw(:, :, 2);
b = aw(:, :, 3);

% Weglany jasne i bardzo jasne pastelowe
bin = r > 220 & r <= 255 & g > 200 & g <= 255 & b > 160 & b < 220;
bin = bwareaopen(bin, 100);
bin=imfill(bin,'holes');
bin=imclose(bin,strel('disk',8));
bin = bwareaopen(bin, 1000);
bin=imdilate(bin, strel('disk', 6));

% Weglany bardzo pastelowe i ciemno bastelowe
bin2 = r > 160 & r <= 255 & g > 130 & g <= 180 & b > 60 & b < 140;
bin2 = bin2 - bwmorph(bin2, 'tophat');
bin2=imclose(bin2,strel('disk',8));
bin2=imclose(bin2,strel('disk',5));
bin2=imdilate(bin2, strel('disk', 7));
bin2=imclose(bin2,strel('disk',3));
bin2 = bwareaopen(bin2, 2600);
bin2=imclose(bin2,strel('disk',8));
bin2=imfill(bin2,'holes');
bin2=imdilate(bin2, strel('disk', 5));

% Kwarc jasno szary i szary
bin_sz = r > 200 & r <= 230 & g > 210 & g <= 240 & b > 190 & b < 230;
bin_sz = bwareaopen(bin_sz, 100);
bin_sz=imfill(bin_sz,'holes');
bin_sz=imdilate(bin_sz, strel('disk', 6));
bin_sz=imclose(bin_sz,strel('disk',6));

% Suma pewnych węglanów
bin_sum = (bin | bin2) & (~bin_sz);
bin_sum = bwareaopen(bin_sum, 600);

subplot(122), imshow(bin_sum);

% Według skali 180px = 50um =0.05mm -> 360px = 100um = 0.1mm
pole_weglany=bwarea(bin_sum) / 3600^2;
pole_weglany
