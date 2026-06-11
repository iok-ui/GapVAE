%% ¡header!
NNVariationalAutoencoderEvaluator_Structural < NNVariationalAutoencoderEvaluator (nne, structural variational autoencoder evaluator) evaluates a trained variational autoencoder with structural data.

%%% ¡description!
A structural variational autoencoder evaluator (NNVariationalAutoencoderEvaluator_Structural) evaluates a trained variational autoencoder using a structural neural-network dataset. It extracts encoder latent representations, maps each data point back to a selected variable of interest, and plots a two-dimensional latent-space visualisation.

%%% ¡seealso!
NNVariationalAutoencoderEvaluator, NNVariationalAutoencoderMLP, NNDatasetProcess_Structural, NNDataPoint_Structural

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the structural variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Structural'

%%% ¡prop!
NAME (constant, string) is the name of the structural variational autoencoder evaluator.
%%%% ¡default!
'Structural Variational Autoencoder Evaluator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the structural variational autoencoder evaluator.
%%%% ¡default!
'A structural variational autoencoder evaluator (NNVariationalAutoencoderEvaluator_Structural) evaluates a trained variational autoencoder using a structural neural-network dataset. It extracts encoder latent representations, maps each data point back to a selected variable of interest, and plots a two-dimensional latent-space visualisation.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the structural variational autoencoder evaluator.
%%%% ¡settings!
'NNVariationalAutoencoderEvaluator_Structural'

%%% ¡prop!
ID (data, string) is a few-letter code for the structural variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Structural ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the structural variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Structural label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the structural variational autoencoder evaluator.
%%%% ¡default!
'NNVariationalAutoencoderEvaluator_Structural notes'

%% ¡props!

%%% ¡prop!
LATENT_REPRESENTATIONS (query, cell) returns latent representations and target values from the encoder.
%%%% ¡calculate!
nnvae = nne.get('NN');
d = nne.get('D');
target_name = nne.get('TARGET_NAME');

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

dp_list = d.get('DP_DICT').get('IT_LIST');

target_values = cell(1, numel(dp_list));

for dp_i = 1:numel(dp_list)
    dp = dp_list{dp_i};
    voi_dict = dp.get('VOI_DICT');

    if ~any(strcmp(target_name, voi_dict.get('KEYS')))
        error('TARGET_NAME "%s" was not found in data point %d.', target_name, dp_i)
    end

    target_values{dp_i} = voi_dict.get('IT', target_name).get('V');
end

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
TARGET_LABELS (query, cell) returns display labels for the selected target variable.
%%%% ¡calculate!
d = nne.get('D');
target_name = nne.get('TARGET_NAME');

if isa(d, 'NoValue') || d.get('DP_DICT').get('LENGTH') == 0
    value = {};
    return
end

dp = d.get('DP_DICT').get('IT', 1);
voi_dict = dp.get('VOI_DICT');

if ~any(strcmp(target_name, voi_dict.get('KEYS')))
    value = {};
    return
end

voi = voi_dict.get('IT', target_name);

if isa(voi, 'VOICategoric')
    labels = voi.get('CATEGORIES');
    labels = strrep(labels, '_', ' ');
    value = labels;
else
    value = {};
end

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
target_name = nne.get('TARGET_NAME');

if size(Z, 1) < max(latent_dim_x, latent_dim_y)
    error('The selected latent dimensions exceed the number of available latent dimensions.')
end

figure('Position', [100 100 650 650])

target_labels = nne.get('TARGET_LABELS');

if isempty(target_labels)
    scatter( ...
        Z(latent_dim_x, :), ...
        Z(latent_dim_y, :), ...
        24, ...
        Y, ...
        'filled' ...
        );

    colorbar
else
    h = gscatter( ...
        Z(latent_dim_x, :), ...
        Z(latent_dim_y, :), ...
        Y, ...
        [], ...
        '.', ...
        24 ...
        );

    present_groups = unique(Y, 'stable');
    present_labels = target_labels(present_groups);

    legend(h, present_labels, 'Location', 'best');
end

axis square
box on

xlabel(['Latent dimension ' num2str(latent_dim_x)], 'FontSize', 14)
ylabel(['Latent dimension ' num2str(latent_dim_y)], 'FontSize', 14)
title(['Latent-space representation by ' target_name], 'FontSize', 16)

set(gca, 'FontSize', 13)

save_dir = nne.get('SAVE_DIR');

if ~isempty(save_dir)
    if ~isfolder(save_dir)
        mkdir(save_dir);
    end

    file_base = [save_dir filesep 'latent_space_by_' target_name];

    saveas(gcf, [file_base '.fig']);
    saveas(gcf, [file_base '.png']);
end

value = {};

%% ¡tests!

%%% ¡excluded_props!
[NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS]

%%% ¡test!
%%%% ¡name!
Construction
%%%% ¡code!
nne = NNVariationalAutoencoderEvaluator_Structural();

assert(isa(nne, 'NNVariationalAutoencoderEvaluator_Structural'), ...
    [BRAPH2.STR ':NNVariationalAutoencoderEvaluator_Structural:' BRAPH2.FAIL_TEST], ...
    'NNVariationalAutoencoderEvaluator_Structural is not constructed correctly.')
