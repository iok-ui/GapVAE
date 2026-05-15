%% ¡header!
NNVariationalAutoencoderMLP < NNVariationalAutoencoder (nnvae, a neural-network variational autoencoder with a multilayer perceptron backbone) is a neural-network variational autoencoder with a multilayer perceptron (MLP) encoder/decoder.

%%% ¡description!
A neural-network variational autoencoder with a multilayer perceptron backbone (NNVariationalAutoencoderMLP) comprises an encoder and a decoder and is trained in an unsupervised manner to maximise the evidence lower bound (ELBO).
 The encoder outputs the parameters of a Gaussian latent distribution (mean μ and log-variance log σ²); a latent sample z is obtained via the reparameterisation trick and decoded back to the input space.
 Training minimises the negative ELBO, i.e., a reconstruction term plus a Kullback–Leibler divergence that regularises the approximate posterior towards a standard normal prior N(0, I).
 This subclass uses a multilayer perceptron (MLP) as the encoder/decoder backbone and trains on a neural-network dataset (NNDataset).

%%% ¡seealso!
NNDataset, NNDatasetSplit, NNVariationalAutoencoder, NNAutoencoder

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.ID
%%%% ¡title!
Variational Autoencoder ID

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.LABEL
%%%% ¡title!
Variational Autoencoder Label

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.SIZE_INPUT
%%%% ¡title!
Input Vector Size

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.NEURONS_PER_LAYER
%%%% ¡title!
Neuron Number per Layer

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.LEARN_RATE
%%%% ¡title!
Learning Rate

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.NUM_LATENT_REP
%%%% ¡title!
Latent Space Number 

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.EPOCHS
%%%% ¡title!
Epochs 

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.BATCH
%%%% ¡title!
Batch Size

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.TRAIN
%%%% ¡title!
Train

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderMLP.NOTES
%%%% ¡title!
Variational Autoencoder Notes

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural-network variational autoencoder (MLP).
%%%% ¡default!
'NNVariationalAutoencoderMLP'

%%% ¡prop!
NAME (constant, string) is the name of the neural-network variational autoencoder (MLP).
%%%% ¡default!
'Neural Network Variational Autoencoder (MLP)'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder (MLP).
%%%% ¡default!
'A neural-network variational autoencoder with a multilayer perceptron backbone (NNVariationalAutoencoderMLP) comprises an encoder and a decoder and is trained in an unsupervised manner to maximise the evidence lower bound (ELBO). The encoder outputs the parameters of a Gaussian latent distribution (mean μ and log-variance log σ²); a latent sample z is obtained via the reparameterisation trick and decoded back to the input space. Training minimises the negative ELBO, i.e., a reconstruction term plus a Kullback–Leibler divergence that regularises the approximate posterior towards a standard normal prior N(0, I). This subclass uses a multilayer perceptron (MLP) as the encoder/decoder backbone and trains on a neural-network dataset (NNDataset).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder (MLP).
%%%% ¡settings!
'NNVariationalAutoencoderMLP'

%%% ¡prop!
ID (data, string) is a few-letter code of the neural-network variational autoencoder (MLP).
%%%% ¡default!
'NNVariationalAutoencoderMLP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural-network variational autoencoder (MLP).
%%%% ¡default!
'NNVariationalAutoencoderMLP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder (MLP).
%%%% ¡default!
'NNVariationalAutoencoderMLP notes'

%%% ¡prop!
D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.
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
    nnvae.set('SIZE_INPUT', prod(size_input));
end

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.
%%%% ¡default!
{'NNDataPoint' 'NNDataPoint_RamanSpectra' 'NNDataPoint_Image'}

%%% ¡prop!
INPUTS (query, cell) constructs and returns the input matrix from dataset D by flattening each input to length SIZE_INPUT and stacking column-wise.
%%%% ¡calculate!
% inputs = nn.get('INPUTS', D) returns a cell/matrix of inputs for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
inputs_group = d.get('INPUTS');
if isempty(inputs_group)
    value = {};
else
    s1 = nnvae.get('SIZE_INPUT');
    flat_cells = cellfun(@(c) c{1}, inputs_group, 'UniformOutput', false);
    value = reshape(cat(1, flat_cells{:}), s1, []);
end

%%% ¡prop!
TARGETS (query, stringlist) constructs and returns the targets from dataset D (if applicable).
%%%% ¡calculate!
% targets = nn.get('TARGETS', D) returns targets for all data points in dataset D (if used).
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
SIZE_INPUT (parameter, rvector) is the size of the input data once flattened (scalar number of features).
%%%% ¡default!
784

%%% ¡prop!
ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.
%%%% ¡default!
2

%%% ¡prop!
MINIBATCH_FORMAT_INPUT (query, string) is a dlarray label string for input mini-batches (e.g., "CB"), used by minibatchqueue (MBQ).
%%%% ¡default!
'CB'

%%% ¡prop!
MINIBATCH_FORMAT_TARGET (query, string) is a dlarray label string for target mini-batches (may be empty), used by minibatchqueue (MBQ).
%%%% ¡default!
''

%%% ¡prop!
TRAIN (query, empty) configures an MLP encoder/decoder and then trains via the superclass to minimise LOSS_FN (negative ELBO) using a mini-batch loop.
%%%% ¡calculate!
% --- Set up ENCODER ---
% Retrieve hyperparameters
neurons = nnvae.get('NEURONS_PER_LAYER');
numLatentChannels = nnvae.get('NUM_LATENT_REP');
inputSize = nnvae.get('SIZE_INPUT');
numFeature = prod(inputSize);

if nnvae.isLocked('ENCODER')
    value = {};
    return
end

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
NEURONS_PER_LAYER (parameter, rvector) are the hidden-layer widths for the MLP encoder/decoder (mirrored in the decoder).
%%%% ¡default!
[64 64]

%% ¡tests!
