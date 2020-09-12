function [trajectory,simTimes,amps] = trajectoryTOFDetector(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultAccel, resultEinzel, resultDetector]
accelTime = 3.4e-6;

syms t;
symAmps(t) = [90*heaviside(t-accelTime), 24.3, -2000]; % <== Change Voltages here

[trajectory,simTimes,amps] = evolveIon(y0,T,m,results,symAmps);

showModel = createpde();
importGeometry(showModel,'STLs/TOFDetectorShow.stl');
pdegplot(showModel,'FaceAlpha',0.1);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-25 25]);
ylim([-25 25]);
zlim([-50 420]);
view(0,0)
camroll(-90)

figure(2);
plot(simTimes,amps(:,1));
hold on;
plot(simTimes,amps(:,2));
plot(simTimes,amps(:,3));
xlabel('Time (s)');
ylabel('Voltage');
title('Voltages on Electrodes');
legend('Acceleration Electrode','Einzel Lens','Detector');

