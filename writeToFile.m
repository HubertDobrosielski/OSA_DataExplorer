function writeToFile(data, outputPath)
    fid = fopen(outputPath, 'w');
    for i = 1:length(data)
        fprintf(fid, '%s\n', data{i});
    end
    fclose(fid);
end