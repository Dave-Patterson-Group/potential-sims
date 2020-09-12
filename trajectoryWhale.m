function [trajectory,simTimes,amps] = trajectoryWhale(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultDCTop, resultDCBottom, resultRF];
RFfreq = 2e6; % Hz
angFreq = 2 * pi * RFfreq;

syms t;
% symAmps(t) = [0.5 0.5 150*cos(angFreq * t)]; % <== Change Voltages here
Vmax = 20;
symAmps(t) = [Vmax*(t/T) Vmax*(t/T) 150*cos(angFreq * t)]; % <== Change Voltages here

[trajectory,simTimes,amps] = evolveIon(y0,T,m,results,symAmps);

figure(1);
showModel = createpde();
importGeometry(showModel,'STLs/WhaleShow.stl');
pdegplot(showModel);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-10 10]);
ylim([-10 10]);
zlim([-7.5 7.5]);
view(0,10)

figure(2);
plot(simTimes,amps(:,1));
hold on;
plot(simTimes,amps(:,2));
plot(simTimes,amps(:,3));
xlabel('Time (s)');
ylabel('Voltage');
title('Voltages on Electrodes');
legend('Top DC','Bottom DC','RF');
