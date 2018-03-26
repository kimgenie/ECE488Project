%this is the general format of the simulator script
clc; close all; clear all;
constants;
% constants2;

%initializing code

%initial conditions   
X0 = x_0;
U = tau_0;

[tout,qout]=ode45(@(time,x)simulatorofficial(time,x,U,l1,l2,m1,m2,g,c1,c2),[0 0.001],X0);
q = qout(end,[1,2,3,4])';

count = 1;
qSave = zeros(15000,7);

for t=0.001:0.001:15
   qSave(count, 1) = q(1); qSave(count,3) = q(3);
   %check if robot meets requirements
   RobotControllerScript %your script is used here.
   [tout,qout] = ode45(@(time,x)simulatorofficial(time,x,U,l1,l2,m1,m2,g,c1,c2),[t t+0.001],qout(end,:));
%    q = qout(end,[1,3])';
   q = qout(end,[1,2,3,4])';
   count = count + 1;
end

visualize([m1 m2 l1 l2 c1 c2],[0.001:0.001:15]',qSave(:,1),qSave(:,3),'test.gif');
