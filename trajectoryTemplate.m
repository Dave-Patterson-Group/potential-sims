function [trajectory,simTimes,amps] = trajectoryTemplate(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultElectrode1 ... resultElectrodeN]
 % All should be at 1 V amplitude

%Define whatever constants you need here, such as RFfreq
syms t;
symAmps(t) = [voltageElectrode1(t), voltageElectrode2(t), voltageElectrodeN(t)]; % <== Set Voltages here

[trajectory,simTimes,amps] = evolveIon(y0,T,m,results,symAmps);

figure(1);
showModel = createpde();
importGeometry(showModel,'STLs/TemplateShow.stl');
pdegplot(showModel);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
%Add whatever automatic viewing limits you want with view(), xlim(),
%ylim(), zlim(), and camroll()

figure(2);
plot(simTimes,amps(:,1));
hold on;
plot(simTimes,amps(:,2));
plot(simTimes,amps(:,3));
xlabel('Time (s)');
ylabel('Voltage');
title('Voltages on Electrodes');
legend('Electrode 1','Electrode 2','Electrode N');


