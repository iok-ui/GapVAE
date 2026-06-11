%% ¡header!
NNDataPoint_Structural < NNDataPoint (dp, structural data point) is a data point for structural regional data.

%%% ¡description!
A data point for structural regional data (NNDataPoint_Structural) contains both input and target for neural network analysis. The input is a feature vector of subject-level structural regional values. The target is obtained from the variables of interest associated with the data point.

%%% ¡seealso!
NNDataPoint_Image, NNDataPoint_Tabular, NNDataPoint_Graph_REG, NNDataPoint_Measure_REG, NNDataPoint_Measure_CLA, SubjectST

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the data point for structural regional data.
%%%% ¡default!
'NNDataPoint_Structural'

%%% ¡prop!
NAME (constant, string) is the name of the data point for structural regional data.
%%%% ¡default!
'Neural Network Data Point for Structural Regional Data'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the data point for structural regional data.
%%%% ¡default!
'A data point for structural regional data (NNDataPoint_Structural) contains both input and target for neural network analysis. The input is a feature vector of subject-level structural regional values. The target is obtained from the variables of interest associated with the data point.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the data point for structural regional data.
%%%% ¡settings!
'NNDataPoint_Structural'

%%% ¡prop!
ID (data, string) is a few-letter code for the data point for structural regional data.
%%%% ¡default!
'NNDataPoint_Structural ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the data point for structural regional data.
%%%% ¡default!
'NNDataPoint_Structural label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the data point for structural regional data.
%%%% ¡default!
'NNDataPoint_Structural notes'

%%% ¡prop!
INPUT (result, cell) is the input feature vector of structural regional values for this data point.
%%%% ¡calculate!
value = dp.get('FEATURES');

%%% ¡prop!
TARGET (result, cell) is the target value for this data point.
%%%% ¡calculate!
if isempty(dp.get('VOI_DICT').get('IT_LIST'))
    value = {};
else
    value = {dp.get('VOI_DICT').get('IT', dp.get('TARGET_NAME')).get('V')};
end

%% ¡props!

%%% ¡prop!
FEATURES (parameter, cell) is the feature vector of subject-level structural regional values representing this data point.

%%% ¡prop!
VOI_DICT (metadata, idict) contains the variables of interest associated with this data point.
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'VOI')
%%%% ¡gui!
pr = SubjectPP_VOIDict('EL', dp, 'PROP', NNDataPoint_Structural.VOI_DICT, varargin{:});

%%% ¡prop!
TARGET_NAME (metadata, string) is the name of the variable of interest used as the target.
%%%% ¡default!
'Age'
