%% Eye Dimension calculations

EyeDim=readmatrix('/Eye_Dimensions.xlsx');
isovol=readmatrix('/isocontour_vols.xlsx');
edgevol=readmatrix('/Segmentation_edge.xlsx');

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
aveedge=mean(edgevol);
stdedge=std(edgevol);

% Perform Ttest between measurement groups
[H,P]=ttest(Volsph,Volelip);
[H,P]=ttest(isovol,edgevol);

%% Bar graph for different measurements
figure(1)
x=[aveSph aveElip aveiso aveedge]
m= categorical({'Spherical', 'Ellipsoidal', 'Thresholding Seg.', 'Edge Attraction'});
m= reordercats(m, {'Spherical', 'Ellipsoidal', 'Thresholding Seg.', 'Edge Attraction'});
bar(m,x)
ylabel('Volume mm^3')
title('Different Volume Measurements on Average')

figure(2)
y=[Volsph(1,1) Volelip(1,1) isovol(1,1) edgevol(1,1)]
bar(m,y)
ylabel('Volume mm^3')
title('Different Volume Measurements for Subject 1')

