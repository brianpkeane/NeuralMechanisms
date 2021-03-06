% Mafigureke bar graphs of activation stats
clear all
showSubplots=1; % yes or no
close all

%% specify experiment to analyze, contour integration or visual shape completion.
exp='c';

if exp=='v'
    filename=load('/projects3/NeuralMech/data/results/GLM_viscomp/ActivationStats.mat');
elseif exp=='c'
    filename=load('/projects3/NeuralMech/data/results/GLM_contour/ActivationStats.mat');
end
struct=filename.sig_regions(1);
fields=fieldnames(struct);
xAxisLabels=struct.(fields{1});

for graphi=1:numel(fields)
    if graphi>1
        xx=struct.(fields{graphi});
       if showSubplots==1
            subplot(2,2,graphi-1)
       else 
           figure
       end
        bar(xx);
        set(gca,'xticklabel',xAxisLabels, 'tickLabelInterpreter','None');
        graphTitle=fields(graphi);
        title(graphTitle{1}, 'Interpreter','None');
        rotateXLabels( gca(), 45 );
    end
end

% Obtain the original glasser atlas to map your data/test statistics back onto
%  glasseratlas = '/projects/AnalysisTools/ParcelsGlasser2016/Q1-Q6_RelatedParcellation210.LR.CorticalAreas_dil_Colors.32k_fs_RL.dlabel.nii';
%  glasser0 = ciftiopen(glasseratlas,'wb_command');
%  glasser =glasser0.cdata;
%  nVertices = length(glasser);
% % 
% % % Create an empty array with the same number of vertices as the glasser atlas
%  num_statVars=1; % Look at FDR corrected regions only
%  glasser_stats = zeros(nVertices,num_statVars); % We're going to map your 'significant statistic' back onto this array. 
%  % Note that you can have more than one column if you wish (e.g., for t-statistic, p-values, etc.)
% % % Let's assume you have a 360x1 array, in which each element corresponds to the test-statistic of that ROI for your analysis
% % % Call this 'roi_statistic'
% % 
% % % There are 360 parcels in the glasser atlas. Each parcel is indicated by an index in the 'glasser array'
%  for roi=1:360
%      % Find the vertex indices for this ROI
%      % In your example, if you only have a single ROI (e.g., ROI 37) , you don't need a for loop and just can for "find(glasser==37)"
%      vertex_ind = find(glasser==roi);  % Will return an array of vertices that correspond to that ROI
%      % Map your ROI's statistic back onto the set of vertices on the Glasser surface
%      glasser_stats(vertex_ind,1) = roi_statistics(roi,1);
%  end
% % 
% % % Now you have "glasser_stats", an array of vertices that contains your test statistic of interest. 
% % % We now need to map it back to the surface. 
% outputcifti = glasser0; % Create a new cifti data type (using the original glasser atlas variable)
% outputcifti.cdata = glasser_stats; % Replace the data in the output cifti file with your statistics of interest 
% 
% %% Now write out the a 'dscalar file' 
%  outputfilename = 'FDRvals.dscalar'; % you can change this name as you wish
%  ciftisavereset(outputcifti, outputfilename, 'wb_command')    
