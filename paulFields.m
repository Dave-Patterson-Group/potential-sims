function result = paulFields(i,v)
if nargin < 2
    v = 1;
end

model = createpde();
importGeometry(model,'STLs/Paul.stl');

% figure;
% pdegplot(model,'FaceLabels','on','FaceAlpha',0.15);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');

if i == 1
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',v); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 2
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',v); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 3
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',v); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 4
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',v); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
elseif i == 5
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',v); % Far Right DC
elseif i == 6
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[22:33, 34:45],'u',v); % RF

    applyBoundaryCondition(model,'dirichlet','face',[19:21, 46:48],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[7:9, 49:51],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[10:12, 52:54],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 55:57],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 58:60],'u',0); % Far Right DC
end

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(model,'hmax',0.7);
result = solvepde(model);

end

% FinalPaul Faces: 60
%   Outer Boundaries: 1:6
%   Lower RF: 22:33  
%   Upper RF: 34:45
%   DC layout:
%
%   =======     =======     =======     =======     =======
%   =19:21=     = 7:9 =     =10:12=     =16:18=     =13:15=
%   =======     =======     =======     =======     =======
%
%
%   =======     =======     =======     =======     =======
%   =46:48=     =49:51=     =52:54=     =55:57=     =58:60=
%   =======     =======     =======     =======     =======
%     ^           ^           ^           ^           ^
%     |           |           |           |           |
%    i=1         i=2         i=3         i=4         i=5
%
%   2 RF rods (not shown): i=6
%
%       Looking at the model from view(0,0)




