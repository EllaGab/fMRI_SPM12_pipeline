function o_matlabbatch = p_create_VDM(i_scans, i_mag, i_phase, i_TE, i_EES, i_echoes)
%
% FORMAT:   o_matlabbatch = p_create_VDM(i_scans, i_mag, i_phase, i_TE, i_EES, i_echoes)
%
% INPUTS:
%   i_scans:        [cellstr]       images for all EPI runs (one for each 
%                                   run) that should be corrected using the
%                                   same fieldmap
%   i_mag:          [string]        path to the magnitude image
%   i_phase:        [string]        path to the phase image
%   i_TE:           [float float]   short and long TE
%   i_EES:          [float]         effective echo spacing
%   i_echoes:       [float]         the # of echoes to cover k-space, i.e.,
%                                   base resolution
% 
% OUTPUT:
%   o_matlabbatch:  [array]         SPM structure output
%
% EllaGab: Feb. 9th, 2016
%   - based on p_realign_and_correct_distortion created by abore
%

o_matlabbatch = [];
    
o_matlabbatch{end+1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.phase = cellstr(i_phase);	% phase image
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.magnitude = cellstr(i_mag);	% magnitude Image
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.et = i_TE;                 %[short TE long TE]
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.maskbrain = 1;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.blipdir = -1;              % A >> P: -1  , P >> A: 1
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.tert = i_echoes * i_EES;   % total EPI readout time
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.epifm = 0;                 % 1 - EPI based fieldmap, 0 - non-EPI based fieldmap
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.ajm = 0;                   % 1 - use Jacobian modilation; 0 - don't use Jacobian modilation
                                                                                                        % in general is not recommended for EPI distortion correction
for i_sess = 1 : numel(i_scans)
    o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.session(i_sess).epi =  i_scans{i_sess};
end

o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.matchvdm = 0;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.sessname = 'run';
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.writeunwarped = 0;    % write unwarped image
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.anat = [];            % Structural T1 anat
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.matchanat = 0;        % Match T1 with EPI

% SPM default pparameters
% -------------------------------------------------------------------------------------------------------------------
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.method = 'Mark3D';
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.fwhm = 10;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.pad = 0;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.ws = 1;
template = fullfile(spm('dir'),'toolbox','FieldMap','T1.nii');
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.template = cellstr(template);
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.fwhm = 5;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.nerode = 2;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.ndilate = 4;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.thresh = 0.5;
o_matlabbatch{end}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.reg = 0.02;
% -------------------------------------------------------------------------------------------------------------------

end

