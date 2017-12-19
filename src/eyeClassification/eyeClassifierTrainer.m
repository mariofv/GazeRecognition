%% Cleans console and Workspace

clc;
clear;

%% Creates a classifier for detecting images with eyes

% Loads the features of the training dataset
load('..\..\data\datasetFeatures.mat');

% Creates the classifier 
classifierTreeBagger = TreeBagger(200, trainingFeatures, trainingClasses); % TreeBagger

%% Saves the classifier
save('../../data/eyeClassifier.mat', 'classifierTreeBagger'); 
