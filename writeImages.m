function [] = writeImages(imagePath, imageName)
    currentImage = imread(imagePath);
    sizeCurImage = size(currentImage);
    gaussF = [1/4 1/4; 1/4 1/4];
    laplaceF = [-1/8 -1/8 -1/8; -1/8 1 -1/8; -1/8 -1/8 -1/8];
    
    gaussPyramidImagesReduced = gaussPyramid(currentImage, gaussF, sizeCurImage(1), sizeCurImage(2), 2, 2, 0, 1);
    gaussPyramidImagesSame = gaussPyramid(currentImage, gaussF, sizeCurImage(1), sizeCurImage(2), 2, 2, 1, 1);
    gaussPyramidImagesSameNonCast = gaussPyramid(currentImage, gaussF, sizeCurImage(1), sizeCurImage(2), 2, 2, 1, 0);
    [laplaceImagesTMB, laplaceImagesBMT] = LaplacianPyramid(gaussPyramidImagesSame);
    secondDerImages = SegmentImageDerivative(gaussPyramidImagesSameNonCast);
    zeroCrossImages = zeroCrossings(secondDerImages);
    varThreshImages = VarianceThreshold(zeroCrossImages, secondDerImages, 18000);
    
    for i=1:length(gaussPyramidImagesSame)
       imwrite(gaussPyramidImagesReduced{i},strcat('C:\Users\kevin\UCI Fall 2013\CS211A\HW1\gaussReduced\',imageName,'_',num2str(i),'.jpg'), 'jpg');
       imwrite(gaussPyramidImagesSame{i},strcat('C:\Users\kevin\UCI Fall 2013\CS211A\HW1\gaussSameSize\',imageName,'_',num2str(i),'.jpg'), 'jpg');
       imwrite(secondDerImages{i},strcat('C:\Users\kevin\UCI Fall 2013\CS211A\HW1\secondDerivative\',imageName,'_',num2str(i),'.jpg'), 'jpg');
       imwrite(zeroCrossImages{i},strcat('C:\Users\kevin\UCI Fall 2013\CS211A\HW1\zeroCrossing\',imageName,'_',num2str(i),'.jpg'), 'jpg');
       imwrite(varThreshImages{i},strcat('C:\Users\kevin\UCI Fall 2013\CS211A\HW1\varianceThreshold\',imageName,'_',num2str(i),'.jpg'), 'jpg');
       if (i < length(laplaceImagesTMB) + 1)
          imwrite(laplaceImagesTMB{i},strcat('C:\Users\kevin\UCI Fall 2013\CS211A\HW1\laplaceTopMBottom\',imageName,'_',num2str(i),'.jpg'), 'jpg');
          imwrite(laplaceImagesBMT{i},strcat('C:\Users\kevin\UCI Fall 2013\CS211A\HW1\laplaceBottomMTop\',imageName,'_',num2str(i),'.jpg'), 'jpg');
       end
    end
end