function resultsPaulLoading = compilePaulLoadingFields()
% Runtime: ~ 22 mins

resultFarLeft = paulLoadingFields(1);
fprintf('Completed far left/loading DC electrodes (1/6) \n');

resultLeft = paulLoadingFields(2);
fprintf('Completed left DC electrodes (2/6) \n');

resultMiddle = paulLoadingFields(3);
fprintf('Completed center DC electrodes (3/6) \n');

resultRight = paulLoadingFields(4);
fprintf('Completed right DC electrodes (4/6) \n');

resultFarRight = paulLoadingFields(5);
fprintf('Completed far right DC electrodes (5/6) \n');

resultRF = paulLoadingFields(6);
fprintf('Completed RF rod electrodes (6/6) \n');


resultsPaulLoading = [resultFarLeft, resultLeft, resultMiddle, resultRight, resultFarRight, resultRF];