function resultImage = Convolve(I, f, ih, iw, fh, fw)
    image = I;
    
    zeroRows = floor(fw/2);
    if (mod(fw, 2) == 1)
       paddedImage = padarray(image, [zeroRows, zeroRows], 'both');
    else
        paddedImage = image;
        zeroRows = 0;
    end
    
    if (zeroRows ~= 0)
        for row=1+zeroRows:ih + zeroRows
           for column=1+zeroRows:iw + zeroRows
               selectionArea = double(paddedImage(row-zeroRows:row+zeroRows,column-zeroRows:column+zeroRows));
               productMatrix = selectionArea.*f;
               newPixel = sum(productMatrix(:));
               resultImage(row-zeroRows, column-zeroRows) = newPixel;
           end
        end
    else
        newRow = 1;
        for row=1:fh:ih-1
           newColumn = 1;
           for column=1:fw:iw-1
               selectionArea = double(paddedImage(row:row + fh/2, column:column + fw/2));
               productMatrix = selectionArea.*f;
               newPixel = sum(productMatrix(:));
               resultImage(newRow, newColumn) = newPixel;
               
               if (newColumn == iw / fw)
                   newRow = newRow + 1;
                   newColumn = 1;
               else
                   newColumn = newColumn + 1;
               end
           end
        end
    end
    
    
    resultImage = resultImage;
    
end