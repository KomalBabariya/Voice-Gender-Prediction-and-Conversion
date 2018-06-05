%Sachdev,Babriya
function [overall_accuracy, per_class_accuracy] = score_prediction(test_labels, predicted_labels)
%function takes the predicted and true labels and calculates the accuracy.
n = length(test_labels);
overall_accuracy = sum(test_labels==predicted_labels)/n;
per_class_accuracy = [0 0];

first_class__correct_indices = test_labels==1;
n1 = sum(first_class__correct_indices);
first_class_predicted_values = predicted_labels(first_class__correct_indices);
per_class_accuracy(1) = sum(first_class_predicted_values==1)/n1;



second_class_correct_indices = test_labels==2;
n2 = sum(second_class_correct_indices);
second_class_predicted_values = predicted_labels(second_class_correct_indices);
per_class_accuracy(2) = sum(second_class_predicted_values==2)/n2;

end

