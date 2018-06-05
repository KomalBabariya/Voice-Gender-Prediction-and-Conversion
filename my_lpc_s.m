%sachdev,babariya
function [co_effs] = my_lpc_s(buffered_signal,nn)
%takes a buffered signal and produces its n coefficients according using
%the levinson durbin algorithm

r = length(buffered_signal);
acf_signal = zeros([nn+1,1]);
co_effs = zeros([nn,1]);
md = [buffered_signal;buffered_signal]; %modulo function
for i = 1:nn+1
       acf_signal(i) = sum(buffered_signal(:).*md(i:i+r-1));
end
r_vec = acf_signal(2:end);
R_matrix = toeplitz(acf_signal(1:end-1));
rk = rank(R_matrix);
if rk<12
    R_matrix = R_matrix(1:rk,1:rk);
end
co_effs(:) = -r_vec'/R_matrix;
       

