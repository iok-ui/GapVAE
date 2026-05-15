%% ¡header!
NNVariationalAutoencoderMLP < NNVariationalAutoencoder (nnvae, normalizer of a neural network data) transfroms neural network datasets.

%%% ¡description!
A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. 
The resulting combined dataset contains all the unique datapoints from the input datasets, 
and any overlapping datapoints are excluded to ensure data consistency.

%%% ¡seealso!
NNDataset, NNDatasetSplit

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the combiner of neural networks datasets.
%%%% ¡default!
'NNVariationalAutoencoderMLP'

%%% ¡prop!
NAME (constant, string) is the name of the combiner of neural networks datasets.
%%%% ¡default!
'Neural Network Variational Autoencoders'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.
%%%% ¡default!
'A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. The resulting combined dataset contains all the unique datapoints from the input datasets, and any overlapping datapoints are excluded to ensure data consistency.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.
%%%% ¡settings!
'NNVariationalAutoencoderMLP'

%%% ¡prop!
ID (data, string) is a few-letter code of the combiner of neural networks datasets.
%%%% ¡default!
'NNDatasetCombine ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the combiner of neural networks datasets.
%%%% ¡default!
'NNDatasetCombine label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes of the combiner of neural networks datasets.
%%%% ¡default!
'NNDatasetCombine notes'

%%% ¡prop!
D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
%%%% ¡settings!
'NNDataset'
%%%% ¡default!
NNDataset('DP_CLASS', 'NNDataPoint')
%%%% ¡check_value!
check = ismember(value.get('DP_CLASS'), nnvae.get('DP_CLASSES'));
%%%% ¡postset!
if ~isequal(nnvae.get('D').get('DP_DICT').get('LENGTH'), 0)
    input_data = cell2mat(nnvae.get('D').get('DP_DICT').get('IT', 1).get('INPUT'));
    size_input = size(input_data);
    nnvae.set('SIZE_INPUT', size_input);
end

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data points.
%%%% ¡default!
{'NNDataPoint' 'NNDataPoint_RamanSpectra' 'NNDataPoint_Image'}

%%% ¡prop!
INPUTS (query, cell) constructs the cell array of the data.
%%%% ¡calculate!
% inputs = nn.get('inputs', D) returns a cell array with the
%  inputs for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
inputs_group = d.get('INPUTS');
if isempty(inputs_group)
    value = {};
else
    %[s1, s2] = size(cell2mat(inputs_group{1}));
    s1 = nnvae.get('SIZE_INPUT');
    flat_cells = cellfun(@(c) c{1}, inputs_group, 'UniformOutput', false);
    value = reshape(cat(1, flat_cells{:}), s1, []);
end

%%% ¡prop!
TARGETS (query, stringlist) constructs the cell array of the targets.
%%%% ¡calculate!
% targets = nn.get('PREDICT', D) returns a cell array with the
%  targets for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
targets = cellfun(@(dp) dp.get('TARGET_CLASS'), d.get('DP_DICT').get('IT_LIST'), 'UniformOutput', false)
if isempty(targets)
    value = {};
else
    flat_cells = cellfun(@(c) c{:}, targets, 'UniformOutput', false);
    value = cat(1, flat_cells{:}); % check
end

%%% ¡prop!
SIZE_INPUT (parameter, rvector) is the size of the input image.
%%%% ¡default!
784

%%% ¡prop!
ITERATION_DIM (parameter, scalar) is the iteration dimension.
%%%% ¡default!
2

%%% ¡prop!
MINIBATCH_FORMAT_INPUT (query, string) returns the elbo loss.
%%%% ¡default!
'CB'

%%% ¡prop!
MINIBATCH_FORMAT_TARGET (query, string) returns the elbo loss.
%%%% ¡default!
''

%%% ¡prop!
TRAIN (query, empty) trains the neural network model with the given dataset.
%%%% ¡calculate!
% --- Set up ENCODER ---
% Retrieve hyperparam
neurons = nnvae.get('NEURONS_PER_LAYER');
numLatentChannels = nnvae.get('NUM_LATENT_REP');
inputSize = nnvae.get('SIZE_INPUT');
numFeature = prod(inputSize);

% Define layers
layersE = [
    featureInputLayer(numFeature, Normalization="none")
    ];
for i = 1:length(neurons)
    n = neurons(i);
    layersE = [
        layersE
        fullyConnectedLayer(n)
        reluLayer
        ];
end
layersE = [
    layersE
    fullyConnectedLayer(2*numLatentChannels, Name="latentOutput")
    samplingLayer
    ];
nnvae.set('ENCODER', dlnetwork(layersE));

% --- Set up DECODER ---
% Define layers
layersD = [
    featureInputLayer(numLatentChannels, Normalization="none")
    ];
for i = length(neurons):-1:1
    n = neurons(i);
    layersD = [
        layersD
        fullyConnectedLayer(n)
        reluLayer
        ];
end
layersD = [
    layersD
    fullyConnectedLayer(numFeature)
    leakyReluLayer(1)
    ];
nnvae.set('DECODER', dlnetwork(layersD));

value = calculateValue@NNVariationalAutoencoder(nnvae, prop);

%% ¡props!
%%% ¡prop!
NEURONS_PER_LAYER (parameter, rvector) is the size of the input image.
%%%% ¡default!
[64 64]

%% ¡tests!
