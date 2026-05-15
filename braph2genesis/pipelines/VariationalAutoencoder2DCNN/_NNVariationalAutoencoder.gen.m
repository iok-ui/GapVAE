%% ¡header!
NNVariationalAutoencoder < NNBase (nnvae, normalizer of a neural network data) transfroms neural network datasets.

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
'NNVariationalAutoencoder'

%%% ¡prop!
NAME (constant, string) is the name of the combiner of neural networks datasets.
%%%% ¡default!
'Neural Network Autoencoder'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.
%%%% ¡default!
'A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. The resulting combined dataset contains all the unique datapoints from the input datasets, and any overlapping datapoints are excluded to ensure data consistency.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.
%%%% ¡settings!
'NNVariationalAutoencoder'

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

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data points.
%%%% ¡default!
{'NNDataPoint'}

%%% ¡prop!
INPUTS (query, cell) constructs the cell array of the data.

%%% ¡prop!
TARGETS (query, cell) constructs the cell array of the targets.

%%% ¡prop!
TRAIN (query, empty) trains the neural network model with the given dataset.
%%%% ¡calculate!
numEpochs = nnvae.get('EPOCHS');
miniBatchSize = nnvae.get('BATCH');
learnRate = nnvae.get('LEARN_RATE');

d = nnvae.get('D');
if isequal(d.get('DP_DICT').get('LENGTH'), 0)
    value = [];
    return
end

mbq = nnvae.get('MBQ', d);
netE = nnvae.get('ENCODER');
netD = nnvae.get('DECODER');

trailingAvgE = [];
trailingAvgSqE = [];
trailingAvgD = [];
trailingAvgSqD = [];

numObservationsTrain = d.get('DP_DICT').get('LENGTH');
numIterationsPerEpoch = ceil(numObservationsTrain / miniBatchSize);
numIterations = numEpochs * numIterationsPerEpoch;

monitor = trainingProgressMonitor( ...
    Metrics = "Loss", ...
    Info = "Epoch", ...
    XLabel = "Iteration");

epoch = 0;
iteration = 0;

% Loop over epochs.
while epoch < numEpochs && ~monitor.Stop
    epoch = epoch + 1;

    % Shuffle data.
    shuffle(mbq);

    % Loop over mini-batches.
    while hasdata(mbq) && ~monitor.Stop
        iteration = iteration + 1;

        % Read mini-batch of data.
        [X, Y] = next(mbq);

        % Evaluate loss and gradients.
        [loss, gradientsE, gradientsD] = dlfeval(@model_loss, netE, netD, X);

        % Update learnable parameters.
        [netE, trailingAvgE, trailingAvgSqE] = adamupdate(netE, ...
            gradientsE, trailingAvgE, trailingAvgSqE, iteration, learnRate);

        [netD, trailingAvgD, trailingAvgSqD] = adamupdate(netD, ...
            gradientsD, trailingAvgD, trailingAvgSqD, iteration, learnRate);

        % Update the training progress monitor. 
        recordMetrics(monitor, iteration, Loss=loss);
        updateInfo(monitor, Epoch=epoch + " of " + numEpochs);
        monitor.Progress = 100 * iteration/numIterations;
    end
end

nnvae.set('ENCODER', netE);
nnvae.set('DECODER', netD);
nnvae.get('MODEL'); % to lock this element

value = {};
%%%% ¡calculate_callbacks!
function [loss, gradientsE, gradientsD] = model_loss(netE, netD, X)
    
    % Forward through encoder.
    [Z, mu, logSigmaSq] = forward(netE, X);
    
    % Forward through decoder.
    Y = forward(netD, Z);
    
    % Calculate loss and gradients.
    loss = nnvae.get('LOSS_FN', Y, X, mu, logSigmaSq);
    [gradientsE, gradientsD] = dlgradient(loss, netE.Learnables, netD.Learnables);
end

%% ¡props!

%%% ¡prop!
LEARN_RATE (parameter, scalar) is the size of the mini-batch used for each training iteration.
%%%% ¡default!
1e-3

%%% ¡prop!
NUM_LATENT_REP (parameter, scalar) is the size of the mini-batch used for each training iteration.
%%%% ¡default!
2

%%% ¡prop!
SIZE_INPUT (parameter, rvector) is the size of the input image.

%%% ¡prop!
ITERATION_DIM (parameter, scalar) is the iteration dimension.

%%% ¡prop!
NUM_MBQ_OUTPUT (parameter, scalar) is the iteration dimension.
%%%% ¡default!
2

%%% ¡prop!
MINIBATCH_FORMAT_INPUT (query, string) returns the elbo loss.

%%% ¡prop!
MINIBATCH_FORMAT_TARGET (query, string) returns the elbo loss.

%%% ¡prop!
ENCODER (data, net) is a neural network encoder.

%%% ¡prop!
DECODER (data, net) is a neural network decoder.

%%% ¡prop!
MBQ (query, empty) constructs the cell array of the targets.
%%%% ¡calculate!
% targets = nn.get('PREDICT', D) returns a cell array with the
%  targets for all data points in dataset D.
if isempty(varargin)
    value = {};
    return
end
d = varargin{1};
num_dp = d.get('DP_DICT').get('LENGTH');

num_outputs = nnvae.get('NUM_MBQ_OUTPUT');
itr = nnvae.get('ITERATION_DIM');
format_input = string(nnvae.get('MINIBATCH_FORMAT_INPUT'));
format_target = string(nnvae.get('MINIBATCH_FORMAT_TARGET'));
miniBatchSize = nnvae.get('BATCH');

XTrain = nnvae.get('INPUTS', d);
%YTrain = categorical(nnvae.get('TARGETS', d));
YTrain = 1:1:num_dp;
YTrain = YTrain';

dsXTrain = arrayDatastore(XTrain, IterationDimension=itr);
dsYTrain = arrayDatastore(YTrain);
dsTrain = combine(dsXTrain, dsYTrain);

value = minibatchqueue(dsTrain, num_outputs, ...
    MiniBatchSize = miniBatchSize, ...
    MiniBatchFcn = @preprocess_minibatch, ...
    MiniBatchFormat = [format_input, format_target], ...
    PartialMiniBatch = "discard");

%%%% ¡calculate_callbacks!
function [X, Y] = preprocess_minibatch(XCell, YCell)
    % Concatenate.
    X = cat(4, XCell{:});
    
    % Extract label data from cell and concatenate.
    Y = cat(2, YCell{:});
end

%%% ¡prop!
LOSS_FN (query, scalar) returns the loss function.
%%%% ¡calculate!
if length(varargin) < 4
    value = 0;
    return
end
y = varargin{1};
t = varargin{2};
mu = varargin{3};
logSigmaSq = varargin{4};

% Reconstruction loss
reconstructionLoss = mse(y, t);

% KL divergence
KL = -1/2 * sum(1 + logSigmaSq - mu.^2 - exp(logSigmaSq),1);
KL = mean(KL);

% Combined loss
value = reconstructionLoss + KL;

%% ¡tests!
