function [laplaceImagesTMB, laplaceImagesBMT] = LaplacianPyramid(gaussPyramid)
    for i=1:length(gaussPyramid)-1
       laplaceImagesTMB{i} = uint8(gaussPyramid{i}) - uint8(gaussPyramid{i+1});
       laplaceImagesBMT{i} = uint8(gaussPyramid{i+1}) - uint8(gaussPyramid{i});
    end
end