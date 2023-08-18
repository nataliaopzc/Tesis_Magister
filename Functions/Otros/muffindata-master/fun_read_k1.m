function [k1,mask,imax,jmax]  = fun_read_k1(par_path,par_expid,par_gcm)
%
%%

% *********************************************************************** %
% *** READ AND RETURN TOPO ********************************************** %
% *********************************************************************** %
%
% (1) read in 'k1' file
% (2) extract core data plus imax, jmax
% (3) extract mask
% (4) return both mask and topo
%
% *** READ IN 'k1' FILE ************************************************* %
%
% Create filename
switch par_gcm
    case ('k1')
        if isempty(par_path),
            loc_str_file = [par_expid '.k1'];
        else
            loc_str_file = [par_path '\' par_expid '.k1'];
        end
    case ('mask')
        if isempty(par_path),
            loc_str_file = [par_expid '.dat'];
        else
            loc_str_file = [par_path '\' par_expid '.dat'];
        end
    otherwise
        disp(['       ERROR: Impossible error!']);
        disp(['--------------------------------------------------------']);
        disp([' ']);
        return;
end
% Check for file existing ... :o)
% ... then load.
if (exist(loc_str_file, 'file') == 2)
    loc_k1 = load(loc_str_file);
else
    disp(['       ERROR: k1 file: ', par_expid, ' does not exist (at location ' par_path ').']);
    disp(['              Problem with correct extension? (k1 file extension must be .k1, and mask file .dat)']);
    disp(['--------------------------------------------------------']);
    disp([' ']);
    return;
end
%
% *** EXTRACT DATA ****************************************************** %
%
% determine size -- type comes from dummy parameter
% (k1 with border rows and columns, or simple land-sea mask)
% and adkust accordingly
switch par_gcm
    case ('k1')
        % extract core data
        gk1 = loc_k1(2:end-1,2:end-1);
    case ('mask')
        gk1 = loc_k1;
    otherwise
        % DO NOTHING!
end
% extract grid dimensions
% NOTE: not attempted to derive kmax yet ...
[jmax,imax] = size(gk1);
%
% *** DERIVE MASK ******************************************************* %
%
% NOTE: in k1: levels between 1 and 89 inclusive assumed ocean
% NOTE: in mask: ocean is already 1 (and land zero)
gm = zeros(jmax,imax);
gm(intersect(find(gk1<=89),find(gk1>=1))) = 1;
%
% *** RETURN ARRAYS ***************************************************** %
%
k1   = gk1;
mask = gm;
%
% *********************************************************************** %
% *** END *************************************************************** %
% *********************************************************************** %
