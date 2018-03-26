
% Linearizes system and gives SS model based on a desired operating point
function [A,B,C,D,Tau] = getSS(Xop,l1,l2,m1,m2,g,c1,c2)
    % Define equations
    syms q1 q1d q1dd q2 q2d q2dd T1 T2;
    
    fun1 = T1 == (m1*l1^2/3 + m2*l2^2/12 + m2*(l1^2+l2^2/4+l1*l2*cos(q2)))*q1dd + (m2*l2^2/3 + m2*l1*l2/2*cos(q2))*q2dd - m2*l1*l2*sin(q2)*q1d*q2d - m2*l1*l2*sin(q2)*q2d^2/2+(m1*l1/2+m2*l1)*g*cos(q1)+m2*l2/2*g*cos(q1+q2)+c1*q1d;
    fun2 = T2 == (m2*l2^2/3 + m2*l1*l2/2*cos(q2))*q1dd + m2*l2^2/3*q2dd + m2*l1*l2*sin(q2)/2*q1d^2 + m2*l2/2*g*cos(q1+q2) + c2*q2d;

    % Solve for OP point torque
    T1T2 = solve([fun1 fun2],[T1 T2]);
    Uop = double(subs([T1T2.T1; T1T2.T2],[q1;q1d;q2;q2d;q1dd;q2dd],[Xop;0;0]));
    
    % Solve nonlinear system
    qdd = solve([fun1 fun2],[q1dd q2dd]);
    q1dd = qdd.q1dd;
    q2dd = qdd.q2dd;
    X = sym('x',[4, 1]);
    U = sym('u',[2, 1]);
    Xd = subs([q1d;q1dd;q2d;q2dd],[q1;q1d;q2;q2d;T1;T2],[X;U]);

    % Operating point -> [x1;x2;u1] = [0;0;0] etc
    OP = [Xop; Uop];

    % Linearize system
    % Form Xd = Ax + Bu, Y = Cx + Du
    A = double(subs(jacobian(Xd, X),[X; U],OP));
    B = double(subs(jacobian(Xd, U),[X; U],OP));
    C = [1 0 0 0; 0 0 1 0];
    D = zeros(4,2);
    Tau = Uop;
end