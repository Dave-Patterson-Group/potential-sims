function paulSecularFreqsTutorial()
%FYI on my computer, this script takes approximately 5 minutes to run, so
%don't panic if it doesn't finish instantly

%This script could technically be made to run faster by just generating all
%of the DC electrode potentials in 1 model, and the RF pseudopotential in
%another, but I decided to split all of the DC electrodes up to showcase
%how they can be added back together. This idea of calculating the
%potentials for each electrode at 1 V separately and then scaling and
%adding them together at the end will be extremely useful for calculating
%trajectories

%Generating DC electrodes results at 1 V since they scale easily
resultFarLeft = paulFields(1,1);
resultLeft = paulFields(2,1);
resultCenter = paulFields(3,1);
resultRight = paulFields(4,1);
resultFarRight = paulFields(5,1);

%Generating RF result at 100V since, although the true potential does
%scale, the pseudopotential does not
resultRF = paulFields(6,100);%<= Change from 100 V to a new RF amplitude

% figure(1);
[X,Y,Z] = meshgrid(43,-4:0.01:4,0);

Vpseudo = calcPseudoPot(resultRF,X,Y,Z,2e6);%<= Change from 2e6 Hz to a new RF frequency
Vpseudo = reshape(Vpseudo,size(X));

VFarLeft = interpolateSolution(resultFarLeft,X,Y,Z);
VFarLeft = reshape(VFarLeft,size(X));

VLeft = interpolateSolution(resultLeft,X,Y,Z);
VLeft = reshape(VLeft,size(X));

VCenter = interpolateSolution(resultCenter,X,Y,Z);
VCenter = reshape(VCenter,size(X));

VRight = interpolateSolution(resultRight,X,Y,Z);
VRight = reshape(VRight,size(X));

VFarRight = interpolateSolution(resultFarRight,X,Y,Z);
VFarRight = reshape(VFarRight,size(X));

V = 60 * VFarLeft + 60 * VLeft + 0 * VCenter + 60 * VRight + 60 * VFarRight + Vpseudo;
%   ^               ^            ^             ^             ^
%   |               |            |             |             |
%       Change values to change voltages on DC electrodes


% plot(Y,V);
% xlabel('y (mm)');
% ylabel('Potential (V)');
% title('Radial Effective Potential');

[RadialFrequency01,SSRradial01] = harmonicity(Y,V,1);



% figure(2);
[X,Y,Z] = meshgrid(30:0.1:60,0,0);

Vpseudo = calcPseudoPot(resultRF,X,Y,Z,2e6);%<= Change from 2e6 Hz to a new RF frequency
Vpseudo = reshape(Vpseudo,size(X));

VFarLeft = interpolateSolution(resultFarLeft,X,Y,Z);
VFarLeft = reshape(VFarLeft,size(X));

VLeft = interpolateSolution(resultLeft,X,Y,Z);
VLeft = reshape(VLeft,size(X));

VCenter = interpolateSolution(resultCenter,X,Y,Z);
VCenter = reshape(VCenter,size(X));

VRight = interpolateSolution(resultRight,X,Y,Z);
VRight = reshape(VRight,size(X));

VFarRight = interpolateSolution(resultFarRight,X,Y,Z);
VFarRight = reshape(VFarRight,size(X));

V = 60 * VFarLeft + 60 * VLeft + 0 * VCenter + 60 * VRight + 60 * VFarRight + Vpseudo;
%   ^               ^            ^             ^             ^
%   |               |            |             |             |
%       Change values to change voltages on DC electrodes

% plot(X,V);
% hold on
% ylabel('Potential (V)');
% xlabel('z');
% title('Axial Potential');

[AxialFrequency01,SSRaxial01] = harmonicity(X,V,1);

