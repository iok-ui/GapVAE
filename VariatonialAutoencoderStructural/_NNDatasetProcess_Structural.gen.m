%% ¡header!
NNDatasetProcess_Structural < NNDatasetProcess (dproc, structural dataset process) processes subject-level structural regional values into a neural-network dataset.

%%% ¡description!
The structural dataset process (NNDatasetProcess_Structural) converts subject-level structural regional values from one or more SubjectST groups into an NNDataset of NNDataPoint_Structural. It applies optional transformation and normalisation to the regional-value vectors and attaches the variables of interest associated with each subject.

%%% ¡seealso!
NNDatasetProcess, NNDataPoint, NNDataPoint_Structural, NNDataset, Group, SubjectST

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.ID
%%%% ¡title!
Structural Dataset Process ID

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.LABEL
%%%% ¡title!
Structural Dataset Process Label

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.WAITBAR
%%%% ¡title!
Waitbar ON/OFF

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.GR_LIST
%%%% ¡title!
Subject ST Groups

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.TRANSFORMATION_RULE
%%%% ¡title!
Data Transformation

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.NORMALIZATION_RULE
%%%% ¡title!
Data Normalisation

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.SCALE_FACTOR
%%%% ¡title!
Scale Factor

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.MEMORIZE_DATA
%%%% ¡title!
Memorize Processed Data

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.D
%%%% ¡title!
Processed Structural Dataset

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_Structural.NOTES
%%%% ¡title!
Structural Dataset Process Notes

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the structural dataset process.
%%%% ¡default!
'NNDatasetProcess_Structural'

%%% ¡prop!
NAME (constant, string) is the name of the structural dataset process.
%%%% ¡default!
'Structural Dataset Process'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the structural dataset process.
%%%% ¡default!
'The structural dataset process (NNDatasetProcess_Structural) converts subject-level structural regional values from one or more SubjectST groups into an NNDataset of NNDataPoint_Structural. It applies optional transformation and normalisation to the regional-value vectors and attaches the variables of interest associated with each subject.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the structural dataset process.
%%%% ¡settings!
'NNDatasetProcess_Structural'

%%% ¡prop!
ID (data, string) is a few-letter code of the structural dataset process.
%%%% ¡default!
'NNDatasetProcess_Structural ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the structural dataset process.
%%%% ¡default!
'NNDatasetProcess_Structural label'

%%% ¡prop!
NOTES (metadata, string) are specific notes of the structural dataset process.
%%%% ¡default!
'NNDatasetProcess_Structural notes'

%%% ¡prop!
D (result, item) is the neural-network dataset containing NNDataPoint_Structural data points built from processed structural regional values.
%%%% ¡settings!
'NNDataset'
%%%% ¡calculate!
processed_data_list = dproc.get('PROCESS_DATA');
voi_dict_list = dproc.get('VOI_DICT_LIST');

it_list = cellfun(@(data, voi_dict) NNDataPoint_Structural( ...
    'FEATURES', {data}, ...
    'VOI_DICT', voi_dict), ...
    processed_data_list, voi_dict_list, ...
    'UniformOutput', false);

dp_list = IndexedDictionary( ...
    'IT_CLASS', 'NNDataPoint_Structural', ...
    'IT_LIST', it_list ...
    );

value = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_Structural', ...
    'DP_DICT', dp_list ...
    );

%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) determines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
GR_LIST (metadata, itemlist) is the list of SubjectST groups used to build the neural-network dataset.
%%%% ¡settings!
'Group'

%%% ¡prop!
TRANSFORMATION_RULE (parameter, option) is the transformation applied to the structural regional-value matrix before normalisation.
%%%% ¡settings!
{'None', 'First derivative'}
%%%% ¡default!
'None'

%%% ¡prop!
NORMALIZATION_RULE (parameter, option) is the normalisation applied after transformation.
%%%% ¡settings!
{'None', 'Scale'}
%%%% ¡default!
'None'

%%% ¡prop!
SCALE_FACTOR (parameter, scalar) is the scaling factor used when NORMALIZATION_RULE is Scale.
%%%% ¡default!
1

%%% ¡prop!
TRANSFORM_DATA (query, cell) applies TRANSFORMATION_RULE to a regions-by-datapoints matrix and returns the transformed data.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end

data = varargin{1};

if isempty(data)
    value = {};
    return
end

transformation = dproc.get('TRANSFORMATION_RULE');

switch transformation
    case 'First derivative'
        data_tmp = data;
        data_tmp = data_tmp(2:end, :) - data_tmp(1:end-1, :);
        data(1:end-1, :) = data_tmp;
        data(end, :) = 0;

    otherwise
