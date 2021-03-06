function gaussCollection = gaussPyramid(I, f, ih, iw, fh, fw, bilInt, convert)
    resultImage = I;
    for picNum=1:log2(ih)
        imageSize = size(resultImage);
        if (convert == 1)
           resultImage = uint8(Convolve(resultImage, f, imageSize(1), imageSize(2), fh, fw));
        else
            resultImage = Convolve(resultImage, f, imageSize(1), imageSize(2), fh, fw);
        end
        gaussCollection{picNum} = resultImage;
    end
    
    if (bilInt == 1)
       for numImage=1:log2(ih)
           if (numImage ~= log2(ih))
               resultImage(:,:) = 0; 
               imageSize = size(gaussCollection{numImage});
               originalImageSize = size(gaussCollection{numImage});
               prevImage = gaussCollection{numImage};
               for timesPerImage=1:numImage
                   newRow = 1;
                   newCol = 1;
                   newSize = originalImageSize.*(2^timesPerImage);
                   for row=1:imageSize(1)
                       for column=1:imageSize(2)
                           if (column ~= imageSize(2))
                               resultImage(newRow, newCol) = prevImage(row, column);
                               resultImage(newRow,newCol+1) = mean(prevImage(row, column:column+1));
                           else
                               resultImage(newRow, newCol) = prevImage(row, column);
                               resultImage(newRow,newCol+1) = prevImage(row, column);
                           end
                           newCol = newCol + 2;
                       end
                       newCol = 1;
                       newRow = newRow + 2;
                   end
                   
                   for row=1:2:newSize(1)-1
                      for column=1:newSize(2)
                          if (row ~= (newSize(1)-1))
                              resultImage(row+1, column) = uint8((double(resultImage(row, column)) + double(resultImage(row+2, column)))/2);
                          else
                              resultImage(row+1, column) = resultImage(row, column);
                          end
                      end
                   end
                   prevImage = resultImage;
                   imageSize = imageSize.*2;
               end
               gaussCollection{numImage} = prevImage;
           else
               newImage = zeros(ih, iw);
               smallest = gaussCollection{numImage};
               newImage(:) = smallest(1);
               gaussCollection{numImage} = newImage;
           end
       end
    end
end