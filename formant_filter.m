%Sachdev,Babriya
function [coeff, formants, band_width] = formant_filter(x, fs, formant_len)
%takes an input signal(frame prefferably) and calculates it coeeficients,
%formants and bandwidth
n = 2*formant_len;
A = my_lpc_s(x,n);
A = A';
rts = roots(A);
rts = rts(imag(rts)>=0);
angz = atan2(imag(rts),real(rts));
[frqs,indices] = sort(angz.*(fs/(2*pi)));
bw = -1/2*(fs/(2*pi))*log(abs(rts(indices)));
f = zeros(1,formant_len);
band_width = zeros(1,formant_len);
nn = 1;
for kk = 1:length(frqs)
    if (frqs(kk) > 90 && bw(kk) <400)
        f(nn) = frqs(kk);
        band_width(nn) = bw(kk);
        nn = nn+1;
    end
end
formants = f;
coeff = A;
end
