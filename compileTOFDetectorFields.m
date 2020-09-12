function resultsTOFDetector = compileTOFDetectorFields()
% Runtime: ~ 3 mins

% results = [resultAccel, resultEinzel, resultDetector]

vAccel = 1;
vEinzel = 1;
vDetector = 1;


modelAccel = createpde();
importGeometry(modelAccel,'STLs/TOFDetector.stl');

% figure(3);
% pdegplot(modelAccel,'FaceLabels','on','FaceAlpha',0.1);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');
% xlim([-24 24]);
% ylim([-24 24]);
% zlim([-30 420]);
% view(40,0);
% camroll(-90);

%Nonzero voltages
applyBoundaryCondition(modelAccel,'dirichlet','face',31,'u',vAccel); % Back electrode
applyBoundaryCondition(modelAccel,'dirichlet','face',11:13,'u',0); % B electrode
applyBoundaryCondition(modelAccel,'dirichlet','face',18:24,'u',0); % Detector


%Ground
applyBoundaryCondition(modelAccel,'dirichlet','face',[15:17, 26, 7:9, 2, 4, 5],'u',0); % A & Hex, C, Tube, Pinhole, and D

%Insulator
applyBoundaryCondition(modelAccel,'neumann','face',27:29,'q',0,'g',0);


specifyCoefficients(modelAccel,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelAccel,'hmax',1.0);
resultAccel = solvepde(modelAccel);

fprintf('Completed acceleration electrode (1/3) \n');


modelEinzel = createpde();
importGeometry(modelEinzel,'STLs/TOFDetector.stl');

%Nonzero voltages
applyBoundaryCondition(modelEinzel,'dirichlet','face',31,'u',0); % Back electrode
applyBoundaryCondition(modelEinzel,'dirichlet','face',11:13,'u',vEinzel); % B electrode
applyBoundaryCondition(modelEinzel,'dirichlet','face',18:24,'u',0); % Detector


%Ground
applyBoundaryCondition(modelEinzel,'dirichlet','face',[15:17, 26, 7:9, 2, 4, 5],'u',0); % A & Hex, C, Tube, Pinhole, and D

%Insulator
applyBoundaryCondition(modelEinzel,'neumann','face',27:29,'q',0,'g',0);


specifyCoefficients(modelEinzel,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelEinzel,'hmax',1.0);
resultEinzel = solvepde(modelEinzel);

fprintf('Completed einzel lens (2/3) \n');


modelDet = createpde();
importGeometry(modelDet,'STLs/TOFDetector.stl');

%Nonzero voltages
applyBoundaryCondition(modelDet,'dirichlet','face',31,'u',0); % Back electrode
applyBoundaryCondition(modelDet,'dirichlet','face',11:13,'u',0); % B electrode
applyBoundaryCondition(modelDet,'dirichlet','face',18:24,'u',vDetector); % Detector


%Ground
applyBoundaryCondition(modelDet,'dirichlet','face',[15:17, 26, 7:9, 2, 4, 5],'u',0); % A & Hex, C, Tube, Pinhole, and D

%Insulator
applyBoundaryCondition(modelDet,'neumann','face',27:29,'q',0,'g',0);


specifyCoefficients(modelDet,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDet,'hmax',1.0);
resultDetector = solvepde(modelDet);

fprintf('Completed detector electrode (3/3) \n');


resultsTOFDetector = [resultAccel, resultEinzel, resultDetector];


end



%TOFDetector.stl
% Faces:        
%   
 
%           ==
%           ==      Detector: 18:24
%        ===  ===   
%        ===  ===

%        ===  ===
%        ===  ===
%          =  =
%          =  =
%          =  =     Drift Tube: 2,4,5
%          =  =
%          =  =
%          =  =
%        ===  ===
%        ===  ===

%        ===  ===   Ground C: 7:9
%        ===  ===

%        ===  ===   V_2 B: 11:13
%        ===  ===

%        ===  ===   Ground A & Mesh: 15:17,26 
%        ===  ===

%        ===  ===
%        =      =   Insulator: 27:29
%        =      =
%        ===  ===
%                       
%        ========
%        ========   Back Electrode: 31
%        ========

