function subdirs_path = get_subdirs_path(dir_path, pref, ext)
% get_subdirs_path - list all subdirectories
%
% FORMAT: subdirs_path = get_subdirs_path(dir_path)
%
% FORMAT: subdirs_path = get_subdirs_path(dir_path, pref, ext)
%
% Inputs:
%   dir_path        [string]  the path to the directory to list its 
%                             subdirecories;
%   pref            [string]  filename prefix; if is given then only 
%                             directories that contain this files are listed
%   ext             [string]  filename extention; if is given then only 
%                             directories that contain this type of files
%                             are listed
%
% Output:
%   subdirs_path    [array]   the list with full paths to all required
%                             subdirectories

% Authors:
%   ellagab : 28 janvier 2016
%       - creation of get_subdirs_path

if nargin < 2, pref = ''; end
if nargin < 3, ext = ''; end

subdirs_str = genpath(dir_path);    % string with all subdirs paths separated by ';'
subdirs_path = strsplit(subdirs_str, ';');
subdirs_path = subdirs_path(:);
subdirs_path(end) = [];

% remove path to directories that don't contain the files of the required 
% type according to the pref & ext
if ~isempty(pref) || ~isempty(ext)
    for i_subdir = 1: length(subdirs_path)
        [files] = spm_select('List', subdirs_path{i_subdir}, ['^', pref , '.*' , ext ,'$']);
        if isempty(files)
            subdirs_path{i_subdir} = '';
        end
    end
    subdirs_path(ismember(subdirs_path,{''})) = [];
end

end
