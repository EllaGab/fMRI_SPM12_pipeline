function o_matlabbatch = p_imcalc_mean(files, output_fname, output_dir_path)
% FORMAT: o_matlabbatch = p_imcalc(files, output_fname, output_dir_path)
%
% Inputs:
%   files               [cell]      paths to images
%   output_fname        [string]    name for the ouput image
%   output_dir_path     [string]    path to the ouput directory
%
% Output:
%   o_matlabbatch   [array]   SPM structure

% Authors:
%   EllaGab : Feb. 9th, 2016
%       - Creation of p_imcalc_mean

[~,~,ext,~] = spm_fileparts(output_fname);

if isempty(ext)
    output_fname = [output_fname '.nii'];
end

o_matlabbatch = [];

o_matlabbatch{end+1}.spm.util.imcalc.input = cellstr(files);
o_matlabbatch{end}.spm.util.imcalc.output = output_fname;
o_matlabbatch{end}.spm.util.imcalc.outdir = cellstr(output_dir_path);
o_matlabbatch{end}.spm.util.imcalc.expression = 'mean(X)';
o_matlabbatch{end}.spm.util.imcalc.options.dmtx = 1; % 0 - images are read into  separate  variables:  i1,  i2,  i3,... / 1 - images are read into a data matrix X 

end

