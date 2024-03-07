function GridOperations(grid, varargin)

    Type = 'Row';
    Operation = 'Add';

    for i = 1:2:length(varargin)
        switch varargin{i}
            case 'Operation'
                validOperations = {'Add', 'Delete'};
                Operation = validateInput(varargin{i+1}, validOperations, 'Operation');
            case 'Type'
                validTypes = {'Column', 'Row'};
                Type = validateInput(varargin{i+1}, validTypes, 'Type');
            otherwise
                error('Nieznany parametr: %s', varargin{i});
        end
    end
    switch Type
        case 'Row'
            applyOperation(grid, Operation, 'RowHeight');
        case 'Column'
            applyOperation(grid, Operation, 'ColumnWidth');
        otherwise
            error('Nieznany typ siatki.');
    end

    function validatedInput = validateInput(input, validOptions, paramName)
        if any(strcmp(input, validOptions))
            validatedInput = input;
        else
            error('Nieprawidłowa wartość dla parametru "%s".', paramName);
        end
    end
    function applyOperation(grid, operation, field)
        switch operation
            case 'Add'
                grid.(field)(end+1) = {'1x'};
            case 'Delete'
                if ~isempty(grid.(field))
                    grid.(field)(end) = [];
                else
                    error('Nie można usunąć z pustego pola.');
                end
            otherwise
                error('Nieznana operacja dla "%s".', field);
        end
    end
end
