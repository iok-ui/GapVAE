%% ¡header!
NNVariationalAutoencoderEvaluator < NNEvaluator (nne, neural network evaluator) evaluates the performance of a trained neural network model with a dataset.

%%% ¡description!
A neural network evaluator (NNEvalu
ator) evaluates the performance of a neural network model with a specific dataset.
Instances of this class should not be created. Use one of its subclasses instead.
Its subclasses shall be specifically designed to cater to different evaluation cases such as a classification task, a regression task, or a data generation task.

%%% ¡seealso!
NNDataPoint, NNDataset, NNBase

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the evaluator of the neural network analysis.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator'

%%% ¡prop!
NAME (constant, string) is the name of the evaluator for the neural network analysis.
%%%% ¡default!
'Neural Network Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the evaluator for the neural network analysis.
%%%% ¡default!
'A neural network evaluator (NNEvaluator) evaluates the performance of a neural network model with a specific dataset. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses shall be specifically designed to cater to different evaluation cases such as a classification task, a regression task, or a data generation task.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the evaluator for the neural network analysis.
%%%% ¡settings!
'NNVariationalAutoencoderEvaluator'

%%% ¡prop!
ID (data, string) is a few-letter code for the evaluator for the neural network analysis.
%%%% ¡default!
'NNEvaluator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the evaluator for the neural network analysis.
%%%% ¡default!
'NNEvaluator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the evaluator for the neural network analysis.
%%%% ¡default!
'NNEvaluator notes'

%% ¡props!
%%% ¡prop!
PLOT_LATENT_REPRESENTATIONS (query, empty) is to plot latetn representations.
%%%% ¡calculate!
nnvae = nne.get('NN');
if strcmp(class(nnvae), 'NNBase')
    value = [];
    return
end
netE = nnvae.get('ENCODER');
d = nne.get('D');
mbq = nnvae.get('MBQ', d);

latentInfo = nne.get('PREDICT_ENCODER', netE, mbq);
ZLatent = latentInfo{1};
YLatent = latentInfo{2};
%index_selected = (YLatent == 2) | (YLatent == 1) | (YLatent == 10) | (YLatent == 8) | (YLatent == 3);

%figure;
%h = scatter(ZLatent(1, index_selected), ZLatent(2, index_selected), 30, YLatent(index_selected), 'filled');
h = gscatter(ZLatent(1, :), ZLatent(2, :), YLatent, [], '.', 12);

title('Scatter Plot with Color-Coded Categories');
value = [];

%%% ¡prop!
PREDICT_ENCODER (query, cell) returns the predictions of an encoder.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end

netE = varargin{1};
mbq = varargin{2};

targets = categorical(nne.get('NN').get('TARGETS', nne.get('D')));
Z = [];
Y = [];

% Loop over mini-batches.
while hasdata(mbq)
    [X_individual, Y_individual] = next(mbq);

    % Forward through encoder.
    %Z_individual = predict(netE,X_individual,Outputs='latentOuput');
    [Z_individual, mu, logSigmaSq] = predict(netE, X_individual);
    
    % Extract and concatenate predictions.
    %Z = cat(2,Z,extractdata(Z_individual));
    Z = cat(2, Z, extractdata(mu));

    Y_individual = extractdata(gather(Y_individual));
    Y_number = targets(Y_individual);
    Y = cat(2, Y, Y_number);
end

value = [{Z}, {Y}];

%% ¡tests!

%%% ¡excluded_props!
[NNVariationalAutoencoderEvaluator.PLOT_LATENT_REPRESENTATIONS NNVariationalAutoencoderEvaluator.PREDICT_ENCODER]
