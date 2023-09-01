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
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_introduction.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_introduction(tmpDir);

    case 'tutorial_connectivity'
        tutorial_connectivity();

    case 'tutorial_coherence'
        tmpDwnFile = bst_fullfile(tmpDir, 'SubjectCMC.zip');
        bst_websave(tmpDwnFile, 'https://download.fieldtriptoolbox.org/tutorial/SubjectCMC.zip');
        bst_unzip(tmpDwnFile, bst_fullfile(tmpDir, 'SubjectCMC'));
        tutorial_coherence(tmpDir);

    case 'tutorial_ephys'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_ephys.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_ephys(tmpDir);

    case 'tutorial_epilepsy'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_epilepsy.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_epilepsy(tmpDir);

    case 'tutorial_epileptogenicity'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/tutorial_epimap_bids.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_epileptogenicity(tmpDir);

%     case 'tutorial_fem_charm'
%         % REQUIRES TO INSTALL SimNIBS
%         tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_fem.zip', tmpDir);
%         bst_unzip(tmpDwnFile{:}, tmpDir);
%         tutorial_fem_charm(tmpDir);

    case 'tutorial_fem_tensors'
        tmpDwnFile = bst_fullfile(tmpDir, 'BrainSuiteTutorialSVReg.zip');
        bst_websave(tmpDwnFile, 'http://brainsuite.org/WebTutorialData/BrainSuiteTutorialSVReg_Sept16.zip');
        bst_unzip(tmpDwnFile, tmpDir);
        tmpDwnFile = bst_fullfile(tmpDir, 'DWI.zip');
        bst_websave(tmpDwnFile, 'http://brainsuite.org/WebTutorialData/DWI_Feb15.zip');
        bst_unzip(tmpDwnFile, tmpDir);
        tutorial_fem_tensors(tmpDir);

%     case 'tutorial_frontiers2018'
%         % REQUIRES TO DOWNLOAD ~100GB https://openneuro.org/datasets/ds000117
%         tutorial_frontiers2018(tmpDir);

%     case 'tutorial_visual'
%         % REQUIRES TO DOWNLOAD ~100GB https://openneuro.org/datasets/ds000117
%         tutorial_visual(tmpDir);

%     case 'tutorial_hcp'
%         % REQUIRES TO DOWNLOAD ~20GB  HCP-MEG2 distribution: subject #175237
%         tutorial_hcp(tmpDir);

    case 'tutorial_neuromag'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_neuromag.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_neuromag(tmpDir);

%     case 'tutorial_omega'
% %         % REQUIRES TO DOWNLOAD ~12GB  https://openneuro.org/datasets/ds000247
%         tutorial_omega(tmpDir);

    case 'tutorial_phantom_ctf'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_phantom_ctf.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_phantom_ctf(tmpDir);

    case 'tutorial_phantom_elekta'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_phantom_elekta.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_phantom_elekta(tmpDir);

    case 'tutorial_practicalmeeg'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/tutorial_practicalmeeg.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_practicalmeeg(bst_fullfile(tmpDir, 'tutorial_practicalmeeg'));

    case 'tutorial_raw'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_raw.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_raw(tmpDir);

    case 'tutorial_resting'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_resting.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_resting(tmpDir);

    case 'tutorial_simulations'
        tutorial_simulations();

    case 'tutorial_yokogawa'
        tmpDwnFile = mget(bstFtp, '/pub/tutorials/sample_yokogawa.zip', tmpDir);
        bst_unzip(tmpDwnFile{:}, tmpDir);
        tutorial_yokogawa(tmpDir);

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
