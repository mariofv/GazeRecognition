% Features extractor, extracts features from given images.
classdef featureExtractorGaze
       
   methods
      function obj = featureExtractorGaze()
      end
      
      % Given an array of images it returns an array with the features of
      % that images
      function features = extractFeatures(obj,images)
        [rows,cols,numImages] = size(images);
        HOGFeatures = extractHOGFeatures(images(1:64,1:64,1),'CellSize',[16 16],'BlockSize',[3 3],'NumBins',10);
        [~,HOGsize] = size(HOGFeatures);
        features = zeros([numImages, rows+cols+HOGsize]);
        parfor i = 1:numImages
            imageMean = sum(sum(images(:,:,i)))/(rows*cols);
            
            % This feature is the substraction of the sum of 
            % every row of the image with the mean of the whole image.
            rowMeanFeatures = sum(images(:,:,i)) - imageMean;
            
            % This feature is the substraction of the sum of 
            % every column of the image with the mean of the whole image.
            colMeanFeatures = sum(images(:,:,i),2)' - imageMean;
            
            % HOG features
            HOGFeatures = extractHOGFeatures(images(:,:,i),'CellSize',[16 16],'BlockSize',[3 3],'NumBins',10);
            
            features(i,:) = [rowMeanFeatures, colMeanFeatures, HOGFeatures];    
        end
      end
      
      function features = extractFeaturesHOG(obj,images)
        [~,~,numImages] = size(images);
        HOGFeatures = extractHOGFeatures(images(:,:,1),'CellSize',[16 16],'BlockSize',[3 3],'NumBins',10);
        [~,HOGsize] = size(HOGFeatures);
        features = zeros([numImages, HOGsize]);
        parfor i = 1:numImages
            % HOG features
            HOGFeatures = extractHOGFeatures(images(:,:,i),'CellSize',[16 16],'BlockSize',[3 3],'NumBins',10);
            
            features(i,:) = [HOGFeatures];    
        end
      end

    function features = extractFeaturesTesting(obj,images,cell,block,bin)
        [rows,cols,numImages] = size(images);
      	HOGFeatures = extractHOGFeatures(images(1:64,1:64,1),'CellSize',[cell cell],'BlockSize',[block block],'NumBins',bin);
      	[~,HOGsize] = size(HOGFeatures);
      	features = zeros([numImages, rows+cols+HOGsize]);
      	parfor i = 1:numImages
        	imageMean = sum(sum(images(:,:,i)))/(rows*cols);

            % This feature is the substraction of the sum of 
            % every row of the image with the mean of the whole image.
            rowMeanFeatures = sum(images(:,:,i)) - imageMean;

            % This feature is the substraction of the sum of 
            % every column of the image with the mean of the whole image.
            colMeanFeatures = sum(images(:,:,i),2)' - imageMean;

            % HOG features
            HOGFeatures = extractHOGFeatures(images(:,:,i),'CellSize',[cell cell],'BlockSize',[block block],'NumBins',bin);

            features(i,:) = [rowMeanFeatures, colMeanFeatures, HOGFeatures];  
       	end
      end

   end
end