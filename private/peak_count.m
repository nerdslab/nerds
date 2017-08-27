function peak_counts = peak_count(ephys_signal, fluorescent)
% function to count peaks of physiology signal
% this function will call findpeaks_ephys function
%input: ephys_signal - read physiology signal (lx1 vector)
%       fluorescent - fluorescent signal (data in row format mxn matrix)

l = length(ephys_signal);
[m, n] = size(fluorescent);
bin_len = floor(l/n);           % total number of bins
peak_dist = 20;                 % default peak distance 
threshold = min(ephys_signal)+floor((max(ephys_signal)-min(ephys_signal))/2);

id = 'signal:findpeaks:largeMinPeakHeight';
warning('off', id)  % suppress warning

peak_counts = zeros(n, 1);       % length equal to column of flo matrix
for i = 1:n
    [~, idx] = findpeaks_ephys(ephys_signal((i-1)*bin_len+1: i*bin_len), ...
                                 peak_dist, threshold);
    peak_counts(i) = length(idx); % number of peak found
end

warning('on',id) % turn warning back again

end


function [val, idx] = findpeaks_ephys(signal, peak_dist, threshold)
% input: signal - 1D signal data either column or row format
%        peak_dist - minimum peak distance parameter in findpeaks function
%        threshold - find peak only above threshold

if nargin<3
    threshold = min(signal)+floor((max(signal)-min(signal))/2);
end

if nargin<2
    peak_dist = 10;
end

[val, idx] = findpeaks(double(signal),'MinPeakDistance', peak_dist, ...
                                      'MinPeakHeight',floor(max(signal)/2));
                                  
end


