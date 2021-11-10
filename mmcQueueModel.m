function [ avgQlen, avgSysno, avgTotalTime, avgQueueWaitingTime, probSys ] = mmcQueueModel(arrival_rate , service_rate, n)
    % rho = lambda/ mue
    rho = arrival_rate/service_rate
    
    if(rho/n>=1)
        disp("Queue will grow without bounds");
        return
    end
    
    %Initializing arrays
    people = 0:1:50;
    probSys = ones([1,51]);
    
%     Probability of i people in system
    sigmaSum = 0;
    for i=0:1:n-1
        sigmaSum = sigmaSum + (rho^i)/factorial(i);
    end
    probSys(1) = (sigmaSum + (rho^n)/(factorial(n)*(1-rho/n)))^(-1);
    
    for i=1:1:50
        if i<n
            probSys(i+1) = probSys(1)*(rho^i)/factorial(i);
        else
            probSys(i+1) = probSys(1)*(rho^i)/((n^(i-n))*factorial(n));
        end
    end
    
%     Results
    avgQlen = (probSys(1)*(rho^(n+1)))/(n*factorial(n)*((1-rho/n)^2)); 
    
    avgSysno = avgQlen + rho;
    
    avgTotalTime = avgSysno/arrival_rate; %(min)
    
    avgQueueWaitingTime = avgTotalTime - 1/service_rate; %(min)

end

