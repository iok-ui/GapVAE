%% EXAMPLE_NNVAE_SPECTRUM
% Script example pipeline for NN Variational Autoencoders with Raman
% Spectrum Data

clear variables %#ok<*NASGU>

%% Load Spectra Dataset
dproc = NNDatasetProcess_RamanSpectra( ...
    'RAW_DATA_DIR', [fileparts(which('NNDatasetProcess_RamanSpectra')) filesep 'b2_files'], ...
    'TRANSFORMATION_RULE', 'First derivative', ...
    'NORMALIZATION_RULE', 'Scale', ...
    'SCALE_FACTOR', 100, ...
    'TARGETS_TO_REMOVE', {'ps'});
d_sp = dproc.get('D');

%% Train a Variational Autoencoder
nnvae = NNVariationalAutoencoderMLP('D', d_sp, 'EPOCHS', 100, 'BATCH', 32);
nnvae.get('TRAIN')

%% Evaluate and Visualize Latent Space
nne = NNVariationalAutoencoderEvaluator_RS('NN', nnvae, 'D', d_sp);

% publication figures
%nne.get('PLOT_R_LATENT_REPRESENTATIONS');
%nne.get('PLOT_R_PEAK_IDENTIFICATIONS');

