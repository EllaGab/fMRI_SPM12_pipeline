function o_files = p_get_files(i_folder, i_ext, i_prefix)
%
% FORMAT:   o_files = get_files(i_folder, i_ext)
%   
% FORMAT:   o_files = get_files(i_folder, i_ext, i_prefix)
%
%   i_folder: [string] Folder to list
%   i_ext:    [string] Extension file
%   i_prefix: [string] Begining of the filename
%   o_files:  [char]   List of files found
% 
% abore: 10 septembre 2015
%   - creation get_files
% abore: 10 septembre 2015
%   - modification of input file - i_
%   - add documentation
% abore: 17 septembre 2015
%   - add i_prefix
%

if nargin < 3 i_prefix=''; end;

[o_files] = spm_select('List', i_folder, ['^', i_prefix , '.*' , i_ext ,'$']);

if isempty(o_files)
    warning('MyComponent:missingObject',...
    ['No files found in ', i_folder, ' folder']);
else
    if i_folder(end) == filesep
        o_files = strcat({i_folder}, o_files);
    else
        o_files = strcat({i_folder}, {filesep}, o_files);
    end
end