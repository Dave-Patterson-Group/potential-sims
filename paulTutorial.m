function paulTutorial()
%Generating DC electrodes results at 1 V since they scale easily
resultFarLeft = paulFields(1,1);
resultLeft = paulFields(2,1);
resultCenter = paulFields(3,1);
resultRight = paulFields(4,1);
resultFarRight = paulFields(5,1);

%Generating RF result at 100V since, although the true potential does
%scale, the pseudopotential does not
resultRF = paulFields(6,100);%<= Change from 100 V to a new RF amplitude

% Figures 1 and 2 are the radial potential and pseudopotential, ignoring
% the DC electrode potentials, since the DC electrodes where the ions
% are trapped will generally be set to ground
figure(1);
[X,Y,Z] = meshgrid(43,-8:0.1:8,-8:0.1:8);
V = interpolateSolution(resultRF,X,Y,Z);
V = reshape(V,size(X));
y = reshape(Y,[161,161]);
z = reshape(Z,[161,161]);
v = reshape(V,[161,161]);
surf(y,z,v);
xlabel('y (mm)');
ylabel('z (mm)');
zlabel('Potential (V)');
title('Radial Instantaneous Maximum Potential');

figure(2);
[X,Y,Z] = meshgrid(43,-8:0.1:8,-8:0.1:8);
V = calcPseudoPot(resultRF,X,Y,Z,2e6);%<= Change from 2e6 Hz to a new RF frequency
V = reshape(V,size(X));
y = reshape(Y,[161,161]);
z = reshape(Z,[161,161]);
v = reshape(V,[161,161]);
surf(y,z,v);
xlabel('y (mm)');
ylabel('z (mm)');
zlabel('Potential (V)');
title('Radial Pseudopotential');

%Figures 3 and 4 are the potentials along the trap's axis, for the entire
%length of the trap, and for just the center, respectively. In these cases,
%the two farthest endcaps are set to 60 V, the center electrode is set to
%0, and the two in between are set to 30 V. This is ignoring the RF
%potential/pseudopotential, since that only varies radially

figure(3);
[X,Y,Z] = meshgrid(0:85,0,0);

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

V = 60 * VFarLeft + 30 * VLeft + 0 * VCenter + 30 * VRight + 60 * VFarRight;
%   ^               ^            ^             ^             ^
%   |               |            |             |             |
%       Change values to change voltages on DC electrodes

plot(X,V);
hold on
ylabel('Potential (V)');
xlabel('z');
title('Axial Potential');


