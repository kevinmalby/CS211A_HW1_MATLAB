function segmentedEdgePyramid = SegmentImageDerivative(gaussPyramid)
    varThresh = 255;
    f = [-1/8 -1/8 -1/8; -1/8 1 -1/8; -1/8 -1/8 -1/8];
    for i=1:length(gaussPyramid)
        currentSize = size(gaussPyramid{i});
        currentImage = gaussPyramid{i};
        currentImage = Convolve(currentImage, f, currentSize(1), currentSize(2), 3, 3);
        currentImage(currentImage <= 0) = 0;
        currentImage(currentImage > 0) = varThresh;
        segmentedEdgePyramid{i} = currentImage;
    end
end