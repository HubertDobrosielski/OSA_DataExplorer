function extractDataFromOSA(folderPath, fileName)
    filePath = fullfile(folderPath, fileName);

    fid = fopen(filePath, 'r');
    data = textscan(fid, '%s', 'Delimiter', '\n');
    fclose(fid);
    
    lines = data{1};
    
    emptyLinesIndices = find(cellfun(@isempty, lines))';
    
    if numel(emptyLinesIndices) >= 2

        fileData = lines(1:emptyLinesIndices(1)-1);
        traceData = lines(emptyLinesIndices(1):emptyLinesIndices(2)-1);
    
        if numel(emptyLinesIndices) == 2
            measurementData = lines(emptyLinesIndices(2):end);
            markerData = []; % Brak danych dla markera
        elseif numel(emptyLinesIndices) == 3
            measurementData = lines(emptyLinesIndices(2):emptyLinesIndices(3)-1);
            markerData = lines(emptyLinesIndices(3):end);
        end
    
        mainFolderPath = 'dataInfo';
        if ~exist(mainFolderPath, 'dir')
            mkdir(mainFolderPath);
        end
        subfolders = {'markerData', 'measurementData', 'traceData', 'fileData'};
        for i = 1:length(subfolders)
            currentSubfolderPath = fullfile(mainFolderPath, subfolders{i});
            if ~exist(currentSubfolderPath, 'dir')
                mkdir(currentSubfolderPath);
            end
        end

        fileOutputPath = fullfile(mainFolderPath,'fileData', fileName);
        traceOutputPath = fullfile(mainFolderPath,'traceData', fileName);
        measurementOutputPath = fullfile(mainFolderPath,'measurementData', fileName);
        markerOutputPath = fullfile(mainFolderPath,'markerData', fileName);
    
        writeToFile(fileData, fileOutputPath);
        writeToFile(traceData, traceOutputPath);
        writeToFile(measurementData, measurementOutputPath);
        writeToFile(markerData, markerOutputPath);
    
    else
        error('Za mało pustych linii w pliku.');
    end
end