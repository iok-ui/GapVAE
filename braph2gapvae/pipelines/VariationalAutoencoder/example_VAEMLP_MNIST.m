%EXAMPLE_VAEMLP_MNIST
% Script example pipeline for training and evaluating a multilayer perceptron
% using the MNIST image dataset.

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

%% Evaluate and visualise latent space
nne = NNVariationalAutoencoderEvaluator_Image( ...
    'NN', nnvae, ...
    'D', d_test, ...
    'SAVE_DIR', [fileparts(which('NNDatasetProcess_MNIST')) filesep 'figures'] ... 
    );

figure
nne.get('PLOT_LATENT_REPRESENTATIONS')

figure
nne.get('PLOT_LATENT_CONTINUITY')
