function result = paulFullLoadingFields(i)

model = createpde();
importGeometry(model,'STLs/FullLoadingPaulOffset446.stl');


% figure;
% pdegplot(model,'FaceLabels','on','FaceAlpha',0.15);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% title('Geometry of system');

if i == 1
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',1); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 2
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',1); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 3
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',1); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 4
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',1); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC
elseif i == 5
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',0); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',1); % Far Right DC
elseif i == 6
    applyBoundaryCondition(model,'dirichlet','face',1:6,'u',0); % Ground Boundaries
    
    applyBoundaryCondition(model,'dirichlet','face',[34:36, 19:21],'u',1); % RF

    applyBoundaryCondition(model,'dirichlet','face',[7:9, 10:12, 28:30, 31:33],'u',0); % Far left DC
    applyBoundaryCondition(model,'dirichlet','face',[13:15, 46:48],'u',0); % Left DC
    applyBoundaryCondition(model,'dirichlet','face',[25:27, 43:45],'u',0); % Middle DC
    applyBoundaryCondition(model,'dirichlet','face',[22:24, 40:42],'u',0); % Right DC
    applyBoundaryCondition(model,'dirichlet','face',[16:18, 37:39],'u',0); % Far Right DC

end

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0);
%Laplace's equation: https://www.mathworks.com/help/pde/ug/equations-you-can-solve.html

generateMesh(model,'hmax',0.8);
result = solvepde(model);

end
