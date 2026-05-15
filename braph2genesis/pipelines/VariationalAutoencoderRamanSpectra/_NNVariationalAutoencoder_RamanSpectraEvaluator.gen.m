%% ¡header!
NNVariationalAutoencoderEvaluator_RamanSpectral < NNVariationalAutoencoderEvaluator (nne, neural network evaluator) evaluates the performance of a trained neural network model with a dataset.

%%% ¡description!
A neural network evaluator (NNEvaluator) evaluates the performance of a neural network model with a specific dataset.
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
'NNVariationalAutoencoder_RamanSpectralEvaluator'

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
'NNVariationalAutoencoder_RamanSpectralEvaluator'

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
PEAK_IDENTIFICATION (result, rvector) indentifies importance peaks.

%%% ¡prop!
ZERO_CROSSING_P2N (query, rvector) indentifies the index when crossing from positve to negative.

%%% ¡prop!
ZERO_CROSSING_N2P (query, rvector) indentifies the index when crossing from negative to positive.

%%% ¡prop!
DIRECTORY (data, string) is the directory saving the exporting figure.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
PLOT_R_SCRIPT (metadata, logical) indentifies the index when crossing from negative to positive.


%% ¡tests!

%%% ¡excluded_props!
[NNVariationalAutoencoder_RamanSpectralEvaluator.PLOT_LATENT_REPRESENTATIONS NNVariationalAutoencoder_RamanSpectralEvaluator.PLOT_LATENT_CONTINUITY NNVariationalAutoencoder_RamanSpectralEvaluator.PREDICT_ENCODER]
