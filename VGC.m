%sachdev,Babariya
function [coverted_audio, fs_ca] = VGC( x_t, fs, sp, sf)
%function takes an input signal, its fs and sp and sf values and
%scales/converts the signal using the parameters. It returns a converted
%audio file and the new fs.

win_len = ceil(0.020.*fs); %20msec window
time_scale = ceil(win_len*sf/(2));
s = spectrogram(x_t,hann(win_len),win_len/2,win_len,fs);
x_tscale = istft(s,win_len,win_len,time_scale);
buffered_signal = buffer(x_tscale,win_len,win_len/2);
[r,c] = size(buffered_signal);
a = zeros([15,c]);
frmntscl_x = zeros([r,c]);
scal_val = sp/sf;

for j = 1:c
    [coeff, formants, band_width] = formant_filter(buffered_signal(:,j), fs, 7);
    new_coeff = new_filt_coeff(formants,band_width, scal_val, fs);
    a(:,j) = new_coeff(1:15);
    frmntscl_x(:,j) = filter([0 new_coeff(2:end)],1,buffered_signal(:,j));

end
%recombining the audio using cos^2x + sin^2x = 1
smting_win = linspace(0,pi/2,win_len/2);
cos_sig = cos(smting_win).^2;
sin_sig = sin(smting_win).^2;
vec_c = [sin_sig cos_sig];
mat_c = repmat(vec_c',1,c);
smthd_mat = frmntscl_x.*mat_c;
y = smthd_mat(1:win_len/2, 2:end) + smthd_mat(win_len/2+1:end, 1:end-1);
coverted_audio = [y(:); smthd_mat(win_len/2+1:end,end)];
fs_ca = round(fs*sp);
end

