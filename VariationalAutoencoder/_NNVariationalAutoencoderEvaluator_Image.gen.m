%% ¡header!
NNVariationalAutoencoderEvaluator_Image < NNVariationalAutoencoderEvaluator (nne, image variational autoencoder evaluator) evaluates a trained variational autoencoder with image data.

%%% ¡description!
An image variational autoencoder evaluator (NNVariationalAutoencoderEvaluator_Image) evaluates a trained variational autoencoder using an image neural-network dataset. It extracts encoder latent representations, maps each data point back to its image label, and uses the decoder to visualise latent-space continuity by generating images from a regular grid of latent coordinates.

%%% ¡seealso!
NNVariationalAutoencoderEvaluator, NNVariationalAutoencoder2DCNN, NNVariationalAutoencoderMLP, NNDataset, NNDataPoint_Image

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.ID
%%%% ¡title!
Evaluator ID

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.LABEL
%%%% ¡title!
Evaluator Label

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.NN
%%%% ¡title!
Trained VAE

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.D
%%%% ¡title!
Dataset

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.TARGET_NAME
%%%% ¡title!
Target Variable

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.LATENT_DIM_X
%%%% ¡title!
Latent X Dimension

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.LATENT_DIM_Y
%%%% ¡title!
Latent Y Dimension

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.GRID_SIZE
%%%% ¡title!
Grid Size

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.IMAGE_SIZE
%%%% ¡title!
Image Size

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.LATENT_SCALE
%%%% ¡title!
Latent Scale

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.SAVE_DIR
%%%% ¡title!
Save Directory

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.PLOT_LATENT_REPRESENTATIONS
%%%% ¡title!
Plot Latent Representations

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.PLOT_LATENT_CONTINUITY
%%%% ¡title!
Plot Latent Continuity

%%% ¡prop!
%%%% ¡id!
NNVariationalAutoencoderEvaluator_Image.NOTES
%%%% ¡title!
Evaluator Notes

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the image variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Image'

%%% ¡prop!
NAME (constant, string) is the name of the image variational autoencoder evaluator.
%%%% ¡default!
'Image Variational Autoencoder Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the image variational autoencoder evaluator.
%%%% ¡default!
'An image variational autoencoder evaluator (NNVariationalAutoencoderEvaluator_Image) evaluates a trained variational autoencoder using an image neural-network dataset. It extracts encoder latent representations, maps each data point back to its image label, and uses the decoder to visualise latent-space continuity by generating images from a regular grid of latent coordinates.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the image variational autoencoder evaluator.
%%%% ¡settings!
'NNVariationalAutoencoderEvaluator_Image'

%%% ¡prop!
ID (data, string) is a few-letter code for the image variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Image ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the image variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Image label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the image variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Image notes'

%% ¡props!

%%% ¡prop!
GRID_SIZE (parameter, scalar) is the number of generated samples along each latent-space axis.
%%%% ¡default!
20

%%% ¡prop!
IMAGE_SIZE (parameter, scalar) is the size of each generated square image.
%%%% ¡default!
28

%%% ¡prop!
LATENT_SCALE (parameter, scalar) is the range of latent coordinates sampled from -LATENT_SCALE to LATENT_SCALE.
%%%% ¡default!
1

%%% ¡prop!
TARGET_VALUES (query, cell) returns target values for all image data points.
%%%% ¡calculate!
d = nne.get('D');
target_name = nne.get('TARGET_NAME');

if isa(d, 'NoValue') || d.get('DP_DICT').get('LENGTH') == 0
    value = {};
    return
end

dp_list = d.get('DP_DICT').get('IT_LIST');
target_values = cell(1, numel(dp_list));

for dp_i = 1:numel(dp_list)
    dp = dp_list{dp_i};

    % Prefer VOI_DICT if the selected TARGET_NAME exists.
    if checkprop(dp, 'VOI_DICT')
        voi_dict = dp.get('VOI_DICT');

        if ~isempty(voi_dict.get('IT_LIST')) && any(strcmp(target_name, voi_dict.get('KEYS')))
            target_values{dp_i} = voi_dict.get('IT', target_name).get('V');
            continue
        end
    end

    % Fallback: use the data point TARGET.
    target = dp.get('TARGET');

    if iscell(target)
        target_values{dp_i} = target{1};
    else
        target_values{dp_i} = target;
    end
end

value = target_values;

%%% ¡prop!
LATENT_REPRESENTATIONS (query, cell) returns latent representations and target labels from the encoder.
%%%% ¡calculate!
nnvae = nne.get('NN');
d = nne.get('D');

if isa(nnvae, 'NoValue') || isa(d, 'NoValue') || strcmp(class(nnvae), 'NNBase')
    value = {};
    return
end

if d.get('DP_DICT').get('LENGTH') == 0
    value = {};
    return
end

netE = nnvae.get('ENCODER');
mbq = nnvae.get('MBQ', d);

target_values = nne.get('TARGET_VALUES');

Z = [];
Y = [];

