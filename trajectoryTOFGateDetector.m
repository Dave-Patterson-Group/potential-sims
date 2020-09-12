function [trajectory,simTimes,amps] = trajectoryTOFGateDetector(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultAccel, resultEinzel, resultDetector, resultGateTop, resultGateBottom]
accelTime = 3.4e-6;
gateOffTime = 34.325e-6;
gateOnTime = 34.85e-6;

syms t;
symAmpsAccel(t) = [90*heaviside(t-accelTime), 24.3, 0, 0, 0]; % <== Change Voltages here
symAmpsGateDet(t) = [0, 0, -2000, 20*(1 - heaviside(t-gateOffTime) + heaviside(t-gateOnTime)), -20*(1 - heaviside(t-gateOffTime) + heaviside(t-gateOnTime))];
symAmpsCell = {symAmpsAccel,symAmpsGateDet};
zOffsetArray = [0 365.5];
zSwitchArray = [367];
[trajectory,simTimes,amps] = evolveIonZDependent(y0,T,m,results,symAmpsCell,zOffsetArray,zSwitchArray);

figure(1)
showModel = createpde();
importGeometry(showModel,'STLs/TOFGateDetectorShow.stl');
pdegplot(showModel,'FaceAlpha',0.1);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-25 25]);
ylim([-25 25]);
zlim([-50 420]);
view(90,0)
camroll(-90)

figure(2);
plot(simTimes,amps(:,1));
hold on;
plot(simTimes,amps(:,2));
plot(simTimes,amps(:,3));
plot(simTimes,amps(:,4));
plot(simTimes,amps(:,5));
xlabel('Time (s)');
ylabel('Voltage');
title('Voltages on Electrodes');
legend('Acceleration','Einzel Lens','Detector','Gate Top','Gate Bottom');

