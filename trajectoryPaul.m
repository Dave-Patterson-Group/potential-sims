function [trajectory,simTimes,amps] = trajectoryPaul(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultFarLeftDC resultLeftDC resultMiddleDC resultRightDC resultFarRightDC resultRF]

RFfreq = 2e6; % Hz
angFreq = 2 * pi * RFfreq;

syms t;
symAmps(t) = [60, 60, 0, 60, 60, 100*cos(angFreq*t)]; % <== Change Voltages here
% symAmps(t) = [60, 60, heaviside(t-T/10)*60*(t-T/10)/(T/2 - T/10)*(1-heaviside(t-T/2))+60*heaviside(t-T/2), 60*(1-heaviside(t-T/10))+60*(1-(t-T/10)/(T/2 - T/10))*heaviside(t-T/10)*(1-heaviside(t-T/2)), 60, 100*cos(angFreq*t)];

[trajectory,simTimes,amps] = evolveIon(y0,T,m,results,symAmps);

figure(1);
showModel = createpde();
importGeometry(showModel,'STLs/PaulShow.stl');
pdegplot(showModel);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-5 90]);
ylim([-15 15]);
zlim([-15 15]);
view(20,5)

figure(2);
plot(simTimes,amps(:,1));
hold on;
plot(simTimes,amps(:,2));
plot(simTimes,amps(:,3));
plot(simTimes,amps(:,4));
plot(simTimes,amps(:,5));
plot(simTimes,amps(:,6));
xlabel('Time (s)');
ylabel('Voltage');
title('Voltages on Electrodes');
legend('Far Left DC','Left DC','Center DC','Right DC','Far Right DC','RF Rods');

