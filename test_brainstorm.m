function test_brainstorm(bstTestName, bstUserName)
% TEST_BRAINSTORM Test Brainstorm by running tutorial scripts from scratch
%
% USAGE: test_brainstorm(testName, brainstormUsername)
%
% INPUTS:
%    - bstTestName  : Test to run, usually a script in the ./toolbox/scripts folder
%    - bstUserName  : Cell array of signals {[nSignals1, nSamples1], [nSignals2, nSamples2], ...}
%
% For a given bstTestName, the script does:
%    1. Download tutorial data (if needed)
%    2. Run tutorial script
%    3. Send report by email to bstUserName
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

% Parameters 
if nargin < 2 || isempty(bstUserName)
    bstUserName = '';
end

% Add path 'bst-tests' with support functions
% 'bst-tests' and 'brainstorm3' are expected at the same level
bstTestsDir = fullfile(fileparts(bst_get('BrainstormHomeDir')), 'bst-tests');
if (exist(bstTestsDir, 'dir') == 7)
    addpath(bstTestsDir);
else
    error('Dir ''bst-tests'' should be placed at the same level as ''brainstorm3'' ');
end

% Check that Brainstorm is run with local database
bstDbDir = bst_get('BrainstormDbDir');
if isempty(regexp(bstDbDir, 'local_db$', 'once'))
    warning('Run this script with brainstorm using local db');
    return
end

% Make a clean directory for data
tmpDir = bst_fullfile(pwd, 'tmpdir');
if (exist(tmpDir, 'dir') == 7)
    file_delete(tmpDir, 1, 3);
end
mkdir(tmpDir);
% Brainstorm FTP server
bstFtp = ftp('neuroimage.usc.edu');

switch bstTestName
    case 'tutorial_introduction'        
        % Downlaod and unzip data        
        tmpFtpFile = mget(bstFtp, '/pub/tutorials/sample_introduction.zip', tmpDir);
        bst_unzip(tmpFtpFile{:}, tmpDir);
        tutorial_introduction(tmpDir);
         
    case 'tutorial_connectivity'
        tutorial_connectivity();
                
end

% Host info
hostInfo = test_hostinfo();

% Sending email
% Process: Send report by email
bst_process('CallProcess', 'process_report_email', [], [], ...
    'username',   bstUserName, ...
    'cc',         '', ...
    'subject',    ['[Completed] ' bstTestName ' @ ' hostInfo], ...
    'reportfile', 'last', ...
    'full',       1);

% Stop Brainstorm
brainstorm stop
% Quit Matlab
exit
