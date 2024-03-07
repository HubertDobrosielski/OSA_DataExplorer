function fittedSignal = fitCurve(signal,threshold)
    % fourierTransform = fft(signal);
    % threshold_amplitude = threshold;
    % % threshold_amplitude = (threshold/500) * max(abs(fourierTransform));
    % 
    % fourierTransform(abs(fourierTransform) < threshold_amplitude) = 0;
    % fittedSignal = ifft(fourierTransform);

    window_size = threshold;
    % fittedSignal = medfilt1(signal, window_size);
    fittedSignal = smooth(signal, window_size,"moving");

    for i = 1:window_size
        fittedSignal = medfilt1(fittedSignal, window_size);
    end


    % fourierTransform = fft(signal);
    % [~,index] = mink(abs(fourierTransform),round(length(fourierTransform)*0.99));
    % fourierTransform(abs(fourierTransform) < max(abs(fourierTransform(index)))) = 0;
    % fittedSignal = ifft(fourierTransform);

    % fourierTransform = fft(signal);
    % fourierTransform(abs(fourierTransform) < mean(fourierTransform)*threshold) = 0;
    % fittedSignal = ifft(fourierTransform);
end