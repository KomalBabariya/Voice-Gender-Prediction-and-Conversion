function [class] = predict(x_t,theta)
%Takes the file's lpc and then predicts it's class accordingly
a = my_lpc_s(x_t,14);
pihat = mnrval(theta,a');
[~,class] = max(pihat);
end

