function o_matlabbatch = p_realign_and_unwarp(i_runs)
% 
% FORMAT:   o_matlabbatch = p_realign_and_unwarp(i_data)
%
% INPUTS:
%   i_runs:        [struct]       
%   for each run, i:
%       i_runs{i}.scans     [cell]	images for EPI run
%       i_runs{i}.vdm       [cell]	vdm, i.e., pre-calculated phase map
%                                   [] - if no vbm is available
%
% OUTPUT:
%   o_matlabbatch:  [array]         SPM structure output
%
% EllaGab: Feb. 11th, 2016
%   - based on p_realign_and_correct_distortion created by abore
%

o_matlabbatch = [];
o_matlabbatch{end+1} = [];
for i = 1: numel(i_runs)
    o_matlabbatch{end}.spm.spatial.realignunwarp.data(i).scans = i_runs{i}.scans;
    o_matlabbatch{end}.spm.spatial.realignunwarp.data(i).pmscan = i_runs{i}.vdm;
end

% Estimate realignment
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.sep = 4;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.fwhm = 5;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.rtm = 0;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.einterp = 2;
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.ewrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realignunwarp.eoptions.weight = '';

% Reslice realignment
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.jm = 0;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.fot = [4 5];
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.sot = [];
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.rem = 1;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.noi = 5;
o_matlabbatch{end}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';

% reslice and unwarps:
%   [2 0] - all images
% 	[0 1] - only mean
%   [2 1] - all images and mean
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];

% The  method  by  which  the  images  are  sampled  when  being  written  
% in a different space. Nearest   Neighbour   is   fastest,   but  not  
% recommended  for  image realignment.  Trilinear Interpolation  is  
% probably  OK  for  PET,  but not so suitable for fMRI because higher 
% degree interpolation  generally  gives  better  results. Although higher
% degree methods provide better interpolation, but they are slower because
% they use more neighbouring voxels.
% SPM default value - 4
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.rinterp = 4;

o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.mask = 1;
o_matlabbatch{end}.spm.spatial.realignunwarp.uwroptions.prefix = 'u';



