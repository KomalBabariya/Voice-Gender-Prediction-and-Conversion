%Sachdev, Babariya
function new_coeff = new_filt_coeff(formants,band_width, scal_val, fs)
%%function takes the formants and scale value, scales them and re
%%calculates the scaled coefficients.
new_form = formants*scal_val;
angz = new_form./(fs/(2*pi));
band_width1 = 2-formants./5000;
amp = exp(band_width1.*-4*pi/fs)*4;
r = [amp, amp].*exp(1i.*[angz, -angz]);
new_coeff = poly(r);
end

