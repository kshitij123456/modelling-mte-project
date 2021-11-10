function [ arrivalR ] = find_arrivalR( arrival_data,totalIntervals )

    interarrival = zeros([1,90]);
    for i=2:1:90
        interarrival(i) = arrival_data(i)-arrival_data(i-1);
    end
    histogram(interarrival)
    xlabel("Interarrival Time");
    ylabel("Frequency");
    sz = size(arrival_data);
    arrivalR = sz(2)/180;
end

