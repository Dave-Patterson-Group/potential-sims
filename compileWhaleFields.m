function resultsWhale = compileWhaleFields()
% Runtime: ~ 3 mins

modelRF = createpde();
importGeometry(modelRF,'STLs/Whale.stl');

% figure(1);
% pdegplot(modelRF,'FaceLabels','on','FaceAlpha',0.15);
% xlabel('x');
% ylabel('y');
% zlabel('z');;
% title('Geometry of system');

%Faces: 
%   Outer Boundaries: 1:10
%   Bottom RF Electrode: 11:14
%   Bottom DC Electrode: 15:18
%   Top RF Electrode: 19:22
%   Top DC Electrode: 23:26


applyBoundaryCondition(modelRF,'dirichlet','face',[11:14, 19:22],'u',1); % RF
applyBoundaryCondition(modelRF,'dirichlet','face',[15:18, 23:26],'u',0); % DC
applyBoundaryCondition(modelRF,'dirichlet','face',1:10,'u',0); % Outer Boundaries


specifyCoefficients(modelRF,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelRF,'hmax',0.6);

resultRF = solvepde(modelRF);

fprintf('Completed RF electrodes (1/3) \n');


modelDCTop = createpde();
importGeometry(modelDCTop,'STLs/Whale.stl');


applyBoundaryCondition(modelDCTop,'dirichlet','face',[11:14, 19:22],'u',0); % RF
applyBoundaryCondition(modelDCTop,'dirichlet','face',23:26,'u',1); % Top DC
applyBoundaryCondition(modelDCTop,'dirichlet','face',15:18,'u',0); % Bottom DC
applyBoundaryCondition(modelDCTop,'dirichlet','face',1:10,'u',0); % Outer Boundaries


specifyCoefficients(modelDCTop,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDCTop,'hmax',0.6);
resultDCTop = solvepde(modelDCTop);

fprintf('Completed top DC electrode (2/3) \n');


modelDCBottom = createpde();
importGeometry(modelDCBottom,'STLs/Whale.stl');


applyBoundaryCondition(modelDCBottom,'dirichlet','face',[11:14, 19:22],'u',0); % RF
applyBoundaryCondition(modelDCBottom,'dirichlet','face',23:26,'u',0); % Top DC
applyBoundaryCondition(modelDCBottom,'dirichlet','face',15:18,'u',1); % Bottom DC
applyBoundaryCondition(modelDCBottom,'dirichlet','face',1:10,'u',0); % Outer Boundaries


specifyCoefficients(modelDCBottom,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDCBottom,'hmax',0.6);
resultDCBottom = solvepde(modelDCBottom);

fprintf('Completed bottom DC electrode (3/3) \n');


resultsWhale = [resultDCTop, resultDCBottom, resultRF];
end
