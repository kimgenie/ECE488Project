%put constant values in this file%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%You NEED these constants%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c1 = 8;               %link 1 friction coeffecient
c2 = 8;               %link 2 friction coeffecient
l1 = 0.5;               %link 1 length
% l2=1;                 %link 2 length

dens1 = 0.85; %kg/m
dens2 = 0.85; %kg/m

m1 = dens1*l1;        %link 1 mass
m2 = 0.75 - m1;       %link 2 mass
l2 = m2/dens2;
g = 3.7;              %acceleration due to gravity m/s^2 on mars

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Declare all your variables here, prefix with my_ 

% Locations of various target points
Apos = [0.1; 0.2];
Bpos = [0.2; 0.2];
Cpos = [0.2; 0.1];
Dpos = [0.1; 0.1];

q1 = kinematics(Apos,l1, l2);
q2 = kinematics(0.5*(Apos+Bpos),l1,l2);
q3 = kinematics(Bpos,l1, l2);
q4 = kinematics(0.5*(Bpos+Cpos),l1,l2);
q5 = kinematics(Cpos,l1, l2);
q6 = kinematics(0.5*(Cpos+Dpos),l1,l2);
q7 = kinematics(Dpos,l1, l2);

qRef = [q1(1),q2(1),q3(1),q4(1),q5(1),q6(1),q7(1);
        zeros(1,7);
        q1(2),q2(2),q3(2),q4(2),q5(2),q6(2),q7(2);
        zeros(1,7)];

[A1,B1,C1,D1,Tau1] = getSS(qRef(:,1),l1,l2,m1,m2,g,c1,c2);
[A2,B2,C2,D2,Tau2] = getSS(qRef(:,2),l1,l2,m1,m2,g,c1,c2);
[A3,B3,C3,D3,Tau3] = getSS(qRef(:,3),l1,l2,m1,m2,g,c1,c2);
[A4,B4,C4,D4,Tau4] = getSS(qRef(:,4),l1,l2,m1,m2,g,c1,c2);
[A5,B5,C5,D5,Tau5] = getSS(qRef(:,5),l1,l2,m1,m2,g,c1,c2);
[A6,B6,C6,D6,Tau6] = getSS(qRef(:,6),l1,l2,m1,m2,g,c1,c2);
[A7,B7,C7,D7,Tau7] = getSS(qRef(:,7),l1,l2,m1,m2,g,c1,c2);

tauOP = [Tau1,Tau2,Tau3,Tau4,Tau5,Tau6,Tau7];

kalmanQ = 0.001*eye(4); kalmanR = eye(2);

ctrlPoles = [-100, -105, -110, -115]; estPoles = [-200, -210, -220, -230];
K1 = place(A1,B1,ctrlPoles); F1 = place(A1',C1', estPoles)';
K2 = place(A2,B2,ctrlPoles); F2 = place(A2',C2', estPoles)';
K3 = place(A3,B3,ctrlPoles); F3 = place(A3',C3', estPoles)';
K4 = place(A4,B4,ctrlPoles); F4 = place(A4',C4', estPoles)';
K5 = place(A5,B5,ctrlPoles); F5 = place(A5',C5', estPoles)';
K6 = place(A6,B6,ctrlPoles); F6 = place(A7',C6', estPoles)';
K7 = place(A7,B7,ctrlPoles); F7 = place(A7',C7', estPoles)';

% K1 = place(A1,B1,ctrlPoles); F1 = lqr(A1',C1',kalmanQ,kalmanR)';
% K2 = place(A2,B2,ctrlPoles); F2 = lqr(A2',C2',kalmanQ,kalmanR)';
% K3 = place(A3,B3,ctrlPoles); F3 = lqr(A3',C3',kalmanQ,kalmanR)';
% K4 = place(A4,B4,ctrlPoles); F4 = lqr(A4',C4',kalmanQ,kalmanR)';
% K5 = place(A5,B5,ctrlPoles); F5 = lqr(A5',C5',kalmanQ,kalmanR)';
% K6 = place(A6,B6,ctrlPoles); F6 = lqr(A6',C6',kalmanQ,kalmanR)';
% K7 = place(A7,B7,ctrlPoles); F7 = lqr(A7',C7',kalmanQ,kalmanR)';
q_desired = [0;0];

qRef = [q1(1),q2(1),q3(1),q4(1),q5(1),q6(1),q7(1);
        zeros(1,7);
        q1(2),q2(2),q3(2),q4(2),q5(2),q6(2),q7(2);
        zeros(1,7)];

x_0 = qRef(:,1);     %x_0=[q1_0,q1dot_0,q2_0,q2dot_0] initial conditions for the robot
tau_0 = Tau1;       %initial torque
tau = tau_0;

% x_0 = [qC(1),0,qC(2),0]';     %x_0=[q1_0,q1dot_0,q2_0,q2dot_0] initial conditions for the robot
% tau_0 = Ctau;       %initial torque

%Feel Free to add to or remove these constants%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
my_time=0;

qCount = 1;
qHat = [q1(1), 0, q1(2), 0]';

function qTarget = kinematics(target,l1, l2)
    syms ang1 ang2;
    x = target(1) == l1*cos(ang1) + l2*cos(ang1+ang2);
    y = target(2) == l1*sin(ang1) + l2*sin(ang1+ang2);
    P = solve([x y],[ang1 ang2]);
    qTarget = double([P.ang1(1); P.ang2(1)]);
    % display(l1*cos(q1Target) + l2*cos(q1Target+q2Target));
    % display(l1*sin(q1Target) + l2*sin(q1Target+q2Target));
end
