function [trajectory,simTimes,amps] = evolveIonZDependent(y0,T,m,results,symAmpsCell,zOffsetArray,zSwitchArray)
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
%while it was looping, but that ended up being MUCH slower. This version
%calculates it for multiple versions, for the different symAmps arrays
ampsRK14 = zeros(numTimes + 1,length(results),length(zOffsetArray));
ampsRK23 = zeros(numTimes + 1,length(results),length(zOffsetArray));
for k = 1:length(zOffsetArray)
    symAmps = symAmpsCell{k};
    ampsRK14Cell = symAmps([simTimes,simTimes(end) + h]);
    ampsRK23Cell = symAmps([simTimes + h/2,simTimes(end) + 3*h/2]);
    for j = 1:length(ampsRK14Cell)
        ampsRK14(:,j,k) = double(ampsRK14Cell{j});
        ampsRK23(:,j,k) = double(ampsRK23Cell{j});
    end
end
%Performing the numerical integration
for i = 2:numTimes
    currentZ = y(3)*1e3;
    k = 1;
    while (k < length(zOffsetArray)) && (currentZ >= zSwitchArray(k))
        k = k+1;
    end
    yOffset = y;
    yOffset(3) = yOffset(3) - zOffsetArray(k)*1e-3;
    [newy,newt,newCollision] = rkStep(yOffset,t,m,results,ampsRK14(i,:,k),ampsRK23(i,:,k),ampsRK14(i+1,:,k),h,totalCollisions);
    newy(3) = newy(3) + zOffsetArray(k)*1e-3;
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
amps = zeros(numTimes,length(results));
for l = 1:length(zOffsetArray)
    if ~isnan(ampsRK14(1:end-1,:,l))
        amps = amps + ampsRK14(1:end-1,:,l); %Combining all amplitudes into one neat package for plotting
    end
end
trajectory = trajectory * 1e3; %Converting back to mm
% 
