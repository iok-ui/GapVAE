%% ¡header!
NNVariationalAutoencoderEvaluator_Image < NNVariationalAutoencoderEvaluator (nne, neural network evaluator) evaluates the performance of a trained neural network model with a dataset.

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
'NNVariationalAutoencoderEvaluator_Image'

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
'NNVariationalAutoencoderEvaluator_Image'

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
PLOT_LATENT_CONTINUITY (query, empty) is to plot latetn representations.
%%%% ¡calculate!
nnvae = nne.get('NN');
if strcmp(class(nnvae), 'NNBase')
    value = [];
    return
end
netD = nnvae.get('DECODER');
n = 20;
figsize = 15;

% Display an n x n 2D manifold of data points
digit_size = 28;
scale = 1.0;

% Initialize the figure
figure = zeros(digit_size * n, digit_size * n);

% Linearly spaced coordinates corresponding to the 2D plot
% of data points in the latent space
grid_x = linspace(-scale, scale, n);
grid_y = linspace(-scale, scale, n);

% Reverse grid_y to match the original Python code
grid_y = flip(grid_y);

for i = 1:n
    for j = 1:n
        z_sample = [grid_x(j); grid_y(i)];
        z_sample = dlarray(z_sample,"CB");
        x_decoded = predict(netD, z_sample);
        digit = reshape(x_decoded, digit_size, digit_size);
        figure(1 + (i - 1) * digit_size:i * digit_size, 1 + (j - 1) * digit_size:j * digit_size) = digit;
    end
end

% Create the figure

start_range = digit_size / 2;
end_range = n * digit_size + start_range;
pixel_range = start_range:digit_size:end_range;
sample_range_x = round(grid_x, 1);
sample_range_y = round(grid_y, 1);

xticks(pixel_range);
xticklabels(sample_range_x);
yticks(pixel_range);
yticklabels(sample_range_y);
xlabel('z[0]');
ylabel('z[1]');
imagesc(figure);
colormap('gray');

% Display the plot
axis equal;
axis tight;
axis off;

% Show the figure
set(gcf, 'Color', 'w');
drawnow;
value = [];

%% ¡tests!
