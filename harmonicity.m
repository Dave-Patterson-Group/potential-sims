function [approxFrequency,SSR] = harmonicity(x,pot,cutoffV,prefix)
%If you input a 1D potential which is roughly harmonic and roughly
%centered, this function takes that potential, finds the center and sets it to zero,
%and cuts off anything higher than the cutoffV above the center. So, that gives you
%a symmetric potential where the center is 0. It then fits a harmonic potential,
%prints out the frequency of that harmonic, and returns the sum of the
%squared residuals as a measure of how close the original potential is to
%harmonic, and plots the original pot and the approximation
if nargin < 3
    cutoffV = 0.1;
end
if nargin < 4
    prefix = "";
end

[minimumV,minIndex] = min(pot);
renormPot = pot - minimumV;

potMinusCutoff = abs(renormPot - cutoffV);

[~,cutoffIndex] = min(potMinusCutoff);

delta = abs(minIndex - cutoffIndex) - 5;

iStart = minIndex - delta;
iEnd = minIndex + delta;

xSym = x(iStart:iEnd);
potSym = renormPot(iStart:iEnd);

% All of the above just centers the potential and sets the minimum to 0

p = polyfit(xSym,potSym,2); % Calculating coefficients of a best-fit parabola

k = 2 * p(1) * 1e6 * 1.602e-19;
m = 1.66053907e-27 * 88; % Mass of strontium
omega = sqrt( k / m );  

approxFrequency = omega / (2*pi); % Calculating the secular frequency

approxHarmonic = polyval(p,xSym); % Creating best-fit parabola

residuals = approxHarmonic - potSym;
resSquared = residuals .^2;
SSR = sum(resSquared);  % Calculating sum of square residuals

figure;
plot(xSym,potSym);
hold on
plot(xSym,approxHarmonic);
legend('Actual Potential','Best-fit Harmonic');
freqString = sprintf('Frequency: %0.3f kHz',approxFrequency*1e-3);
SSRString = sprintf('Sum of Squared Residuals: %0.5e',SSR);
titleString = prefix + freqString + "\n" + SSRString;
titleString = compose(titleString);
title(titleString);
%Plotting everything



