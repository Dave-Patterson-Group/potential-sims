function resultsGate = compileGateFields()
% Runtime: ~ 3 mins
%Faces: 
%   Outer Boundaries: 1:6,10
%   Pinhole 1: 23:26
%   Left plate electrode: 11:16
%   Right plate electrode: 17:22
%   Pinhole 2: 7:9

modelDCLeft = createpde();
importGeometry(modelDCLeft,'STLs/Gate.stl');

% figure(1);
% pdegplot(modelDCLeft,'FaceLabels','on','FaceAlpha',0.15);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');

applyBoundaryCondition(modelDCLeft,'dirichlet','face',[23:26, 7:9],'u',0); % Pinholes
applyBoundaryCondition(modelDCLeft,'dirichlet','face',11:16,'u',1); % Left DC
applyBoundaryCondition(modelDCLeft,'dirichlet','face',17:22,'u',0); % Right DC

specifyCoefficients(modelDCLeft,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDCLeft,'hmax',1.0);
resultDCLeft = solvepde(modelDCLeft);

fprintf('Completed left plate electrode (1/2) \n');


modelDCRight = createpde();
importGeometry(modelDCRight,'STLs/Gate.stl');

applyBoundaryCondition(modelDCRight,'dirichlet','face',[23:26, 7:9],'u',0); % Pinholes
applyBoundaryCondition(modelDCRight,'dirichlet','face',11:16,'u',0); % Left DC
applyBoundaryCondition(modelDCRight,'dirichlet','face',17:22,'u',1); % Right DC


specifyCoefficients(modelDCRight,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDCRight,'hmax',1.0);
resultDCRight = solvepde(modelDCRight);

fprintf('Completed right plate electrode (2/2) \n');


resultsGate = [resultDCLeft, resultDCRight];
end
