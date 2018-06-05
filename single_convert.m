%Sachdev, Babariya
function [] = single_convert (f_path,save_path,theta)
%%takes a file, predicts it class and converts accordingly. It then saves
%%the predicted file in the specified path


[x_t,fs] = audioread(f_path);
class = predict(x_t,theta);
          %class =  string(subFolders1(j).name(1));
if class == 1
        sp = 0.85;
        sf = 0.8;
elseif class == 2
        sp = 1/0.85;
        sf = 1/0.8;
end
[coverted_audio, fs_ca] = VGC( x_t, fs, sp, sf);
            
scaled = coverted_audio - min(coverted_audio);  
scaled = scaled / max(scaled); 
audiowrite(save_path,scaled,fs_ca);
end