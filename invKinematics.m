clc;

syms th1 th2 l1 l2

dh = [0  0  0  th1;
      l1 0  0  th2;
      l2 0  0  0];
  
T01 = TransformMatrix(dh(1,:));
T12 = TransformMatrix(dh(2,:));
T23 = TransformMatrix(dh(3,:));

T03 = T01*T12*T23;  % End effector xfrm

dTarget = 
Ttarget = [eye(3) dtarget; 0 0 0 1];

function [T] = TransformMatrix(dhRow)
    a =     dhRow(1);
    alpha = dhRow(2);
    d =     dhRow(3);
    theta = dhRow(4);
    
    T = sym('T', 4);
    T(1,1) = cos(theta);
    T(1,2) = -sin(theta);
    T(1,3) = 0;
    T(1,4) = a;
    T(2,1) = sin(theta)*cos(alpha);
    T(2,2) = cos(theta)*cos(alpha);
    T(2,3) = -sin(alpha);
    T(2,4) = -d*sin(alpha);
    T(3,1) = sin(theta)*sin(alpha);
    T(3,2) = cos(theta)*sin(alpha);
    T(3,3) = cos(alpha);
    T(3,4) = d*cos(alpha);
    T(4,1) = 0;
    T(4,2) = 0;
    T(4,3) = 0;
    T(4,4) = 1;
end