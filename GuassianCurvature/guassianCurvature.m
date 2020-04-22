% @Khristian Jones
% Subzero Lab, Montana State University
% Feb 2020


% This script is used to calculate the guassian curvature of STL files
% This code has not been optimized in any way 

% This function requires the use of several matlab scripts: 
% For STL file parsing: 
% stlread.m

% For GausianCurvature calculation: 
% CalcCurvature.m
% CalcCurvatureDerivatie.m
% CalcFaceNormals.m
% CalcVertexNormals.m
% GetCurvatures.m
% getPrincipalCurvatures.m
% ProjectCTensor.m
% ProjectCurvatureTensor.m
% RotateCoordinateSystem.m

% All GausianCurvatue scripts written by Itzik Ben Shabat 

clear all 
clear workspace


%File name here 
filename = 'test1.stl'

% Read in the stl file as a trinagulation struct 
triangulationStruct = stlread(filename);

% Creates new struct from triangulation of faces and vertices 
FV.faces = triangulationStruct.ConnectivityList;
FV.vertices = triangulationStruct.Points;


% This variable will indicating wether or not to calcualte curvature derivatives
% RECOMMENDED TO KEEP AT 0, otherwise it will take a LONG time 
getderivatives=0;  

%Will return the PrincipalCurvatures. If getDeriatives = 1, will return
%FaceCMatrix, VertexCMatrix, and Cmagnitude (
[PrincipalCurvatures,PrincipalDir1,PrincipalDir2,FaceCMatrix,VertexCMatrix,Cmagnitude]= GetCurvatures(FV ,getderivatives);

%Multiplies the principal curvatures together to get the GausianCurvature
GausianCurvature=PrincipalCurvatures(1,:).*PrincipalCurvatures(2,:);

MeanCurvature=(PrincipalCurvatures(1,:)+PrincipalCurvatures(2,:))/2; % Mean curvature 

%% 


MV = stl_z_parser(FV, GausianCurvature, MeanCurvature);  % Face-Vertex Structure and Gaussian Curvature 

