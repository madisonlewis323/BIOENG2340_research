%% Eye Dimension calculations

EyeDim=readmatrix('/Eye_Dimensions.xlsx');
isovol=readmatrix('/isocontour_vols.xlsx');

subnum=size(EyeDim,2);
for i=1:subnum
    a=(EyeDim(1,i))/2;
    b=(EyeDim(2,i))/2;
    c=(EyeDim(3,i))/2;
    averad(i)=(a+b+c)/3;
    Volsph(i)=(4/3)*pi*(averad(i)).^3;  %Assuming Spherical, using (4/3)(pi)r^3
    Volelip(i)=(4/3)*pi*a*b*c; %Assuming Ellipsoidal, using (4/3)(pi)abc
end

% Calculate Average and Standard Deviation for both groups 
aveSph=mean(Volsph);
stdSph=std(Volsph);
aveElip=mean(Volelip);
stdElip=std(Volelip);
aveiso=mean(isovol);
stdiso=std(isovol);

% Perform Ttest between measurement groups
[H,P]=ttest(Volsph,Volelip);

%Create Bar Graph
ave=[aveSph,aveElip];
std=[stdSph,stdElip];
X = categorical({'Spherical','Ellipsoidal'});

figure(1)
bar(X(1,1),ave(1,1),0.3,'b'); hold on;
bar(X(1,2),ave(1,2),0.3,'b'); hold on;
errH1=errorbar(ave(1,1),std(1,1)); hold on;
errH2=errorbar(ave(1,2),std(1,2)); hold on;
errH1.LineWidth = 1.5;
errH2.LineWidth = 1.5;
errH1.Color = [1 0 0];
errH2.Color = [1 0 0];
ylabel('Volume (mm^3)')
title('Volume Assuming different Eye Shapes')
hold on;

%% Bar graph for different measurements
figure(1)
x=[aveSph aveElip aveiso]
m= categorical({'Spherical', 'Ellipsoidal', 'Isocontour'});
m= reordercats(m, {'Spherical', 'Ellipsoidal', 'Isocontour'});
bar(m,x)
ylabel('Volume mm^3')
title('Different Volume Measurements on Average')

figure(2)
y=[Volsph(1,1) Volelip(1,1) isovol(1,1)]
bar(m,y)
ylabel('Volume mm^3')
title('Different Volume Measurements for Subject 1')

