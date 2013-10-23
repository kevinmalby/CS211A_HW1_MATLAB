function varThreshImages = VarianceThreshold(zeroCrossImages, secondDerImages, threshold)
    varZeroVal = 255;
    for i=1:length(zeroCrossImages)
        currentSecondDer = padarray(secondDerImages{i}, [1,1], NaN, 'both');
        currentZeroCross = zeroCrossImages{i};
        czc = size(currentZeroCross);
       for row=2:length(currentZeroCross) + 1
           for column=2:length(currentZeroCross) + 1
               if (currentZeroCross(row-1, column-1) == varZeroVal)
                   subset = currentSecondDer(row-1:row+1, column-1:column+1);
                   noNanSubset = subset(~isnan(subset));
                   varSubset = var(noNanSubset);
                   if (varSubset > threshold)
                      resultImage(row-1, column-1) = 255; 
                   end
               else
                   resultImage(row-1, column-1) = 0;
               end
           end
       end
       varThreshImages{i} = resultImage;
    end
end