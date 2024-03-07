
% [filename, pathname] = uigetfile('*.csv', 'Select CSV file');

function Traces = getTofDataFromCsvFile(fileName)
    % extractTableDataFromOsaCsvFile(filePath, fileName);
    fileFullPath = fullfile('dataInfo/measurementData', fileName);
    warning off
    DataTable = readtable(fileFullPath);
    warning on
    numOfTraces = length(DataTable.Properties.VariableNames) / 2;
    Traces = cell(1, numOfTraces);
    for T = 1:numOfTraces
        Trace = struct();
        Trace.name = DataTable.Properties.VariableNames{T*2};
        Wavelength = DataTable(:,T*2-1).Variables;
        Level = DataTable(:,T*2).Variables;
        % [minI,maxI] = getWavelengthRange(Wavelength,1460,1625);
        % Trace.Wavelength = Wavelength(minI:maxI);
        % Trace.Level = Level(minI:maxI);

        Trace.Wavelength = Wavelength;
        Trace.Level = Level;
        Traces{T} = Trace;
    end
end
