function dataFullFile = get_tutorial_data(dataDir, dataFile, bstUserName, bstPwd)

%% ===== GET FILE =====
% Prepare the data file to run the tutorial
% Download if needed and credentials are provided
dataFullFile = bst_fullfile(dataDir, dataFile);
% Try to download if file does not exist
if ~exist(dataFullFile, 'file')
    if ~isempty(bstUserName) && ~isempty(bstPwd)
        dwnUrl = sprintf('http://neuroimage.usc.edu/bst/download.php?file=%s&user=%s&mdp=%s', ...
                         urlencode(dataFile), urlencode(bstUserName), urlencode(bstPwd));
        dataFullFile = bst_fullfile(dataDir, dataFile);
        errMsg = bst_websave(dataFullFile, dwnUrl);
        % Return if error
        if ~isempty(errMsg) || ~exist(dataFullFile, 'file')
            dataFullFile = '';
            return
        end
    else
        dataFullFile = '';
        return
    end
end
% Check size, if less than 50 bytes, error with the downloaded file
d = dir(dataFullFile);
if d.bytes < 50
    dataFullFile = '';
    return
end
