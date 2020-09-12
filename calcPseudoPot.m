function pseudoPot = calcPseudoPot(result,X,Y,Z,frequency)
%[X,Y,Z] is a meshgrid over the desired coordinates
%result is a PDE toolbox object that contains the calculated solution
%https://en.wikipedia.org/wiki/Ponderomotive_force
%This returns the RF pseudopotential

[gradX,gradY,gradZ] = evaluateGradient(result,X,Y,Z);
gradX = reshape(gradX,size(X));
gradY = reshape(gradY,size(Y));
gradZ = reshape(gradZ,size(Z));
Ex = -gradX;
Ey = -gradY;
Ez = -gradZ;
Esquared = (Ex .* Ex) + (Ey .* Ey) + (Ez .* Ez);

if nargin < 5
    frequency = 2e6; % Default frequency of 2 MHz
end

charge = 1.602e-19; % Coulombs
mass = 1.46127438e-25; % kg (88 amu)
angFreq = frequency * 2 * pi; 
conversionFactor = 1e6; %mm^2 / m^2 <= ASSUMES UNITS OF MM, CHANGE IF OTHERWISE

coeff = conversionFactor * charge / (4 * mass * angFreq^2);

pseudoPot = coeff * Esquared;
