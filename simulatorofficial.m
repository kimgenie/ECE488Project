
function [Xd] = simulatorofficial(time,x,U,l1,l2,m1,m2,g,c1,c2)
    x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
    u1 = U(1); u2 = U(2);
    
    Xd(1) = x2;
    Xd(2) = (3*(4*l2*u1 - 4*l2*u2 - 6*l1*u2*cos(x3) - 4*c1*l2*x2 + 4*c2*l2*x4 + 6*c2*l1*x4*cos(x3) + 2*l1*l2^2*m2*x2^2*sin(x3) + 2*l1*l2^2*m2*x4^2*sin(x3) - 2*g*l1*l2*m1*cos(x1) - 4*g*l1*l2*m2*cos(x1) + 3*g*l1*l2*m2*cos(x1 + x3)*cos(x3) + 3*l1^2*l2*m2*x2^2*cos(x3)*sin(x3) + 4*l1*l2^2*m2*x2*x4*sin(x3)))/(4*l1^2*l2*m1 + 12*l1^2*l2*m2 - 9*l1^2*l2*m2*cos(x3)^2);
    Xd(3) = x4;
    Xd(4) = -(3*(4*l2^2*m2*u1 - 12*l1^2*m2*u2 - 4*l1^2*m1*u2 - 4*l2^2*m2*u2 - 4*c1*l2^2*m2*x2 + 4*c2*l1^2*m1*x4 + 12*c2*l1^2*m2*x4 + 4*c2*l2^2*m2*x4 + 2*l1*l2^3*m2^2*x2^2*sin(x3) + 6*l1^3*l2*m2^2*x2^2*sin(x3) + 2*l1*l2^3*m2^2*x4^2*sin(x3) + 6*g*l1^2*l2*m2^2*cos(x1 + x3) - 4*g*l1*l2^2*m2^2*cos(x1) + 6*l1*l2*m2*u1*cos(x3) - 12*l1*l2*m2*u2*cos(x3) + 2*l1^3*l2*m1*m2*x2^2*sin(x3) + 4*l1*l2^3*m2^2*x2*x4*sin(x3) + 3*g*l1*l2^2*m2^2*cos(x1 + x3)*cos(x3) - 6*c1*l1*l2*m2*x2*cos(x3) + 12*c2*l1*l2*m2*x4*cos(x3) + 6*l1^2*l2^2*m2^2*x2^2*cos(x3)*sin(x3) + 3*l1^2*l2^2*m2^2*x4^2*cos(x3)*sin(x3) - 6*g*l1^2*l2*m2^2*cos(x1)*cos(x3) + 2*g*l1^2*l2*m1*m2*cos(x1 + x3) - 2*g*l1*l2^2*m1*m2*cos(x1) + 6*l1^2*l2^2*m2^2*x2*x4*cos(x3)*sin(x3) - 3*g*l1^2*l2*m1*m2*cos(x1)*cos(x3)))/(12*l1^2*l2^2*m2^2 + 4*l1^2*l2^2*m1*m2 - 9*l1^2*l2^2*m2^2*cos(x3)^2);
    Xd = Xd';
end
    