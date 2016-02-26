function o_matlabbatch = p_skull_strip(img2skull_strip, tissues, o_dir, o_fname)
% FORMAT:   o_matlabbatch = p_realign(i_files2realign)
%
% INPUTS:
%   img2skull_strip [string / cell array]       image to skull strip
%   tissues         [char array / cell array]	sigmented brain tissues
%                                           	c1, c2 & c3 (optional)
%   o_dir           [string / cell array]       full path to the directory 
%                                               to save skull stripped image 
% o_fname           [string]                    name fot the skull stripped
%                                               image 
% 
% OUTPUT:
%   o_matlabbatch: [array]   SPM structure output  
% 
%   EllaGab: February 18th, 2016
%
%

if ischar(img2skull_strip)
    img2skull_strip = cellstr(img2skull_strip);
end
if ischar(tissues)
    tissues = cellstr(tissues);
end
if ischar(o_dir)
    o_dir = cellstr(o_dir);
end
if numel(img2skull_strip) > 1
    error('More than one image for skull stripping. CHECK!!!');
end


files = [];
files = [files; img2skull_strip];
files = [files; tissues];

exp = 'i1.*((';
for i_tussie = 1 : numel(tissues)
    exp = [exp 'i' num2str(i_tussie+1) '+'];
end

exp(end) = [];
exp = [exp ')>0.5)'];

o_matlabbatch = [];
o_matlabbatch{end+1}.spm.util.imcalc.input = files;
o_matlabbatch{end}.spm.util.imcalc.output = o_fname;
o_matlabbatch{end}.spm.util.imcalc.outdir = o_dir;
o_matlabbatch{end}.spm.util.imcalc.expression = exp;
o_matlabbatch{end}.spm.util.imcalc.options.dmtx = 0;  % 0 - images are read into  separate  variables:  i1,  i2,  i3,...
                                                    % 1 - images are read into a data matrix X 
end



