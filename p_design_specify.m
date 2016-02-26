function o_matlabbatch = p_design_specify(...
                                        i_matlabbatch, ...
                                        o_folder, i_units, i_TR, ...
                                        i_file, i_nVols, i_cond, ...
                                        i_pmod, i_reg, i_multireg ...
                                        )
% 
%	FORMAT: o_matlabbatch = p_design_specify(...
%                                         i_matlabbatch, ...
%                                         o_folder, i_units, i_TR, ...
%                                         i_file, i_nVols, i_cond ...
%                                         )
%
%	FORMAT: o_matlabbatch = p_design_specify(...
%                                         i_matlabbatch, ...
%                                         o_folder, i_units, i_TR, ...
%                                         i_file, i_nVols, i_cond, ...
%                                         i_pmod ...
%                                         )
%
%   FORMAT: o_matlabbatch = p_design_specify(...
%                                         i_matlabbatch, ...
%                                         o_folder, i_units, i_TR, ...
%                                         i_file, i_nVols, i_cond, ...
%                                         i_pmod, i_reg ...
%                                         )
%
%   FORMAT: o_matlabbatch = p_design_specify(...
%                                         i_matlabbatch, ...
%                                         o_folder, i_units, i_TR, ...
%                                         i_file, i_nVols, i_cond, ...
%                                         i_pmod, i_reg, i_multireg ...
%                                         )
%
% NOTE! If the matlabbatch is not empty, i.e., it contains data,
% the output folder (o_folder), the untis for analyses (i_units) and TR (i_TR)
% have been already specified and, therefore, can be left empty.
%
% INPUT:
%   i_matlabbatch   [struct]    matlabbatch to which new session is added;
%                               if [] - new matlabbatch is created
%   o_folder    	[string]    full path to the output SPM directory
%   i_units         [string]    'scans' or 'secs'
%   i_file          [cell]      data for analysis
%   i_nVols         [int, 1x2]	for 4D image, the first and the last 
%                               volume for analysis; [] - to analyse all 
%                               volumes or for 3D images
%   i_TR            [float]     TR data acquisition
%   i_cond          [cell arr]  cell aray of structs, i - the # of
%                               condition
%                               i_cond{i}.name      [string]
%                               i_cond{i}.onsets    [float, 1xn]
%                               i_cond{i}.durations [float, 1xn]
%   i_pmod          [struct]
%   i_reg           [cell arr] 	cell aray of structs; i - the # of
%                              	regressor, n - the number of volumes
%                               i_reg{i}.name      [string]
%                               i_reg{i}.value    [float, 1xn]
%   i_multireg      [string]
% 
% OUTPUT:
%   o_matlabbatch	[struct]
% 
%   abore: 24 september 2015
%       - creation of create_design
%   EllaGab: February 23th, 2016
%       
%       

if nargin < 8,  i_pmod = []; end
if nargin < 9, i_reg = []; end
if nargin < 10, i_multireg=[];end

if ~iscellstr(i_file)
    i_file = cellstr(i_file);
end
    
o_matlabbatch = i_matlabbatch;

if isempty(o_matlabbatch) % New subject

    o_matlabbatch{end+1}.spm.stats.fmri_spec.dir = cellstr(o_folder);
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.units = i_units;
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.RT = i_TR;
    
    % default SPM values
    % ```````````````````````````````````````````````````````````````````
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.fmri_t = 16;
    o_matlabbatch{end}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
    o_matlabbatch{end}.spm.stats.fmri_spec.fact = struct('name', {}, ...
                                                         'levels', {});
    o_matlabbatch{end}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    o_matlabbatch{end}.spm.stats.fmri_spec.volt = 1;
    o_matlabbatch{end}.spm.stats.fmri_spec.global = 'None';
    o_matlabbatch{end}.spm.stats.fmri_spec.mthresh = 0.8;
    o_matlabbatch{end}.spm.stats.fmri_spec.mask = {''};
    o_matlabbatch{end}.spm.stats.fmri_spec.cvi = 'AR(1)';
    % ```````````````````````````````````````````````````````````````````
    
    nSess = 1;
    
else % New session / same subject
    
    nSess = length(o_matlabbatch{end}.spm.stats.fmri_spec.sess) + 1 ;

end

% if 4D image, load only the relevant volumes
if size(i_file,1) == 1 && length(i_nVols) == 2
    i_arr = strtrim(cellstr(num2str([i_nVols(1):1:i_nVols(2)]')));
    i_file_arr = cell(length(i_arr), 1);
    i_file_arr(:) = i_file;
    i_file_arr = strcat(i_file_arr, ',', i_arr);
    i_file = i_file_arr;
end
 
o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).scans = i_file;
o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).multi = {''};
o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).hpf = 128;

for nCond=1:length(i_cond)  % Set Conditions
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).name = ...
        i_cond{nCond}.name;     %NAME
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).onset = ...
        i_cond{nCond}.onsets;    %ONSETS
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).duration = ...
        i_cond{nCond}.durations; %DURATION
    
    if ~isempty(i_pmod)
        if ~isempty(i_pmod{nCond}.name)   % Set modulation if exist
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).tmod = 0;
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).pmod.name = ...
                i_pmod{nCond}.name;     %NAME
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).pmod.param = ...
                i_pmod{nCond}.onsets;    %ONSETS
            o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).cond(nCond).pmod.poly = 1;
        end
    end
end

for nReg=1:length(i_reg)    % Set regressors
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).regress(end+1).name = ...
        i_reg{nReg}.name;   % NAME
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).regress(end).val = ...
        i_reg{nReg}.value; % VALUES
end

if ~isempty(i_multireg)     % Set multi regresssors - movement
    o_matlabbatch{end}.spm.stats.fmri_spec.sess(nSess).multi_reg = ...
        cellstr(i_multireg);%MULTI REG - MOVEMENT
end

