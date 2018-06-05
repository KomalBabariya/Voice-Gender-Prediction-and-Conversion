%sachdev,babariya
function [] = festureCal_func(f_name,converted,coeffs_path,labelpath)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Takes the directory's name and calculates the features of it. It defines
% the labels as defined by the folder name.
%   converted is a bool value
% f_name is the directory path
% coeffs_path is the xlsx file name/pth where the coefficents would
% be stored
% labelpath is the xlsx file name/pth where the labels would
% be stored
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

files = dir(f_name);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
counter = 1;
% Print folder names to command window.
for k = 1 : length(subFolders)
	f_name1 = strcat(f_name,'\',subFolders(k).name);
    files1 = dir(f_name1);
    % Get a logical vector that tells which is a directory.
    dirFlags1 = [files1.isdir];
    % Extract only those that are directories.
    subFolders1 = files1(dirFlags1);
    
    for j = 1 : length(subFolders1)
        
        files2 = strcat(f_name1,'\',subFolders1(j).name);
        dirinfo = dir( fullfile(files2, '*.wav') );
        numfiles = length(dirinfo);
        for i = 1 : numfiles
          thisfile = fullfile(files2, dirinfo(i).name );
          [x_t,~] = audioread(thisfile);
          a = my_lpc_s(x_t,14);
          csv_ftab(counter,:)  = a';
          if converted
            if string(subFolders1(j).name(1)) == 'F'
            csv_filename(counter,1) = 2;
            else
                csv_filename(counter,1) = 1;
            end
          else
              if string(subFolders1(j).name(1)) == 'M'
                csv_filename(counter,1) = 2;
              else
                csv_filename(counter,1) = 1;
              end
          end
          counter = counter+1;
        end
    end
end
xlswrite(coeffs_path,csv_ftab);
xlswrite(labelpath,csv_filename,1);

end

