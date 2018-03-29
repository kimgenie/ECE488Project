%this is the general format of the simulator script
clc; close all; clear all;
constants;
% constants2;

%initializing code

%initial conditions   
X0 = x_0;
U = tau_0;

[tout,qout]=ode45(@(time,x)simulatorofficial(time,x,U,l1,l2,m1,m2,g,c1,c2),[0 0.001],X0);
% q = qout(end,[1,2,3,4])';
q = qout(end,[1,3])';

count = 1;
qSave = zeros(10000,6);

for t=0.001:0.001:10
   qSave(count, 1) = q(1); qSave(count,2) = q(2);
   qSave(count, 3) = qHat(1); qSave(count,4) = qHat(3);
   qSave(count, 5) = q_desired(1); qSave(count,6) = q_desired(2);
   %check if robot meets requirements
   RobotControllerScript %your script is used here.
   [tout,qout] = ode45(@(time,x)simulatorofficial(time,x,U,l1,l2,m1,m2,g,c1,c2),[t t+0.001],qout(end,:));
   q = qout(end,[1,3])' + [deg2rad(1/3)*rand; deg2rad(1/3)*rand];
%     q = qout(end,[1,3])';
%    q = qout(end,[1,2,3,4])';
   count = count + 1;
end
% tSpan = [0.001:0.001:5]';
% figure(1);
% plot(tSpan,qSave(:,1),tSpan,qSave(:,5));
% figure(2);
% plot(tSpan,qSave(:,2),tSpan,qSave(:,6));
visualize([m1 m2 l1 l2 c1 c2],[0.001:0.001:10]',qSave(:,1),qSave(:,2),'test.gif');