while hasdata(mbq)
    [X_individual, Y_individual] = next(mbq);

    [~, mu, ~] = predict(netE, X_individual);

    Z = cat(2, Z, extractdata(mu));

    % Y_individual stores data-point indices returned by NNVariationalAutoencoder.MBQ.
    Y_individual = extractdata(gather(Y_individual));
    Y_number = cell2mat(target_values(Y_individual));

    Y = cat(2, Y, Y_number);
end

value = {Z, Y};

%%% ¡prop!
PLOT_LATENT_REPRESENTATIONS (query, empty) plots and saves a two-dimensional latent-space representation.
%%%% ¡calculate!
latent_info = nne.get('LATENT_REPRESENTATIONS');

if isempty(latent_info)
    value = {};
    return
end

Z = latent_info{1};
Y = latent_info{2};

latent_dim_x = nne.get('LATENT_DIM_X');
latent_dim_y = nne.get('LATENT_DIM_Y');

if size(Z, 1) < max(latent_dim_x, latent_dim_y)
    error('The selected latent dimensions exceed the number of available latent dimensions.')
end

figure('Position', [100 100 650 650])

h = gscatter( ...
    Z(latent_dim_x, :), ...
    Z(latent_dim_y, :), ...
    Y, ...
    [], ...
    '.', ...
    18 ...
    );

axis square
box on

xlabel(['Latent dimension ' num2str(latent_dim_x)], 'FontSize', 14)
ylabel(['Latent dimension ' num2str(latent_dim_y)], 'FontSize', 14)
title('Latent-space representation', 'FontSize', 16)

set(gca, 'FontSize', 13)

lgd = legend(h, 'Location', 'best');
lgd.FontSize = 12;

save_dir = nne.get('SAVE_DIR');

if ~isempty(save_dir)
    if ~isfolder(save_dir)
        mkdir(save_dir);
    end

    file_base = [save_dir filesep 'latent_representations'];

    saveas(gcf, [file_base '.fig']);
    saveas(gcf, [file_base '.png']);
end

value = {};

%%% ¡prop!
PLOT_LATENT_CONTINUITY (query, empty) plots and saves a latent-continuity image grid generated from the decoder.
%%%% ¡calculate!
nnvae = nne.get('NN');

if isa(nnvae, 'NoValue') || strcmp(class(nnvae), 'NNBase')
    value = {};
    return
end

netD = nnvae.get('DECODER');

grid_size = nne.get('GRID_SIZE');
image_size = nne.get('IMAGE_SIZE');
latent_scale = nne.get('LATENT_SCALE');

if grid_size < 1
    error('GRID_SIZE must be greater than or equal to 1.')
end

if image_size < 1
    error('IMAGE_SIZE must be greater than or equal to 1.')
end

if latent_scale <= 0
    error('LATENT_SCALE must be greater than 0.')
end

generated_grid = zeros(image_size * grid_size, image_size * grid_size);

grid_x = linspace(-latent_scale, latent_scale, grid_size);
grid_y = flip(linspace(-latent_scale, latent_scale, grid_size));

for i = 1:grid_size
    for j = 1:grid_size

        z_sample = [grid_x(j); grid_y(i)];
        z_sample = dlarray(z_sample, 'CB');

        x_decoded = predict(netD, z_sample);
        x_decoded = extractdata(x_decoded);

        generated_image = reshape(x_decoded, image_size, image_size);

        row_idx = 1 + (i - 1) * image_size:i * image_size;
        col_idx = 1 + (j - 1) * image_size:j * image_size;

        generated_grid(row_idx, col_idx) = generated_image;
    end
end

figure('Position', [100 100 750 750])

imagesc(generated_grid)
colormap('gray')
axis equal
axis tight
axis off
box on

set(gcf, 'Color', 'w')

title('Latent-space continuity', 'FontSize', 16)

drawnow

save_dir = nne.get('SAVE_DIR');

if ~isempty(save_dir)
    if ~isfolder(save_dir)
        mkdir(save_dir);
    end

    file_base = [save_dir filesep 'latent_continuity'];

    saveas(gcf, [file_base '.fig']);
    saveas(gcf, [file_base '.png']);
end

value = {};

%% ¡tests!

%%% ¡excluded_props!
[NNVariationalAutoencoderEvaluator_Image.TARGET_VALUES NNVariationalAutoencoderEvaluator_Image.LATENT_REPRESENTATIONS NNVariationalAutoencoderEvaluator_Image.PLOT_LATENT_REPRESENTATIONS NNVariationalAutoencoderEvaluator_Image.PLOT_LATENT_CONTINUITY]

%%% ¡test!
%%%% ¡name!
Construction
%%%% ¡code!
nne = NNVariationalAutoencoderEvaluator_Image();

assert(isa(nne, 'NNVariationalAutoencoderEvaluator_Image'), ...
    [BRAPH2.STR ':NNVariationalAutoencoderEvaluator_Image:' BRAPH2.FAIL_TEST], ...
    'NNVariationalAutoencoderEvaluator_Image is not constructed correctly.')
