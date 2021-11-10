% Initial Parameters
timeinterval = 1; %min 
lunchTime = 3; %hrs (12pm to 3pm)
totalIntervals = lunchTime*60/timeinterval;
seatingCapacitiy = 25;
noOfCashCounter = 2;
counterServiceRate = 0.28; % (cpm)
avgTimeOnTable = 40; % min
tableServiceRate = 1/avgTimeOnTable;

arrivalData = createData();
arrivalRate = find_arrivalR(arrivalData, totalIntervals); % (cpm)

% -------------------------------------------------------------------------
% Cash Counter
[CCQueueLength, peopleAtCC, TotalCCTime, QWaitTime, CCProbDist ]=mmcQueueModel(arrivalRate, counterServiceRate, noOfCashCounter);

% -------------------------------------------------------------------------
% Tables
[TableWaiting, totalTablePeople, TotalEatTime, TableWaitTime, TableProbDist ]=mmcQueueModel(2*counterServiceRate, tableServiceRate, seatingCapacitiy);

% -------------------------------------------------------------------------
totalPeople = totalTablePeople + peopleAtCC;
totalSysTime = TotalEatTime + TotalCCTime;

% -------------------------------------------------------------------------
% Printing And Plotting Results
figure
people = 0:1:50;
subplot(2,2,1);
bar(people,CCProbDist);
xlabel("Number Of People at a time in Sytem");
ylabel("Probability");
title('Cash Counter');
subplot(2,2,2);
bar(people,TableProbDist);
xlabel("Number Of People at a time in Sytem");
ylabel("Probability");
title('Restaurant Table');

disp("------------------------");
disp("Cash Counter");
disp("------------------------");

disp("Average Queue Length - "+ CCQueueLength);
disp("Total People at Cash Counter - " + peopleAtCC);
disp("Avg. Waiting Time - " + QWaitTime);
disp("Avg. Total Time at Cash Counter - " + TotalCCTime);

disp("------------------------");
disp("Restaurant Table");
disp("------------------------");

disp("Average Queue Length - "+ TableWaiting);
disp("Total People after placing order - " + totalTablePeople);
disp("Avg. Waiting Time - " + TableWaitTime);
disp("Avg. Total Time to Dine - " + TotalEatTime);

disp("-----------------------------------------------------------------");

disp("Total People in Restaurant - " + totalPeople);
disp("Total Time Spent - " + totalSysTime);




