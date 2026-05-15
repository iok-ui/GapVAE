%% ¡header!
NNDatasetProcess < ConcreteElement (dtran, processing for a neural network data) processes raw data into a neural network datasets.

%%% ¡description!
A dataset process (NNDatasetProcess) processes the raw data into a neural network dataset. 
 The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels.
 Instances of this class should not be created. Use one of its subclasses instead.

%%% ¡seealso!
NNDataset, NNDataPoint

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of processing data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess'

%%% ¡prop!
NAME (constant, string) is the name of processing data for a neural networks datasets.
%%%% ¡default!
'Processing for a Neural Network Dataset'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.
%%%% ¡default!
'The processing for a neural network dataset (NNDatasetProcess) processes the raw data into a neural network dataset. The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels. Instances of this class should not be created. Use one of its subclasses instead.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.
%%%% ¡settings!
'NNDatasetProcess'

%%% ¡prop!
ID (data, string) is a few-letter code of processing data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess notes'
    
%% ¡props!

%%% ¡prop!
D (result, item) processes the datapoints using preprocessing steps (e.g., normalization or standariaztion) and constructs a neural network dataset item for training a neural network model.
%%%% ¡settings!
'NNDataset'
%%%% ¡calculate!
value = NNDataset();
