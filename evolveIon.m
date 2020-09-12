function [trajectory,simTimes,amps] = evolveIon(y0,T,m,results,symAmps)
fprintf('Preallocating arrays... \n');
%Initializing important variables and arrays
y = y0 * 1e-3;
h = 1e-9;
simTimes = 0:h:T;
numTimes = length(simTimes);
trajectory = zeros(numTimes,6);
trajectory(1,:) = y;
t = 0;
totalCollisions = 0;

%The following predetermines what the values of the amplitudes on the
%electrodes should be for each point in time. I tried just calculating
%while it was looping, but that ended up being MUCH slower
ampsRK14Cell = symAmps([simTimes,simTimes(end) + h]);
ampsRK23Cell = symAmps([simTimes + h/2,simTimes(end) + 3*h/2]);
ampsRK14 = zeros(numTimes + 1,length(results));
ampsRK23 = zeros(numTimes + 1,length(results));
for j = 1:length(ampsRK14Cell)
    ampsRK14(:,j) = double(ampsRK14Cell{j});
    ampsRK23(:,j) = double(ampsRK23Cell{j});
end

%This for loop loops through all times and does the numerical integration
for i = 2:numTimes
    [newy,newt,newCollision] = rkStep(y,t,m,results,ampsRK14(i,:),ampsRK23(i,:),ampsRK14(i+1,:),h,totalCollisions);
    y = newy;
    t = newt;
    trajectory(i,:) = y;
    if newCollision > 0
        totalCollisions = totalCollisions + newCollision;
    else
        totalCollisions = 0;
    end
    if mod(i-1,5000) == 0
        fprintf('Simulated Time: %0.1f microseconds \n',t*1e6);
    end
end
amps = ampsRK14(1:end-1,:);
trajectory = trajectory * 1e3; %Converting back to mm
% 