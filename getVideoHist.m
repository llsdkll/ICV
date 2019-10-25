clear;clc; close all
videoObject = VideoReader('NewDatasetC.avi');

videoFrames = read(videoObject);
hists = zeros(1, 256, 3, videoObject.NumFrames);

disp('Calculating histograms...');
for frame=1:videoObject.NumFrames
    hists(1, :, :, frame) = icv_GetHist(videoFrames(:, :, :, frame));
    
    %pause(1/(8*videoObject.FrameRate));
end
disp('End of histograms calculation')

x = 0:255;
disp('Commencing playback')
for frame=1:videoObject.NumFrames
    subplot(2, 1, 1)
    imshow(videoFrames(:, :, :, frame))
    title('Original input')
    
    subplot(2, 1, 2)
    plot(x, hists(1, :, 1, frame), 'Red', x, hists(1, :, 2, frame), 'Green', x, hists(1, :, 3, frame), 'Blue')
    title('Histogram')
    pause(1/videoObject.FrameRate);
end
disp('End of playback')

disp('Executing the intersection of the histograms for the first two frames of the input sequence...');
% Get the histograms for the first two frames.
hst1 = hists(1, :, :, 1);
hst2 = hists(1, :, :, 2);

% Get the dimensions of one frame.
[nRows, nCols, nChannels] = size(videoFrames(:, :, :, 1));

% Calculate the similarity (intersection) of the two histograms
sim = icv_HistogramIntersection(hst1, hst2, nRows * nCols);
disp(['Intersection (RGB): ' num2str(sim(1)) ', ' num2str(sim(2)) ', ' num2str(sim(3))]);
% 
% Calculate the intersections for every frame of the sequence
for frame=1:videoObject.NumFrames-1
    % Current frame's histogram
    hist1 = hists(1, :, :, frame);
    % The next frame's histogram
    hist2 = hists(1, :, :, frame + 1);
    sim = icv_HistogramIntersection(hist1, hist2, nRows * nCols);
    disp(['Intersection of histogram of frame #' num2str(frame) ' and frame #' num2str(frame+1) ' is: ' ...
          ' R: ' num2str(sim(1)) ...
          ' G: ' num2str(sim(2)) ...
          ' B: ' num2str(sim(3))]);
end
