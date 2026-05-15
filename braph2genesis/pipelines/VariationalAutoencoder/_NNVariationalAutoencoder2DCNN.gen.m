%% ¡header!
NNVariationalAutoencoder2DCNN < NNVariationalAutoencoder (nnvae, normalizer of a neural network data) transfroms neural network datasets.

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
'NNVariationalAutoencoder2DCNN'

%%% ¡prop!
NAME (constant, string) is the name of the combiner of neural networks datasets.
%%%% ¡default!
'Neural Network Variational Autoencoders with 2D CNN'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.
%%%% ¡default!
'A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. The resulting combined dataset contains all the unique datapoints from the input datasets, and any overlapping datapoints are excluded to ensure data consistency.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.
%%%% ¡settings!
'NNVariationalAutoencoder2DCNN'

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
    if isequal(length(size(input_data)), 2) % if only 1 channel
        size_input = [size(input_data) 1]; % force it to be length, width, channel
    else
        size_input = size(input_data);
    end
    nnvae.set('SIZE_INPUT', size_input);
end

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data points.
%%%% ¡default!
{'NNDataPoint' 'NNDataPoint_Image'}

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
    [s1, s2] = size(cell2mat(inputs_group{1}));
    % Extract the h x w arrays from the inner cells
    flat_cells = cellfun(@(c) c{1}, inputs_group, 'UniformOutput', false);
    value = reshape(cat(3, flat_cells{:}), s1, s2, 1, []);
end

%%% ¡prop!
TARGETS (query, cell) constructs the cell array of the targets.
%%%% ¡calculate!
% targets = nn.get('PREDICT', D) returns a cell array with the
%  targets for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
targets_group = d.get('TARGETS');
if isempty(targets_group)
    value = {};
else
    flat_cells = cellfun(@(c) c{1}, targets_group, 'UniformOutput', false);
    value = cat(1, flat_cells{:});
end

%%% ¡prop!
SIZE_INPUT (parameter, rvector) is the size of the input image.
%%%% ¡default!
[28 28 1]

%%% ¡prop!
ITERATION_DIM (parameter, scalar) is the iteration dimension.
%%%% ¡default!
4

%%% ¡prop!
MINIBATCH_FORMAT_INPUT (query, string) returns the elbo loss.
%%%% ¡default!
'SSCB'

%%% ¡prop!
MINIBATCH_FORMAT_TARGET (query, string) returns the elbo loss.
%%%% ¡default!
''

%%% ¡prop!
TRAIN (query, empty) trains the neural network model with the given dataset.
%%%% ¡calculate!
% --- Set up ENCODER ---
% Retrieve hyperparam
channels = nnvae.get('CHANNELS_PER_LAYER');
size_filter = nnvae.get('SIZE_FILTER');
strides = nnvae.get('STRIDE_PER_LAYER');
numLatentChannels = nnvae.get('NUM_LATENT_REP');
inputSize = nnvae.get('SIZE_INPUT');

if nnvae.isLocked('ENCODER')
    value = {};
    return
end

% Define layers
layersE = [
    imageInputLayer(inputSize, Normalization="none")
    ];
for i = 1:length(channels)
    c = channels(i);
    s = strides(i);
    layersE = [
        layersE
        convolution2dLayer(size_filter, c, Padding="same", Stride=s)
        leakyReluLayer(0.2)
        ];
end
layersE = [
    layersE
    flattenLayer
    fullyConnectedLayer(2*numLatentChannels, Name="latentOutput")
    samplingLayer
    ];
nnvae.set('ENCODER', dlnetwork(layersE));

% --- Set up DECODER ---
% Retrieve decoder hyperparameters (mirroring encoder)
% Last convolution's output channels = projection depth
projectChannels = channels(end); 
s_end = strides(end); % comes from encoder, the last convolutional layer
num_stride = length(strides);
projSize = inputSize(1:num_stride);
for i = 1:num_stride % two strides in 2 layers
    projSize = ceil(projSize / strides(i));
end
projectionSize = [projSize projectChannels];
numInputChannels = inputSize(3);
numLatentChannels = nnvae.get('NUM_LATENT_REP');

% Define layers
layersD = [
    featureInputLayer(numLatentChannels)
    fullyConnectedLayer(prod(projectionSize))
    leakyReluLayer(0.2)
    projectAndReshapeLayer(projectionSize)
    ];
for i = length(channels):-1:1
    c = channels(i);
    s = strides(i);
    layersD = [
        layersD
        transposedConv2dLayer(size_filter, c, Cropping="same", Stride=s)
        leakyReluLayer(0.2)
        ];
end
layersD = [
    layersD
    transposedConv2dLayer(size_filter, numInputChannels, Cropping="same")
    sigmoidLayer
    ];
nnvae.set('DECODER', dlnetwork(layersD));

value = calculateValue@NNVariationalAutoencoder(nnvae, prop);

%% ¡props!

%%% ¡prop!
CHANNELS_PER_LAYER (parameter, rvector) is the size of the input image.
%%%% ¡default!
[32 64]

%%% ¡prop!
SIZE_FILTER (parameter, rvector) is the size of the input image.
%%%% ¡default!
[3 3]

%%% ¡prop!
STRIDE_PER_LAYER (parameter, rvector) is the size of the input image.
%%%% ¡default!
[2 2]

%% ¡tests!
