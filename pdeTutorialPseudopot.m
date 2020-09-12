function [result,model] = pdeTutorialPseudopot()

model = createpde();
importGeometry(model,'STLs/CylindricalQuadrupole.stl'); 


figure(1);
pdegplot(model,'FaceLabels','on','FaceAlpha',0.15);
xlabel('x');
ylabel('y');
zlabel('z');
title('Geometry of system');

%Faces: 
%  Outer Boundaries: 1:6
%  Electrode at (x,y) = (-2,-2): 7:16
%  Electrode at (x,y) = (-2,2): 17:26
%  Electrode at (x,y) = (2,2): 27:36
%  Electrode at (x,y) = (2,-2): 37:46


applyBoundaryCondition(model,'dirichlet','face',[7:16, 27:36],'u',0); % Ground Electrodes
applyBoundaryCondition(model,'dirichlet','face',[17:26, 37:46],'u',150); % RF Electrodes
applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Outer boundaries


specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(model,'hmax',0.5,'hmin',0.1);

result = solvepde(model);

[X,Y,Z] = meshgrid(-5:0.1:5,-5:0.1:5,0);
V = interpolateSolution(result,X,Y,Z);
V = reshape(V,size(X));
x = reshape(X,[101,101]);
y = reshape(Y,[101,101]);
v = reshape(V,size(x));
figure(2);
surf(x,y,v);
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('True Instantaneous Potential (V)');


Vpseudo = calcPseudoPot(result,X,Y,Z);
Vpseudo = reshape(Vpseudo,size(X));
vpseudo = reshape(Vpseudo,size(x));
figure(3);
surf(x,y,vpseudo);
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('RF pseudopotential (V)');
end
