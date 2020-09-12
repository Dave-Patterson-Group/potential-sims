function [newy,newt,newCollision] = rkStep(y,t,m,results,amps1,amps23,amps4,h,totalCollisions)
%Performs Runge-Kutta 4 numerical integration:
[ydotvals1,newCollision1] = ydot(y,m,results,amps1);
k1 = h * ydotvals1;

[ydotvals2,newCollision2] = ydot(y+(k1/2),m,results,amps23);
k2 = h * ydotvals2;

[ydotvals3,newCollision3] = ydot(y+(k2/2),m,results,amps23);
k3 = h * ydotvals3;

[ydotvals4,newCollision4] = ydot(y+k3,m,results,amps4);
k4 = h * ydotvals4;

newy = y + ((k1 + (2*k2) + (2*k3) + k4) /6); %this line is RK4
newt = t + h;
newCollision = (newCollision1 + newCollision2 + newCollision3 + newCollision4) / 4;


if totalCollisions > length(results)*5      % Determines if ion ran into a wall
    newy = y;
    newCollision = 1;
end