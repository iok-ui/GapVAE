%% ¡header!
NNDatasetProcess_MNIST < NNDatasetProcess (dproc, processing for a neural network data) processes raw MNIST data into a neural network datasets.

%%% ¡description!
The MNIST processing for a neural network dataset (NNDatasetProcess_MNIST) processes the raw MNIST data into a neural network dataset. 
 The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels.

%%% ¡seealso!
NNDatasetProcess, NNDataPoint

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of processing MNIST data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess_MNIST'

%%% ¡prop!
NAME (constant, string) is the name of processing MNIST data for a neural networks datasets.
%%%% ¡default!
'Processing MNIST for a Neural Network Dataset'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.
%%%% ¡default!
'The MNIST processing for a neural network dataset (NNDatasetProcess_MNIST) processes the raw MNIST data into a neural network dataset. The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.
%%%% ¡settings!
'NNDatasetProcess_MNIST'

%%% ¡prop!
ID (data, string) is a few-letter code of processing data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess_MNIST ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess_MNIST label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.
%%%% ¡default!
'NNDatasetProcess_MNIST notes'

%%% ¡prop!
D (result, item) is the neural network dataset containing the datapoint processed from the raw data.
%%%% ¡settings!
'NNDataset'
%%%% ¡calculate!
raw_image_its = dproc.get('EXTRACT_IMAGES');
raw_label_its = dproc.get('EXTRACT_LABELS');

it_list = cellfun(@(data, label) NNDataPoint_Image( ...
    'IMAGE', {data}, ...
    'TARGET_CLASS', {label}), ...
    raw_image_its, raw_label_its,...
    'UniformOutput', false);

dp_list = IndexedDictionary(...
        'IT_CLASS', 'NNDataPoint_Image', ...
        'IT_LIST', it_list ...
        );

value = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Image', ...
    'DP_DICT', dp_list ...
    );

%% ¡props!

%%% ¡prop!
MNIST_IMAGE_FILE (data, string) contains the file directory of the MNIST data.

%%% ¡prop!
MNIST_LABEL_FILE (data, string) contains the file directory of the MNIST labels.

%%% ¡prop!
EXTRACT_IMAGES (query, cell) extracts the images from the specified IDX files.
%%%% ¡calculate!
dataFolder = fullfile(tempdir, 'mnist');
filename = dproc.get('MNIST_IMAGE_FILE');
if isempty(filename)
    %fprintf([newline "There is no MNIST image file."])
    value = {};
    return
end
gunzip(filename, dataFolder)

[~, name, ~] = fileparts(filename);

[fileID, errmsg] = fopen(fullfile(dataFolder, name), 'r', 'b');
if fileID < 0
    error(errmsg);
end

magicNum = fread(fileID, 1, 'int32', 0, 'b');
if magicNum == 2051
    fprintf([newline 'Read MNIST image data...'])
end

numImages = fread(fileID, 1, 'int32', 0, 'b');
fprintf([newline 'Number of images in the dataset: %6d ...'], numImages);
numRows = fread(fileID, 1, 'int32', 0, 'b');
numCols = fread(fileID, 1, 'int32', 0, 'b');

X = fread(fileID, inf, 'unsigned char');

X = reshape(X, numCols, numRows, numImages);
X = permute(X,[2 1 3]);
X = X ./ 255;
X = reshape(X, [28, 28, 1, size(X, 3)]);

fclose(fileID);

for i = 1:size(X, 4)
    value{i} =  X(:, :, :, i);
end

%%% ¡prop!
EXTRACT_LABELS (query, stringlist) extracts the labels from the specified IDX files.
%%%% ¡calculate!
dataFolder = fullfile(tempdir, 'mnist');
filename = dproc.get('MNIST_LABEL_FILE');
if isempty(filename)
    %fprintf([newline "There is no MNIST label file."])
    value = {};
    return
end
gunzip(filename, dataFolder)
[~, name, ~] = fileparts(filename);

[fileID, errmsg] = fopen(fullfile(dataFolder, name), 'r', 'b');

if fileID < 0
    error(errmsg);
end

magicNum = fread(fileID, 1, 'int32', 0, 'b');
if magicNum == 2049
    fprintf([newline 'Read MNIST label data...'])
end

numItems = fread(fileID, 1, 'int32', 0, 'b');
fprintf([newline 'Number of labels in the dataset: %6d ...'], numItems);

Y = fread(fileID, inf, 'unsigned char');

Y = categorical(Y);

fclose(fileID);

for i = 1:size(Y, 1)
    value{i} = char(Y(i));
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Construction of an Empty Image Dataset
%%%% ¡code!
dproc = NNDatasetProcess_MNIST();
d_mnist = dproc.get('D');

assert(isequal(d_mnist.get('DP_DICT').get('LENGTH'), 0), ...
    [BRAPH2.STR ':NNDatasetProcess_MNIST:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_MNIST does not construct the dataset correctly. The input value is not derived correctly.' ...
    )

%%% ¡test!
%%%% ¡name!
Construction of a MNIST Dataset
%%%% ¡code!
dproc = NNDatasetProcess_MNIST( ...
    'MNIST_IMAGE_FILE', [fileparts(which('NNDatasetProcess_MNIST')) filesep 'mnist_data' filesep 'train-images-idx3-ubyte.gz'], ...
    'MNIST_LABEL_FILE', [fileparts(which('NNDatasetProcess_MNIST')) filesep 'mnist_data' filesep 'train-labels-idx1-ubyte.gz'] ...
    );
d_mnist = dproc.get('D');

assert(isequal(d_mnist.get('DP_DICT').get('LENGTH'), 60000), ...
    [BRAPH2.STR ':NNDatasetProcess_MNIST:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_MNIST does not construct the dataset correctly. The input value is not derived correctly.' ...
    )
