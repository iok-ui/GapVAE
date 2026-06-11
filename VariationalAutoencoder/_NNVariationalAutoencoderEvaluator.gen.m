%% ¡header!
NNVariationalAutoencoderEvaluator < NNEvaluator (nne, variational autoencoder evaluator) evaluates a trained variational autoencoder with a neural-network dataset.

%%% ¡description!
A variational autoencoder evaluator (NNVariationalAutoencoderEvaluator) provides common evaluation utilities for trained variational autoencoders. It stores the trained neural network and dataset used for evaluation. Specific subclasses implement evaluation workflows such as latent-space visualisation for structural data or latent-continuity visualisation for image data.

%%% ¡seealso!
NNEvaluator, NNVariationalAutoencoderMLP, NNDataset, NNDataPoint, NNBase

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator'

%%% ¡prop!
NAME (constant, string) is the name of the variational autoencoder evaluator.
%%%% ¡default!
'Variational Autoencoder Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the variational autoencoder evaluator.
%%%% ¡default!
'A variational autoencoder evaluator (NNVariationalAutoencoderEvaluator) provides common evaluation utilities for trained variational autoencoders. It stores the trained neural network and dataset used for evaluation. Specific subclasses implement evaluation workflows such as latent-space visualisation for structural data or latent-continuity visualisation for image data.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the variational autoencoder evaluator.
%%%% ¡settings!
'NNVariationalAutoencoderEvaluator'

%%% ¡prop!
ID (data, string) is a few-letter code for the variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator notes'

%% ¡props!

%%% ¡prop!
TARGET_NAME (metadata, string) is the name of the variable of interest used to label or colour the latent-space plot.
%%%% ¡default!
'group'

%%% ¡prop!
LATENT_DIM_X (parameter, scalar) is the latent dimension shown on the x-axis.
%%%% ¡default!
1

%%% ¡prop!
LATENT_DIM_Y (parameter, scalar) is the latent dimension shown on the y-axis.
%%%% ¡default!
2

%%% ¡prop!
SAVE_DIR (metadata, string) is the directory where evaluation outputs are saved.
%%%% ¡default!
''
