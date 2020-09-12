function paulCalcSecularFreqs(VFarLeft,VLeft,VCenter,VRight,VFarRight,RFamp,RFfreq)
%FYI on my computer, this script takes approximately 5 minutes to run, so
%don't panic if it doesn't finish instantly
%Using this script is extremely simple, just run it with your desired
%voltage, RF amplitude, and RF frequency as indicated by the input
%arguments
if nargin == 0
    VFarLeft = 60;
    VLeft = 60;
    VCenter = 0;
    VRight = 60;
    VFarRight = 60;
    RFamp = 100;
    RFfreq = 2e6;
end

modelDC = createpde();
importGeometry(modelDC,'STLs/Paul.stl');

applyBoundaryCondition(modelDC,'dirichlet','face',1:6,'u',0); % Ground Boundaries

applyBoundaryCondition(modelDC,'dirichlet','face',[22:33, 34:45],'u',0); % RF

applyBoundaryCondition(modelDC,'dirichlet','face',[19:21, 46:48],'u',VFarLeft); % Far left DC
applyBoundaryCondition(modelDC,'dirichlet','face',[7:9, 49:51],'u',VLeft); % Left DC
applyBoundaryCondition(modelDC,'dirichlet','face',[10:12, 52:54],'u',VCenter); % Middle DC
applyBoundaryCondition(modelDC,'dirichlet','face',[16:18, 55:57],'u',VRight); % Right DC
applyBoundaryCondition(modelDC,'dirichlet','face',[13:15, 58:60],'u',VFarRight); % Far Right DC

specifyCoefficients(modelDC,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDC,'hmax',0.7);
resultDC = solvepde(modelDC);



modelRF = createpde();
importGeometry(modelRF,'STLs/Paul.stl');

applyBoundaryCondition(modelRF,'dirichlet','face',1:6,'u',0); % Ground Boundaries

applyBoundaryCondition(modelRF,'dirichlet','face',[22:33, 34:45],'u',RFamp); % RF

applyBoundaryCondition(modelRF,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
applyBoundaryCondition(modelRF,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
applyBoundaryCondition(modelRF,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
applyBoundaryCondition(modelRF,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
applyBoundaryCondition(modelRF,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC

specifyCoefficients(modelRF,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelRF,'hmax',0.7);
resultRF = solvepde(modelRF);



% figure(1);
[Xr,Yr,Zr] = meshgrid(43,-4:0.001:4,0);

Vpseudor = calcPseudoPot(resultRF,Xr,Yr,Zr,RFfreq);
Vpseudor = reshape(Vpseudor,size(Xr));

VDCr = interpolateSolution(resultDC,Xr,Yr,Zr);
VDCr = reshape(VDCr,size(Xr));

Vr = VDCr + Vpseudor;

[RadialFrequency,SSRradial] = harmonicity(Yr,Vr,0.1,"Radial ");



% figure(2);
[Xa,Ya,Za] = meshgrid(30:0.01:55,0,0);

Vpseudoa = calcPseudoPot(resultRF,Xa,Ya,Za,RFfreq);
Vpseudoa = reshape(Vpseudoa,size(Xa));

VDCa = interpolateSolution(resultDC,Xa,Ya,Za);
VDCa = reshape(VDCa,size(Xa));

Va = VDCa + Vpseudoa;

[AxialFrequency,SSRaxial] = harmonicity(Xa,Va,0.1,"Axial ");

