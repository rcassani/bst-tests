function strOut = test_hostinfo()
% TEST_HOSTINFO Retrieve the information on the OS and Matlab version of the host
%
% USAGE: test_hostinfo()
%
% OUTPUT:
%    - strOut : OS info : Matlab verision
%
% @=============================================================================
% 
% Copyright (c) University of Southern California & McGill University
% This software is distributed under the terms of the GNU General Public License
% as published by the Free Software Foundation. Further details on the GPLv3
% license can be found at http://www.gnu.org/copyleft/gpl.html.
% 
% FOR RESEARCH PURPOSES ONLY. THE SOFTWARE IS PROVIDED "AS IS," AND THE
% UNIVERSITY OF SOUTHERN CALIFORNIA AND ITS COLLABORATORS DO NOT MAKE ANY
% WARRANTY, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, NOR DO THEY ASSUME ANY
% LIABILITY OR RESPONSIBILITY FOR THE USE OF THIS SOFTWARE.
%
% For more information type "brainstorm license" at command prompt.
% =============================================================================@
%
% Authors: Raymundo Cassani, 2023

% OS information
if strncmp(computer,'PC',2)
    [~, system_info] = system('systeminfo');
    osName = regexp(system_info, '(?<=OS Name:)(.*?)(?=\n)', 'match');
    osName = strtrim(osName{1});
    osVer = regexp(system_info, '(?<=OS Version:)(.*?)(?=\n)', 'match');
    osVer = strtrim(osVer{1});
    osInfo = [osName, ' (', osVer, ')'];

elseif strncmp(computer,'MAC',3)
    % OS info
    [~, sw_vers] = system('sw_vers');
    osName = regexp(sw_vers, '(?<=ProductName:)(.*?)(?=\n)', 'match');
    osName = strtrim(osName{1});
    osVer = regexp(sw_vers, '(?<=ProductVersion:)(.*?)(?=\n)', 'match');
    osVer = strtrim(osVer{1});
    [~, osHw] = system('uname -m');
    osHw = strtrim(osHw);
    osInfo = [osName, ' ' osVer, ' (', osHw, ')'];

elseif strncmp(computer,'GLNX',4)
    % OS info
    os_release = fileread('/etc/os-release');
    osName = regexp(os_release, '(?<=PRETTY_NAME=")(.*?)(?=")', 'match');
    osName = osName{1};
    [~, kernelVer] = system('uname -r');
    kernelVer = strtrim(kernelVer);
    osInfo = [osName, ' (' kernelVer, ')'];

else
    osInfo = 'Strange host';
end

% Hostname
[~, hostName] = system('hostname');
hostName = [strtrim(hostName)];

% Get Matlab version
matlabVer = ['Matlab:', ' ', version('-release')];

% New content
strOut = [hostName ' : ', osInfo, ' : '  matlabVer];