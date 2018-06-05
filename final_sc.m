%Sachdev, Babariya
% RUNS THE WHOLE DATA SET TRAIN, PREDICT, CONVERT AND PREDICT AGAIN
%% calculate  the training,test and validate features
p_val = '..\LDC93S1\timit\TIMIT\Validate';
p_test= '..\LDC93S1\timit\TIMIT\TEST';
p_train= '..\LDC93S1\timit\TIMIT\Train';

coeffs_path_val = 'coeffs_validate.xlsx';
coeffs_path_test = 'coeffs_Test.xlsx';
coeffs_path_train = 'coeffs_Train.xlsx';

labelpath_val= 'Validate_f.xlsx';
labelpath_test = 'Test_f.xlsx';
labelpath_train = 'Train_f.xlsx';

festureCal_func(p_val,0,coeffs_path_val,labelpath_val);
festureCal_func(p_test,0,coeffs_path_test,labelpath_test);
festureCal_func(p_train,0,coeffs_path_train,labelpath_train);



%% calculate the thetas NEED TO RUN THIS SECTION FOR ALL FUTURE SECTIONS
%1=female and 2=male
    X_training = xlsread('coeffs_Train.xlsx');
    Y_training = xlsread('Train_f.xlsx');
    theta = mnrfit(X_training,Y_training); 
%     theta = [8.20750250840375;...
%     9.79231487403744;...
%     10.9787109697300;...
%     15.5431572037483;...
%     18.9033452501562;...
%     21.2794727981735;...
%     22.2359275579426;...
%     25.9720714904461;...
%     27.3480299541774;...
%     22.1353859446050;...
%     10.3635200502732;...
%     -2.02270283323115;-10.0078183281261;-22.6762806543929;-48.1092755054829];

    
%% calculate the initial accuracy percentage in validate set

x_validate = xlsread('coeffs_Validate.xlsx');
y_validate = xlsread('Validate_f.xlsx');
pihat = mnrval(theta,x_validate);
[~,i_v] = max(pihat,[],2); %predict
[overall_accuracy_validate, per_class_accuracy_validate] = score_prediction(y_validate, i_v);


%% calculate the initial accuracy percentage in test set
x_test = xlsread('coeffs_Test.xlsx');
y_test = xlsread('Test_f.xlsx');n
pihat = mnrval(theta,x_test);
[~,i] = max(pihat,[],2); %predict
[overall_accuracy_test, per_class_accuracy_test] = score_prediction(y_test, i);


%% For each validation and test set, predict the class convert to the opposite gender
p_t = '..\LDC93S1\timit\TIMIT\TEST';
p_t_n = '..\LDC93S1\timit\TIMIT\TESTConverted';
p_v = '..\timit\TIMIT\Validate';
p_v_n = '..\timit\TIMIT\ValidateConverted';
main(p_t,p_t_n,theta)
main(p_v,p_v_n,theta)

%% make the converted feature files
p_v_n = '..\LDC93S1\timit\TIMIT\ValidateConverted';
p_t_n = '..\LDC93S1\timit\TIMIT\TESTConverted';

coeffs_path_v = 'coeffs_validateConverted.xlsx';
coeffs_path_t = 'coeffs_TestConverted.xlsx';
labelpath_v = 'ValidateConverted_f.xlsx';
labelpath_t = 'TestConverted_f.xlsx';
festureCal_func(p_v_n,1,coeffs_path_v,labelpath_v)
festureCal_func(p_t_n,1,coeffs_path_t,labelpath_t)

%% calculate  after conversion accuracy percentage in validate set

x_validate = xlsread('coeffs_validateConverted.xlsx');
y_validate = xlsread('ValidateConverted_f.xlsx');
pihat = mnrval(theta,x_validate);
[~,i_v] = max(pihat,[],2);
[overall_accuracy_validate_converted, per_class_accuracy_validate_converted] = score_prediction(y_validate, i_v);


%% calculate  after conversion accuracy accuracy percentage in test set

x_test = xlsread('coeffs_TestConverted.xlsx');
y_test = xlsread('TestConverted_f.xlsx');
pihat = mnrval(theta,x_test);
[~,i] = max(pihat,[],2);
[overall_accuracy_test_converted, per_class_accuracy_test_converted] = score_prediction(y_test, i);


