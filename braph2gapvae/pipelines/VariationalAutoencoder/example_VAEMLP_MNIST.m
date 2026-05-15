%% EXAMPLE_NNCV_CON_BUD_M_CLA
% Script example pipeline for NN regression cross-validation with input of GraphBUD measures derived from SubjectCON 

clear variables %#ok<*NASGU>

%% Load MNIST Dataset
dproc = NNDatasetProcess_MNIST( ...
    'MNIST_IMAGE_FILE', [fileparts(which('NNDatasetProcess_MNIST')) filesep 'mnist_data' filesep 'train-images-idx3-ubyte.gz'], ...
    'MNIST_LABEL_FILE', [fileparts(which('NNDatasetProcess_MNIST')) filesep 'mnist_data' filesep 'train-labels-idx1-ubyte.gz'] ...
    );
d_mnist = dproc.get('D');

%% Split for Training/Test
d_split = NNDatasetSplit('D', d_mnist, 'SPLIT', {0.7, 0.3});
d_training = d_split.get('D_LIST_IT', 1);
d_test = d_split.get('D_LIST_IT', 2);

%% Train a Variational Autoencoder
nnvae = NNVariationalAutoencoderMLP('D', d_training, 'EPOCHS', 10, 'BATCH', 128);
nnvae.get('TRAIN')

%% Evaluate and Visualize Latent Space
nne = NNVariationalAutoencoderEvaluator_Image('NN', nnvae, 'D', d_test);
figure
nne.get('PLOT_LATENT_REPRESENTATIONS')

%%
figure
nne.get('PLOT_LATENT_CONTINUITY')
