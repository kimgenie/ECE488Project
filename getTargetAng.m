
clear all; close all; clc;

constants;

xTarget = 0.1;
yTarget = 0.1;

syms q1 q2;

x = xTarget == l1*cos(q1) + l2*cos(q1+q2);
y = yTarget == l1*sin(q1) + l2*sin(q1+q2);

P = solve([x y],[q1 q2]);
qTarget = double([P.q1(1); P.q2(1)])

% display(l1*cos(q1Target) + l2*cos(q1Target+q2Target));
% display(l1*sin(q1Target) + l2*sin(q1Target+q2Target));

