%% ¡header!
NNVariationalAutoencoder < NNBase (nnvae, a neural-network variational autoencoder) is a neural-network variational autoencoder.

%%% ¡description!
A neural-network variational autoencoder (NNVariationalAutoencoder) comprises an encoder and a decoder and is trained in an unsupervised manner 
 to maximise the evidence lower bound (ELBO). The encoder outputs the parameters of a Gaussian latent distribution (mean μ and log-variance log σ²);
 a latent sample z is obtained via the reparameterisation trick and decoded back to the input space. Training minimises a loss function equal to the 
 negative ELBO, i.e., a reconstruction term plus a Kullback–Leibler divergence that regularises the approximate posterior towards a standard normal 
 prior N(0, I). This element trains on a neural-network dataset (NNDataset).

Instances of this class are not meant to be created directly—use one of its subclasses.

%%% ¡seealso!
NNDataset, NNDatasetSplit, NNAutoencoder

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the neural-network variational autoencoder.
%%%% ¡default!
'NNVariationalAutoencoder'

%%% ¡prop!
NAME (constant, string) is the name of the neural-network variational autoencoder.
%%%% ¡default!
'Neural-Network Variational Autoencoder'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder.
%%%% ¡default!
'A neural-network variational autoencoder (NNVariationalAutoencoder) comprises an encoder and a decoder and is trained in an unsupervised manner to maximise the ELBO. The encoder outputs mean μ and log-variance log σ²; a latent sample is obtained via the reparameterisation trick and decoded back to the input space. The loss is the negative ELBO (reconstruction + KL to N(0, I)). This element trains on a neural-network dataset (NNDataset). Instances of this class are not meant to be created directly—use one of its subclasses.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder.
%%%% ¡settings!
'NNVariationalAutoencoder'

%%% ¡prop!
ID (data, string) is a few-letter code of the neural-network variational autoencoder.
%%%% ¡default!
'NNVariationalAutoencoder ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the neural-network variational autoencoder.
%%%% ¡default!
'NNVariationalAutoencoder label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder.
%%%% ¡default!
'NNVariationalAutoencoder notes'

%%% ¡prop!
D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.
%%%% ¡settings!
'NNDataset'
%%%% ¡default!
NNDataset('DP_CLASS', 'NNDataPoint')
%%%% ¡check_value!
check = ismember(value.get('DP_CLASS'), nnvae.get('DP_CLASSES'));

%%% ¡prop!
DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.
%%%% ¡default!
{'NNDataPoint'}

%%% ¡prop!
INPUTS (query, cell) constructs and returns the cell array of inputs from dataset D (format depends on the specific subclass/data point).

%%% ¡prop!
TARGETS (query, cell) constructs and returns the cell array of targets from dataset D (if applicable).

%%% ¡prop!
TRAIN (query, empty) trains the variational autoencoder by updating ENCODER and DECODER to minimise LOSS_FN (negative ELBO) using a mini-batch loop.
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
% Computes the negative ELBO and its gradients w.r.t. ENCODER and DECODER (reconstruction + KL).
    
    % Forward through encoder: return latent sample and its Gaussian params.
    [Z, mu, logSigmaSq] = forward(netE, X);
    
    % Forward through decoder.
    Y = forward(netD, Z);
    
    % Calculate loss and gradients (negative ELBO).
    loss = nnvae.get('LOSS_FN', Y, X, mu, logSigmaSq);
    [gradientsE, gradientsD] = dlgradient(loss, netE.Learnables, netD.Learnables);
end

%% ¡props!

%%% ¡prop!
LEARN_RATE (parameter, scalar) is the learning rate for optimisation.
%%%% ¡default!
1e-3

%%% ¡prop!
NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).
%%%% ¡default!
2

%%% ¡prop!
SIZE_INPUT (parameter, rvector) is the size of the input data (e.g., [H W C] for images, or feature vector length).

%%% ¡prop!
ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.

%%% ¡prop!
NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).
%%%% ¡default!
2

%%% ¡prop!
MINIBATCH_FORMAT_INPUT (query, string) is a deep learning array (dlarray) label string for input mini-batches (e.g., "SSCB" or "BC"), used by minibatchqueue (MBQ).

%%% ¡prop!
MINIBATCH_FORMAT_TARGET (query, string) is a deep learning array (dlarray) label string for target mini-batches (if used), for minibatchqueue (MBQ).

%%% ¡prop!
ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.

%%% ¡prop!
DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.

%%% ¡prop!
MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.
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
if length(varargin) > 1
    miniBatchSize = varargin{2};
else
    miniBatchSize = nnvae.get('BATCH');
end

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
    % Concatenate along the iteration dimension.
    itr = nnvae.get('ITERATION_DIM');
    X = cat(itr, XCell{:});
    
    % Extract label data from cell and concatenate.
    Y = cat(2, YCell{:});
end

%%% ¡prop!
LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).
%%%% ¡calculate!
if length(varargin) < 4
    value = 0;
    return
end
y = varargin{1};
t = varargin{2};
mu = varargin{3};
logSigmaSq = varargin{4};

% Reconstruction loss (e.g., mean-squared error between output y and input t).
reconstructionLoss = mse(y, t);

% KL divergence KL(q(z|x) || N(0, I)).
KL = -1/2 * sum(1 + logSigmaSq - mu.^2 - exp(logSigmaSq),1);
KL = mean(KL);

% Negative ELBO = reconstruction + KL.
value = reconstructionLoss + KL;

%% ¡tests!