end

value = data;

%%% ¡prop!
INV_TRANSFORM_DATA (query, cell) applies the inverse of TRANSFORMATION_RULE to recover regional-value vectors from a transformed representation.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end

data = varargin{1};

if isempty(data)
    value = {};
    return
end

transformation = dproc.get('TRANSFORMATION_RULE');

switch transformation
    case 'First derivative'
        base_row = varargin{2};
        recovered_data = base_row + cumsum([zeros(1, size(data, 2)); data(1:end-1, :)], 1);

    otherwise
        recovered_data = data;
end

value = recovered_data;

%%% ¡prop!
NORMALIZE_DATA (query, cell) applies NORMALIZATION_RULE to a regions-by-datapoints matrix and returns the normalised data.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end

data = varargin{1};

if isempty(data)
    value = {};
    return
end

normalization = dproc.get('NORMALIZATION_RULE');

switch normalization
    case 'Scale'
        scale_factor = dproc.get('SCALE_FACTOR');
        data = data ./ scale_factor;

    otherwise
end

value = data;

%%% ¡prop!
INV_NORMALIZE_DATA (query, cell) applies the inverse of NORMALIZATION_RULE to restore the original data scale.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end

data = varargin{1};

if isempty(data)
    value = {};
    return
end

normalization = dproc.get('NORMALIZATION_RULE');

switch normalization
    case 'Scale'
        scale_factor = dproc.get('SCALE_FACTOR');
        data = data .* scale_factor;

    otherwise
end

value = data;

%%% ¡prop!
RAW_DATA (result, cell) returns the raw structural regional values as a cell array, with one column vector per subject.
%%%% ¡calculate!
value = dproc.get('EXTRACT_DATA');

%%% ¡prop!
PROCESS_DATA (query, cell) returns structural regional values processed by TRANSFORM_DATA followed by NORMALIZE_DATA, packaged as a cell array of column vectors.
%%%% ¡calculate!
X_raw = dproc.get('RAW_DATA');

if isempty(X_raw)
    value = {};
    return
end

X = cat(2, X_raw{:});
X_tr = dproc.get('TRANSFORM_DATA', X);
X_tr_nor = dproc.get('NORMALIZE_DATA', X_tr);

value = cell(1, size(X_tr_nor, 2));

for i = 1:size(X_tr_nor, 2)
    value{i} = X_tr_nor(:, i);
end

%%% ¡prop!
REV_PROCESS_DATA (query, cell) returns structural regional values reconstructed by INV_NORMALIZE_DATA and INV_TRANSFORM_DATA, packaged as a cell array of column vectors.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end

data = varargin{1};
base_row = varargin{2};

inv_norm_data = dproc.get('INV_NORMALIZE_DATA', data);
inv_tran_inv_norm_data = dproc.get('INV_TRANSFORM_DATA', inv_norm_data, base_row);

value = cell(1, size(inv_tran_inv_norm_data, 2));

for i = 1:size(inv_tran_inv_norm_data, 2)
    value{i} = inv_tran_inv_norm_data(:, i);
end

%%% ¡prop!
EXTRACT_DATA (query, cell) extracts structural regional values from all SubjectST objects in GR_LIST and returns a cell array of region-by-1 vectors.
%%%% ¡calculate!
gr_list = dproc.get('GR_LIST');

value = {};

if isempty(gr_list)
    return
end

for gr_idx = 1:length(gr_list)
    gr = gr_list{gr_idx};
    sub_list = gr.get('SUB_DICT').get('IT_LIST');

    if isempty(sub_list)
        continue
    end

    for sub_idx = 1:length(sub_list)
        sub = sub_list{sub_idx};
        value{end + 1} = sub.get('ST'); %#ok<AGROW>
    end
end

%%% ¡prop!
VOI_DICT_LIST (query, cell) extracts the variables-of-interest dictionaries from all subjects in GR_LIST.
%%%% ¡calculate!
gr_list = dproc.get('GR_LIST');

value = {};

if isempty(gr_list)
    return
end

gr_list_name = cellfun(@(gr) gr.get('ID'), gr_list, 'UniformOutput', false);

