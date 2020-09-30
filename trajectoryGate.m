function [trajectory,simTimes,amps] = trajectoryGate(results,y0,T,m)
 % y0 = [ x y z vx vy vz], enter in mm
 % results = [resultDCLeft, resultDCRight];
offTime = 1.0e-6;
onTime = 3.0e-6;
syms t;
symAmps(t) = [20*(1-heaviside(t-offTime)+heaviside(t-onTime)) -20*(1-heaviside(t-offTime)+heaviside(t-onTime))]; 

[trajectory,simTimes,amps] = evolveIon(y0,T,m,results,symAmps);

figure(1);
showModel = createpde();
importGeometry(showModel,'STLs/Gate.stl');
pdegplot(showModel,'FaceAlpha',0.15);
hold on
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3));
xlim([-20 20]);
ylim([-20 20]);
zlim([-16 21]);
view(90,0)
if trajectory(end,3) > 20.7
    fprintf('Passed through gate. \n');
else
    fprintf('Blocked by gate. \n');
end

figure(2);
plot(simTimes,amps(:,1));
hold on;
plot(simTimes,amps(:,2));
xlabel('Time (s)');
ylabel('Voltage');
title('Voltages on Electrodes');
legend('Left plate','Right plate');
