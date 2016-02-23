function o_matlabbatch = p_design_estimate(i_spm, i_matlabbatch)
% 
%	FORMAT: o_matlabbatch = p_estimate_design(i_spm, i_matlabbatch)
% 
% INPUT:
%   i_spm:  [string] SPM.mat
%   i_matlabbatch:  [struct] SPM.mat
%
% OUTPUT:
%   o_matlabbatch: [struct]
% 
%   abore: 30 septembre 2015
%       - creation of p_estimate_design 
% 

if nargin<2, i_matlabbatch = []; end

o_matlabbatch = i_matlabbatch;
o_matlabbatch{end+1}.spm.stats.fmri_est.spmmat = cellstr(i_spm);
o_matlabbatch{end}.spm.stats.fmri_est.write_residuals = 0;
o_matlabbatch{end}.spm.stats.fmri_est.method.Classical = 1;

end