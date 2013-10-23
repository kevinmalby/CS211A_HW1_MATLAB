function zeroCrossImages = zeroCrossings(derivativeImages)
    varThresh = 255;
    for i=1:length(derivativeImages)
       imageSize = size(derivativeImages{i});
       currentImage = padarray(derivativeImages{i}, [1,1], NaN, 'both');
       for row=2:imageSize(1)+1
           for column=2:imageSize(2)+1
               subset = currentImage(row-1:row+1,column-1:column+1);
               noNanSubset = subset(~isnan(subset));
               if(all(noNanSubset == subset(2,2)))
                   resultImage(row-1,column-1) = 0;
               else
                   resultImage(row-1,column-1) = varThresh;
               end
           end
       end
       zeroCrossImages{i} = resultImage;
    end
end