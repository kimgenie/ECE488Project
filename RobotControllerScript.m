
% this is a sample proportional controller which attempts to position the 
%robot within 0.2 rads for 0.5 seconds. 
% This is just an example, this will not work for your system! 
%'q' is the vector [q1 q2]' which are the joint angles. This is a READ-ONLY Value  
%'t' is the current time variable, this will be multiples of the sampling 
%time of the system. i.e. 0.001, 0.002, 0.003... 
%This is a READ-ONLY value %'torques' are the outputs of your controller. 
%'q_desired' is the desired jointvalues, i.e. [q1_desired q2_desired ]'.

%You SET THIS 
% q_desired = qRef([1,2,3,4],qCount);
q_desired = qRef([1,3],qCount);
        
switch qCount
    case 1
        A = A1; B = B1; C = C1;
        K = K1;
        F = F1;
    case 2
        A = A2; B = B2; C = C2;
        K = K2;
        F = F2;
    case 3
        A = A3; B = B3; C = C3;
        K = K3;
        F = F3;
    case 4
        A = A4; B = B4; C = C4;
        K = K4;
        F = F4;
    case 5
        A = A5; B = B5; C = C5;
        K = K5;
        F = F5;
    case 6
        A = A6; B = B6; C = C6;
        K = K6;
        F = F6;
    case 7
        A = A7; B = B7; C = C7;
        K = K7;
        F = F7;
end

% my_time = 0;
% q_desiredMod = [q_desired(1);q_desired(3)]; qMod = [q(1);q(3)];
% if(abs(q_desiredMod - qMod) < [0.2; 0.2])
if(abs(q_desired - q) < [0.2; 0.2])
    %check if angles are within 0.2 rads
    my_time = my_time + 0.001;
    if(my_time >= 0.5) %check if you're there for at least 0.5s         
        my_time = 0;
        if (qCount < 7)
            qCount = qCount + 2;
        end
        q_desired = qRef(:,qCount);  %change desired position
    end
else
    my_time = 0;
end

tau = -K*(qHat-qRef(:,qCount));
U = tauOP(:,qCount) + tau;
qHat = qHat + 0.001*((A-F*C)*(qHat) + F*(q) + B*tau);
