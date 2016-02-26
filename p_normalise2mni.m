function o_matlabbatch = p_normalise2mni(i_template, one2one, i_flowfield, i_files2normalise, fwhm, voxSize)
% 
%   function o_matlabbatch = normalise2mni(i_template, i_flowfield, i_files2normalise)
% 
% Inputs:
%   i_template:         [string / cell array]  
%   one2one:            [boolean]                   1 - each flowfield corresponds to one file to normalise; 
%                                                   in SPM butch equivalent to 'select according to many subjects'
%                                                   0 - each flowfield corresponds to many files to normalise; 
%                                                   in SPM butch equivalent to 'select according to few subjects' 
%   i_flowfield:        [char array / cell array]
%   i_files2normalise:  [char array / cell array]
%   i_fwhm:             [array, 1 X 3]               smoothing
%   voxSize:            [array, 1 X 3]               voxel size
%
% Output:
%   o_matlabbatch:      [array]
% 
%   abore: 17 Septembre 2015
%       - creation of normalise2mni
%   abore: 15 Decembre 2015
%       - Mettre tous les flowfield et tous les anats
% 
%   abore: 22 janvier 2016
%       - Voxel size depend on input file2normalise
% 
%   EllaGab: February 18th, 2016
%

if ischar(i_template)
    i_template = cellstr(i_template);
end
if ischar(i_flowfield)
    i_flowfield = cellstr(i_flowfield);
end
if ischar(i_files2normalise)
    i_files2normalise = cellstr(i_files2normalise);
end

o_matlabbatch = [];
o_matlabbatch{end+1}.spm.tools.dartel.mni_norm.template = i_template;

% each flowfield corresponds to one file to normalise
% in SPM butch equivalent to 'select according to many subjects'
if one2one
    o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subjs.flowfields = i_flowfield;
    for i_img = 1 : size(i_files2normalise, 2)
        o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subjs.images{i_img} = i_files2normalise{:, i_img};
    end

% each flowfield corresponds to many files to normalise
% in SPM butch equivalent to 'select according to few subjects'
else
    if size(i_flowfield, 2)~= size(i_files2normalise, 2)
        error('The number of flowfields and images sets should be the same. CHECK!!!');
    end
    for i_subj = 1 : size(i_flowfield, 2)
        o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subj(i_subj).flowfield = i_flowfield(i_subj);
        o_matlabbatch{end}.spm.tools.dartel.mni_norm.data.subj(1).images = i_files2normalise(:, i_subj);
        
    end

    
end

% o_matlabbatch{end}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
%                                                NaN NaN NaN];

if nargin < 6
    hdr = load_nifti_hdr(i_files2normalise{1,1});
    voxSize = [hdr.pixdim(2), hdr.pixdim(3), hdr.pixdim(4)];
end

o_matlabbatch{end}.spm.tools.dartel.mni_norm.vox = voxSize;
o_matlabbatch{end}.spm.tools.dartel.mni_norm.preserve = 0;
o_matlabbatch{end}.spm.tools.dartel.mni_norm.fwhm = fwhm;
