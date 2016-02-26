function o_matlabbatch = p_create_dartel(rc_arr)
% 
% FORMAT: o_matlabbatch = create_dartel()
% create the whole brain DARTEL template
%
% Input:
%   rc_arr      [cell array]    each cell contains a set of images after
%                               segmentation
%       - rc1  [cell]   gray matter images
%       - rc2  [cell]   white matter images
%       - rc3  [cell]   CSF images
%
% Output:
%   o_matlabbatch: [array]   SPM structure output  
% 
%   bore: 17 septembre 2015
%       - creation of create_dartel
% 

o_matlabbatch = [];

o_matlabbatch{end+1}.spm.tools.dartel.warp.settings.template = 'Template';
o_matlabbatch{end}.spm.tools.dartel.warp.settings.rform = 0;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(1).its = 3;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(1).rparam = [4 2 1e-06];
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(1).K = 0;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(1).slam = 16;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(2).its = 3;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(2).rparam = [2 1 1e-06];
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(2).K = 0;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(2).slam = 8;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(3).its = 3;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(3).rparam = [1 0.5 1e-06];
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(3).K = 1;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(3).slam = 4;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(4).its = 3;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(4).rparam = [0.5 0.25 1e-06];
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(4).K = 2;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(4).slam = 2;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(5).its = 3;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(5).rparam = [0.25 0.125 1e-06];
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(5).K = 4;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(5).slam = 1;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(6).its = 3;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(6).rparam = [0.25 0.125 1e-06];
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(6).K = 6;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.param(6).slam = 0.5;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.optim.lmreg = 0.01;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.optim.cyc = 3;
o_matlabbatch{end}.spm.tools.dartel.warp.settings.optim.its = 3;

for i_rc = 1 : numel(rc_arr)
    o_matlabbatch{end}.spm.tools.dartel.warp.images{i_rc} = rc_arr{i_rc};
end


