function [result,model] = pdeTutorial()

model = createpde();
importGeometry(model,'STLs/ParallelPlates.stl'); % this string should be whatever the file path is
% If you're using windows, you may need to change the forward slash to a
% backslash, like STLs\ParallelPlates.stl

figure(1);
pdegplot(model,'FaceLabels','on','FaceAlpha',0.15);
xlabel('x');
ylabel('y');
zlabel('z');
title('Geometry of system');

%Faces: 
%  Outer Boundaries: 1:6
%  Upper Electrode: 13:18
%  Lower Electrode: 7:12

applyBoundaryCondition(model,'dirichlet','face',7:12,'u',100); % Lower Electrode
applyBoundaryCondition(model,'dirichlet','face',13:18,'u',-100); % Upper Electrode
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
zlabel('Potential (V)');


[Xax,Yax,Zax] = meshgrid(0,0,-5:0.1:5);
Vax = interpolateSolution(result,Xax,Yax,Zax);
Vax = reshape(Vax,size(Zax));
zax = reshape(Zax,[101, 1]);
vax = reshape(Vax,size(zax));
figure(3);
plot(zax,vax);
xlabel('z (mm)');
ylabel('Potential (V)');

end
