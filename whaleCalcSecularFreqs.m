function whaleCalcSecularFreqs(VDC,RFamp,RFfreq)
%FYI on my computer, this script takes approximately 5 minutes to run, so
%don't panic if it doesn't finish instantly
%This script is very easy to use, just input your desired DC voltage, RF
%amplitude, and RF frequency as indicated by the input arguments above
if nargin == 0
    VDC = 0.5;
    RFamp = 34.75;
    RFfreq = 1.5e6;
end

modelDC = createpde();
importGeometry(modelDC,'STLs/Whale.stl');


applyBoundaryCondition(modelDC,'dirichlet','face',[11:14, 19:22],'u',0); % RF
applyBoundaryCondition(modelDC,'dirichlet','face',[15:18, 23:26],'u',VDC); % DC
applyBoundaryCondition(modelDC,'dirichlet','face',1:10,'u',0); % Outer Boundaries


specifyCoefficients(modelDC,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDC,'hmax',0.6);

resultDC = solvepde(modelDC);

modelRF = createpde();
importGeometry(modelRF,'STLs/Whale.stl');

applyBoundaryCondition(modelRF,'dirichlet','face',[11:14, 19:22],'u',RFamp); % RF
applyBoundaryCondition(modelRF,'dirichlet','face',[15:18, 23:26],'u',0); % DC
applyBoundaryCondition(modelRF,'dirichlet','face',1:10,'u',0); % Outer Boundaries


specifyCoefficients(modelRF,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelRF,'hmax',0.6);

resultRF = solvepde(modelRF);


% figure(1);
[Xr,Yr,Zr] = meshgrid(-5:0.001:5,0,0);

Vpseudor = calcPseudoPot(resultRF,Xr,Yr,Zr,RFfreq);
Vpseudor = reshape(Vpseudor,size(Xr));

VDCr = interpolateSolution(resultDC,Xr,Yr,Zr);
VDCr = reshape(VDCr,size(Xr));

Vr = VDCr + Vpseudor;


[RadialFrequency,SSRradial] = harmonicity(Xr,Vr,0.005,"Radial ");



% figure(2);
[Xa,Ya,Za] = meshgrid(0,0,-2.5:0.001:2.5);
za = reshape(Za,[length(Za),1]);
Vpseudoa = calcPseudoPot(resultRF,Xa,Ya,Za,RFfreq);
Vpseudoa = reshape(Vpseudoa,size(za));

VDCa = interpolateSolution(resultDC,Xa,Ya,Za);
VDCa = reshape(VDCa,size(za));

Va = VDCa + Vpseudoa;

[AxialFrequency,SSRaxial] = harmonicity(za,Va,0.005,"Axial ");



