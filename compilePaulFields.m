function resultsPaul = compilePaulFields()
% Runtime: ~ 5 mins

resultFarLeft = paulFields(1);
fprintf('Completed far left DC electrodes (1/6) \n');

resultLeft = paulFields(2);
fprintf('Completed left DC electrodes (2/6) \n');

resultMiddle = paulFields(3);
fprintf('Completed center DC electrodes (3/6) \n');

resultRight = paulFields(4);
fprintf('Completed right DC electrodes (4/6) \n');

resultFarRight = paulFields(5);
fprintf('Completed far right DC electrodes (5/6) \n');

resultRF = paulFields(6);
fprintf('Completed RF rod electrodes (6/6) \n');

resultsPaul = [resultFarLeft, resultLeft, resultMiddle, resultRight, resultFarRight, resultRF];