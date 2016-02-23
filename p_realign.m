function o_matlabbatch = p_realign(i_files2realign, bk, i_folder, i_reslice)
%
% FORMAT:   o_matlabbatch = p_realign(i_files2realign)
% FORMAT:   o_matlabbatch = p_realign(i_files2realign, bk, i_folder)

% INPUTS:
%   i_files2realign:    [cell array]    files to realign; each cell
%                                       contains files for a single run/session
%   bk:                 [boolean]       backup your files with the original
%                                       orientation
%   i_folder            [string]        full path to the directory to save
%                                       the original files prior to the 
%                                       realignment
% i_reslice             [boolean]       1 - reslice all images, 0 - reslice
%                                       only the mean image; the resliced
%                                       images are saved with the prefix
%                                       'r'
% 
% OUTPUT:
%   o_matlabbatch: [array]   SPM structure output  
% 
%   abore: 10 septembre 2015
%       - creation realign_4d
%   abore: 11 septembre 2015
%       - rename to realign
%       - add: extension, dependancy or not to previous SPM module
%   abore: 14 septembre 2015
%       - add backup option
%       - add dependancy btw modules
%   abore: 22 septembre 2015
%       - add nargin condition
%       @TODO: bk need to be rewritten
%   abore: 25 janvier 2016
%       - Add comments and change default roptions.interp to 3 (see ga)
%       - Modification of roptions.which to "Only Mean" [0 1]
%       - Now use i_files2realign input instead of i_folder
%       - i_folder is used only when bk
% 
if nargin < 3
    bk = false;
end
if nargin < 4
    i_reslice = 0;
end

o_matlabbatch = [];

if bk
    o_matlabbatch{end+1}.cfg_basicio.file_dir.file_ops.file_move.files = cellstr(i_files2realign);
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.copyto = cellstr(i_folder);
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.patrep.pattern = 'f';
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.patrep.repl = 'raw_f';
    o_matlabbatch{end}.cfg_basicio.file_dir.file_ops.file_move.action.copyren.unique = false;
end

o_matlabbatch{end+1} = [];
for i_run = 1 : numel(i_files2realign)
    o_matlabbatch{end}.spm.spatial.realign.estwrite.data(i_run) = {cellstr(i_files2realign{i_run})};    
end

% SPM default pparameters
% -------------------------------------------------------------------------
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.sep = 4;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.interp = 2;
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realign.estwrite.eoptions.weight = '';
% -------------------------------------------------------------------------

% reslice:
%   [2 0] - all images
% 	[0 1] - only mean
%   [2 1] - all images and mean
if i_reslice % reslice all images
    o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.which = [2 1];
else % reslice onlt the mean image
    o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.which = [0 1];
end

% The  method  by  which  the  images  are  sampled  when  being  written  
% in a different space. Nearest   Neighbour   is   fastest,   but  not  
% recommended  for  image realignment.  Trilinear Interpolation  is  
% probably  OK  for  PET,  but not so suitable for fMRI because higher 
% degree interpolation  generally  gives  better  results. Although higher
% degree methods provide better interpolation, but they are slower because
% they use more neighbouring voxels.
% SPM default value - 4
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.interp = 4; 

o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.mask = 1;
o_matlabbatch{end}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

