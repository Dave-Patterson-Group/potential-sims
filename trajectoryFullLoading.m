function [trajectory,simTimes,amps] = trajectoryFullLoading(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultAccel, resultEinzel, resultGateTop, resultGateBottom, resultFarLeft, resultLeft, resultMiddle, resultRight, resultFarRight, resultRF]
RFfreq = 2e6;
accelTime = 3.4e-6;
gateOffTime = 34.325e-6;
gateOnTime = 34.85e-6;
paulOffTime = 42.0e-6;
paulOnTime = 52.0e-6;
angFreq = 2 * pi * RFfreq;
syms t;
symAmpsAccel(t) = [90*heaviside(t-accelTime), 24.3, 0, 0, 0, 0, 0, 0, 0, 0,]; % <== Change Voltages here
symAmpsGate(t) = [0, 0, 20*(1 - heaviside(t-gateOffTime) + heaviside(t-gateOnTime)), -20*(1 - heaviside(t-gateOffTime) + heaviside(t-gateOnTime)), 0, 0, 0, 0, 0, 0,];
symAmpsPaulLoading(t) = [0, 0, 0, 0, 88*(1 - heaviside(t-paulOffTime) + heaviside(t-paulOnTime)), 0, 60, 0, 60, 100*cos(angFreq * t)];
symAmpsCell = {symAmpsAccel,symAmpsGate,symAmpsPaulLoading};
zOffsetArray = [0 365.5 446];
zSwitchArray = [367 401];
[trajectory,simTimes,amps] = evolveIonZDependent(y0,T,m,results,symAmpsCell,zOffsetArray,zSwitchArray);

figure(1)
showModel = createpde();
importGeometry(showModel,'STLs/FullLoadingShow.stl');
pdegplot(showModel,'FaceAlpha',0.1);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-25 25]);
ylim([-25 25]);
zlim([365 550]);
view(90,0)
camroll(-90)

figure(2);
plot(simTimes,amps(:,1));
hold on;
plot(simTimes,amps(:,2));
plot(simTimes,amps(:,3));
plot(simTimes,amps(:,4));
plot(simTimes,amps(:,5));
plot(simTimes,amps(:,6));
plot(simTimes,amps(:,7));
plot(simTimes,amps(:,8));
plot(simTimes,amps(:,9));
plot(simTimes,amps(:,10));
xlabel('Time (s)');
ylabel('Voltage');
title('Voltages on Electrodes');
legend('Acceleration','Einzel Lens','Gate Top','Gate Bottom','Far Left Paul','Left Paul','Center Paul','Right Paul','Far Right Paul','RF Paul');

