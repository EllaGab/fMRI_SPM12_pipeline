function o_matlabbatch = p_reorient_imgs(files, reorient_matfile, prefix)

% p_reorient_imgs - reorient files applying reorientation matrix
%
% FORMAT: o_matlabbatch = p_reorient_imgs(imgspaths_arr, reorient_matfile_path, prefix)
%
% Inputs:
% files                 [cell array] 	full paths to images to reorient
% reorient_matfile:     [string]        reorientation matrix - cfg_entry
% prefix:               [string]        prefix to add to reoriened images
%
% Output:
%   o_matlabbatch   [array]   SPM structure

% Authors:
%   EllaGab : February 17th, 2016
%       - Creation of p_reorient_imgs

o_matlabbatch = [];

% Specify images to reorient
o_matlabbatch{end+1}.spm.util.reorient.srcfiles = files;

% Specify reorientation matrix
load(reorient_matfile);
o_matlabbatch{end}.spm.util.reorient.transform.transM = M;

% Specify prefix for reoriened images
o_matlabbatch{end}.spm.util.reorient.prefix = prefix;

end