for gr_idx = 1:length(gr_list)
    gr = gr_list{gr_idx};
    sub_list = gr.get('SUB_DICT').get('IT_LIST');

    if isempty(sub_list)
        continue
    end

    voi_dict_list = cellfun( ...
        @(sub) sub.get('VOI_DICT'), ...
        sub_list, ...
        'UniformOutput', false ...
        );

    % Add group information only if missing.
    if ~any(strcmp('group', voi_dict_list{1}.get('KEYS')))

        group_idx = find(strcmp(gr.get('ID'), gr_list_name), 1);

        if isempty(group_idx)
            error('Group ID "%s" was not found in gr_list_name.', gr.get('ID'))
        end

        group_voi = VOICategoric( ...
            'ID', 'group', ...
            'CATEGORIES', gr_list_name, ...
            'V', group_idx ...
            );

        cellfun( ...
            @(voi_dict) voi_dict.get('ADD', group_voi), ...
            voi_dict_list, ...
            'UniformOutput', false ...
            );
    end

    value = [value voi_dict_list]; %#ok<AGROW>
end

%%% ¡prop!
MEMORIZE_DATA (query, empty) memorizes the processed input data and targets for later neural-network training.
%%%% ¡calculate!
wb = braph2waitbar(dproc.get('WAITBAR'), 0, 'Memorizing processed structural dataset ...');

start = tic;
pause(0.5)

d = dproc.memorize('D');

braph2waitbar(wb, 0.25, ...
    ['Memorizing input data - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])

dproc.memorize('RAW_DATA');
d.memorize('INPUTS');

braph2waitbar(wb, 0.75, ...
    ['Memorizing targets - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])

d.memorize('TARGETS');

braph2waitbar(wb, 'close')

value = {};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Construction of an empty structural dataset
%%%% ¡code!
dproc = NNDatasetProcess_Structural();
d = dproc.get('D');

assert(isequal(d.get('DP_DICT').get('LENGTH'), 0), ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not construct an empty dataset correctly.')

%%% ¡test!
%%%% ¡name!
None normalisation and inverse normalisation
%%%% ¡code!
dproc = NNDatasetProcess_Structural( ...
    'NORMALIZATION_RULE', 'None');

raw_data = cumsum(randn(5, 100), 2);
calc_normed_data = dproc.get('NORMALIZE_DATA', raw_data);

assert(isequal(raw_data, calc_normed_data), ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not normalise the data correctly.')

calc_inv_normed_data = dproc.get('INV_NORMALIZE_DATA', calc_normed_data);

assert(isequal(raw_data, calc_inv_normed_data), ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not inverse-normalise the data correctly.')

%%% ¡test!
%%%% ¡name!
Scale normalisation and inverse normalisation
%%%% ¡code!
scale_factor = 10;

dproc = NNDatasetProcess_Structural( ...
    'NORMALIZATION_RULE', 'Scale', ...
    'SCALE_FACTOR', scale_factor);

raw_data = cumsum(randn(5, 100), 2);
known_normed_data = raw_data / scale_factor;
calc_normed_data = dproc.get('NORMALIZE_DATA', raw_data);

tol = 1e-9;

assert(max(abs(calc_normed_data(:) - known_normed_data(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not normalise the data correctly.')

calc_inv_normed_data = dproc.get('INV_NORMALIZE_DATA', calc_normed_data);

assert(max(abs(calc_inv_normed_data(:) - raw_data(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not inverse-normalise the data correctly.')

%%% ¡test!
%%%% ¡name!
None transformation and inverse transformation
%%%% ¡code!
dproc = NNDatasetProcess_Structural('TRANSFORMATION_RULE', 'None');

raw_data = cumsum(randn(5, 100), 2);
calc_transformed = dproc.get('TRANSFORM_DATA', raw_data);

assert(isequal(raw_data, calc_transformed), ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not apply the None transformation correctly.')

calc_inv_transformed = dproc.get('INV_TRANSFORM_DATA', calc_transformed, raw_data(1, :));

assert(isequal(raw_data, calc_inv_transformed), ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not inverse-transform the data correctly.')

%%% ¡test!
%%%% ¡name!
First-derivative transformation and inverse transformation
%%%% ¡code!
dproc = NNDatasetProcess_Structural('TRANSFORMATION_RULE', 'First derivative');

raw_data = cumsum(randn(5, 100), 2);

known_transformed = raw_data;
known_transformed(1:end-1, :) = raw_data(2:end, :) - raw_data(1:end-1, :);
known_transformed(end, :) = 0;

calc_transformed = dproc.get('TRANSFORM_DATA', raw_data);

tol = 1e-9;

assert(max(abs(calc_transformed(:) - known_transformed(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not calculate the first derivative correctly.')

calc_inv_transformed = dproc.get('INV_TRANSFORM_DATA', calc_transformed, raw_data(1, :));

assert(max(abs(calc_inv_transformed(:) - raw_data(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_Structural:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_Structural does not inverse-transform the first derivative correctly.')
