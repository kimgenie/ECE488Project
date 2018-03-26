
% this is a sample proportional controller which attempts to position the 
%robot within 0.2 rads for 0.5 seconds. 
% This is just an example, this will not work for your system! 
%'q' is the vector [q1 q2]' which are the joint angles. This is a READ-ONLY Value  
%'t' is the current time variable, this will be multiples of the sampling 
%time of the system. i.e. 0.001, 0.002, 0.003... 
%This is a READ-ONLY value %'torques' are the outputs of your controller. 
%'q_desired' is the desired jointvalues, i.e. [q1_desired q2_desired ]'.

% Sup brahs

%You SET THIS 
q_desired = qRef(:,qCount);
        
switch qCount
    case 1
        K = K1;
    case 2
        K = K2;
    case 3
        K = K3;
    case 4
        K = K4;
    case 5
        K = K5;
    case 6
        K = K6; 
    case 7
        K = K7; 
end

% my_time = 0;
q_desiredMod = [q_desired(1);q_desired(3)]; qMod = [q(1);q(3)];
if(abs(q_desiredMod - qMod) < [0.2; 0.2])
    %check if angles are within 0.2 rads
    my_time = my_time + 0.001;
    if(my_time >= 0.5)  %check if you're there for atleast 0.5s         
        my_time = 0;
        if (qCount < 7)
            qCount = qCount + 1;
        end
        q_desired = qRef(:,qCount);  %change desired position
    end
else
    my_time = 0;
end
% Kp = 1;%proportional gain 
tau = tauOP(:,qCount) - K*(q-qRef(:,qCount));
U = tau;
