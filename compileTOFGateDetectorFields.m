function resultsTOFGateDetector = compileTOFGateDetectorFields()
% Runtime: ~ 3 mins

% results = [resultAccel, resultEinzel, resultDetector, resultGateTop, resultGateBottom]

vAccel = 1;
vEinzel = 1;
vDetector = 1;
vGateTop = 1;
vGateBottom = 1;


modelAccel = createpde();
importGeometry(modelAccel,'STLs/TOFaccel.stl');

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

%Nonzero voltages
applyBoundaryCondition(modelAccel,'dirichlet','face',22,'u',vAccel); % Back electrode
applyBoundaryCondition(modelAccel,'dirichlet','face',9:11,'u',0); % B electrode


%Ground
applyBoundaryCondition(modelAccel,'dirichlet','face',[13:15, 17, 3, 5, 6, 2, 4, 8],'u',0); % A & Hex, C, Tube, Pinhole, and D

%Insulator
applyBoundaryCondition(modelAccel,'neumann','face',18:20,'q',0,'g',0);


specifyCoefficients(modelAccel,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelAccel,'hmax',1.0);
resultAccel = solvepde(modelAccel);

fprintf('Completed acceleration electrode (1/5) \n');

%------------------------------------------------------------------------------------------%

modelEinzel = createpde();
importGeometry(modelEinzel,'STLs/TOFaccel.stl');

%Nonzero voltages
applyBoundaryCondition(modelEinzel,'dirichlet','face',22,'u',0); % Back electrode
applyBoundaryCondition(modelEinzel,'dirichlet','face',9:11,'u',vEinzel); % B electrode


%Ground
applyBoundaryCondition(modelEinzel,'dirichlet','face',[13:15, 17, 3, 5, 6, 2, 4, 8],'u',0); 

%Insulator
applyBoundaryCondition(modelEinzel,'neumann','face',18:20,'q',0,'g',0);


specifyCoefficients(modelEinzel,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelEinzel,'hmax',1.0);
resultEinzel = solvepde(modelEinzel);

fprintf('Completed einzel lens (2/5) \n');

%==============================================================================================================%


modelDet = createpde();
importGeometry(modelDet,'STLs/TOFGateDetectorOffset365pt5.stl');

% figure(4);
% pdegplot(modelDet,'FaceLabels','on','FaceAlpha',0.1);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');
% xlim([-24 24]);
% ylim([-24 24]);
% zlim([-10 60]);
% view(90,0);



%Nonzero voltages
applyBoundaryCondition(modelDet,'dirichlet','face',[5,7,9,11,13,15],'u',vDetector); % Detector
applyBoundaryCondition(modelDet,'dirichlet','face',26:31,'u',0); % Top Gate electrode
applyBoundaryCondition(modelDet,'dirichlet','face',20:25,'u',0); % Bottom Gate electrode


%Ground
applyBoundaryCondition(modelDet,'dirichlet','face',[17,18, 10,12,14, 2,4,6],'u',0); 


specifyCoefficients(modelDet,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelDet,'hmax',0.85);
resultDetector = solvepde(modelDet);

fprintf('Completed detector electrode (3/5) \n');

%------------------------------------------------------------------------------------------%

%Top if you view(90,0) and camroll(-90) to get a side view
modelGateTop = createpde();
importGeometry(modelGateTop,'STLs/TOFGateDetectorOffset365pt5.stl');

%Nonzero voltages
applyBoundaryCondition(modelGateTop,'dirichlet','face',[5,7,9,11,13,15],'u',0); % Detector
applyBoundaryCondition(modelGateTop,'dirichlet','face',26:31,'u',vGateTop); % Top Gate Electrode
applyBoundaryCondition(modelGateTop,'dirichlet','face',20:25,'u',0); % Bottom Gate Electrode

%Ground
applyBoundaryCondition(modelGateTop,'dirichlet','face',[17,18, 10,12,14, 2,4,6],'u',0); 


specifyCoefficients(modelGateTop,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelGateTop,'hmax',0.85);
resultGateTop = solvepde(modelGateTop);

fprintf('Completed top gate electrode (4/5) \n');

%------------------------------------------------------------------------------------------%

modelGateBottom = createpde();
importGeometry(modelGateBottom,'STLs/TOFGateDetectorOffset365pt5.stl');

%Nonzero voltages
applyBoundaryCondition(modelGateBottom,'dirichlet','face',[5,7,9,11,13,15],'u',0); % Detector
applyBoundaryCondition(modelGateBottom,'dirichlet','face',26:31,'u',0); % Top Gate electrode
applyBoundaryCondition(modelGateBottom,'dirichlet','face',20:25,'u',vGateBottom); % Bottom Gate electrode

%Ground
applyBoundaryCondition(modelGateBottom,'dirichlet','face',[17,18, 10,12,14, 2,4,6],'u',0); 


specifyCoefficients(modelGateBottom,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(modelGateBottom,'hmax',0.85);
resultGateBottom = solvepde(modelGateBottom);

fprintf('Completed bottom gate electrode (5/5) \n');

resultsTOFGateDetector = [resultAccel, resultEinzel, resultDetector, resultGateTop, resultGateBottom];

end


%TOFaccel.stl
% Faces:        
%   

%        ===  ===
%        ===  ===
%          =  =
%          =  =
%          =  =     Drift Tube: 2,4,8
%          =  =
%          =  =
%          =  =
%        ===  ===
%        ===  ===

%        ===  ===   Ground C: 3,5,6

%        ===  ===   V_2 B: 9:11
%        ===  ===

%        ===  ===   Ground A & Mesh: 13:15,17 
%        ===  ===
%                   
%        ===  ===
%        =      =   Insulator: 18:20
%        =      =
%        ===  ===
%                       
%        ========
%        ========   Back Electrode: 22
%        ========

%TOFGateDetectorOffset365pt5.stl


%           ==
%           ==      Detector: 5,7,9,11,13,15
%        ===  ===   
%        ===  ===

%        ===  ===   Pinhole 2: 2,4,6
%        ===  ===

%        ========   Gate Top: 26:31
%        ========   Gate Bottom: 20:25

%        ===  ===   Pinhole 1: 10,12,14

%        ===  ===
%        ===  ===   Drift Tube End: 17,18
%          =  =
