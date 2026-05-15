%% ¡header!
NNDatasetProcess_RamanSpectra < NNDatasetProcess (dproc, Raman-spectra dataset process) processes Raman spectra into a neural-network dataset.

%%% ¡description!
The Raman-spectra dataset process (NNDatasetProcess_RamanSpectra) converts raw Raman spectra stored in *.b2 files into an NNDataset of NNDataPoint_RamanSpectra, 
 applying optional spectral transformation and normalisation and attaching label metadata.

%%% ¡seealso!
NNDatasetProcess, NNDataPoint, NNDataPoint_RamanSpectra, NNDataset

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.ID
%%%% ¡title!
Raman Spectra Dataset Process ID

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.LABEL
%%%% ¡title!
Raman Spectra Dataset Process Label

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.WAITBAR
%%%% ¡title!
Waitbar ON/OFF

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.RAW_DATA_DIR
%%%% ¡title!
Data B2 Files Directory

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.STRESS_SEQ
%%%% ¡title!
Stresses

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.KIND_SEQ
%%%% ¡title!
Kind/Species

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.LOCATION_SEQ
%%%% ¡title!
Locations

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.TARGETS_TO_REMOVE
%%%% ¡title!
Data Exclusion

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.WAVELENGTH_START
%%%% ¡title!
Start Wavenumber

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.WAVELENGTH_END
%%%% ¡title!
End Wavenumber

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.TRANSFORMATION_RULE
%%%% ¡title!
Data Transformation

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.NORMALIZATION_RULE
%%%% ¡title!
Data Normalisation

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.SCALE_FACTOR
%%%% ¡title!
Scale Factor

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.MEMORIZE_DATA
%%%% ¡title!
Memorize Processed Data

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.D
%%%% ¡title!
Raman Spectra Dataset

%%% ¡prop!
%%%% ¡id!
NNDatasetProcess_RamanSpectra.NOTES
%%%% ¡title!
Raman Spectra Dataset Process Notes

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Raman-spectra dataset process.
%%%% ¡default!
'NNDatasetProcess_RamanSpectra'

%%% ¡prop!
NAME (constant, string) is the name of the Raman-spectra dataset process.
%%%% ¡default!
'Raman-Spectra Dataset Process'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Raman-spectra dataset process.
%%%% ¡default!
'The Raman-spectra dataset process (NNDatasetProcess_RamanSpectra) converts raw Raman spectra stored in *.b2 files into an NNDataset of NNDataPoint_RamanSpectra, applying optional spectral transformation and normalisation and attaching label metadata.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Raman-spectra dataset process.
%%%% ¡settings!
'NNDatasetProcess_RamanSpectra'

%%% ¡prop!
ID (data, string) is a few-letter code of the Raman-spectra dataset process.
%%%% ¡default!
'NNDatasetProcess_RamanSpectra ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Raman-spectra dataset process.
%%%% ¡default!
'NNDatasetProcess_RamanSpectra label'

%%% ¡prop!
NOTES (metadata, string) are specific notes of the Raman-spectra dataset process.
%%%% ¡default!
'NNDatasetProcess_RamanSpectra notes'

%%% ¡prop!
D (result, item) is the neural-network dataset containing NNDataPoint_RamanSpectra built from RAW_DATA and EXTRACT_LABELS.
%%%% ¡settings!
'NNDataset'
%%%% ¡calculate!
processed_spectrum_list = dproc.get('PROCESS_DATA');
raw_label_list = dproc.get('EXTRACT_LABELS');

targets_to_remove = dproc.get('TARGETS_TO_REMOVE');
idx_to_remove = [];
if ~isempty(targets_to_remove)
    for i = 1:numel(raw_label_list)
        rows = strtrim(cellstr(raw_label_list{i}));   % 4 rows: species, stress, location, plant ID
        rows = rows(1:3);                              % only species/stress/location
        for t = 1:numel(targets_to_remove)
            tok = strtrim(targets_to_remove{t});
            if any(strcmpi(rows, tok))                 % exact match (no substring hits)
                idx_to_remove(end+1) = i; %#ok<AGROW>
                break
            end
        end
    end
end

idx_to_remove = unique(idx_to_remove);

processed_spectrum_list(idx_to_remove) = [];
raw_label_list(idx_to_remove) = [];

it_list = cellfun(@(data, label) NNDataPoint_RamanSpectra( ...
    'SP_DATA', data, ...
    'WL', dproc.getCallback('WAVELENGTH'), ...
    'WL_START', dproc.getCallback('WAVELENGTH_START'), ...
    'WL_END', dproc.getCallback('WAVELENGTH_END'), ...
    'TARGET_CLASS', {label}), ...
    processed_spectrum_list, raw_label_list, ...
    'UniformOutput', false);

dp_list = IndexedDictionary( ...
    'IT_CLASS', 'NNDataPoint_RamanSpectra', ...
    'IT_LIST', it_list ...
    );

value = NNDataset( ...
    'DP_CLASS', 'NNDataPoint_RamanSpectra', ...
    'DP_DICT', dp_list ...
    );

%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the b2 files of the Raman spectra data.
%%%% ¡settings!
'NNDatasetProcess_RamanSpectra'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    dproc.set('RAW_DATA_DIR', directory);
end
value = dproc;

%%% ¡prop!
STRESS_SEQ (parameter, stringlist) is the canonical stress-label ordering used by EXTRACT_LABELS.
%%%% ¡default!
{'WL', 'HL', 'LL', 'SH'}

%%% ¡prop!
KIND_SEQ (parameter, stringlist) is the canonical species/cultivar code ordering used by EXTRACT_LABELS.
%%%% ¡default!
{'AB2', 'CS', 'KL'}

%%% ¡prop!
LOCATION_SEQ (parameter, stringlist) is the canonical location label ordering used by EXTRACT_LABELS.
%%%% ¡default!
{'loc1', 'loc2'}

%%% ¡prop!
TARGETS_TO_REMOVE (data, stringlist) is a list of label tokens to exclude; any data point whose label contains a listed token is removed.
%%%% ¡default!
{'ps'}

%%% ¡prop!
RAW_DATA_DIR (metadata, string) is the directory containing Raman *.b2 files to be processed.

%%% ¡prop!
WAVELENGTH_START (parameter, scalar) is the starting wavelength (cm^-1).
%%%% ¡default!
600

%%% ¡prop!
WAVELENGTH_END (parameter, scalar) is the ending wavelength (cm^-1).
%%%% ¡default!
1750

%%% ¡prop!
TRANSFORMATION_RULE (parameter, option) is the spectral transformation applied before normalisation.
%%%% ¡settings!
{'First derivative'}
%%%% ¡default!
'First derivative'

%%% ¡prop!
NORMALIZATION_RULE (parameter, option) is the spectral normalisation applied after transformation.
%%%% ¡settings!
{'Scale'}
%%%% ¡default!
'Scale'

%%% ¡prop!
SCALE_FACTOR (parameter, scalar) is the scaling factor used when NORMALIZATION_RULE is Scale.
%%%% ¡default!
100
%%%% ¡postset!
if ~isequal(dproc.get('NORMALIZATION_RULE'), 'Scale')
    dproc.set('SCALE_FACTOR', 1)
end

%%% ¡prop!
WAVELENGTH (result, cvector) returns the wavelength vector parsed from the first *.b2 file in RAW_DATA_DIR.
%%%% ¡calculate!
dir_name = dproc.get('RAW_DATA_DIR');
if isempty(dir_name)
    value = [];
    return
end
file_list = dir([dir_name filesep '*b2']);
if isequal(length(file_list), 0)
    value = [];
    return
end
for i = 1:length(file_list)
    file_names(i) = string(file_list(i).name);
end
file_names = file_names';

b2_el = load([dir_name filesep char(file_names(1))], '-mat');

if strcmp(b2_el.el.get('ELCLASS'), 'Pipeline')
    sp_dict = b2_el.el.get('PS_DICT').get('IT', 7).get('PC_DICT').get('IT', 1).get('EL').get('RE_OUT').get('SP_DICT');
elseif strcmp(b2_el.el.get('ELCLASS'), 'RamanExperiment')
    sp_dict = b2_el.el.get('SP_DICT');
elseif strcmp(b2_el.el.get('ELCLASS'), 'BaselineRemover')
    sp_dict = b2_el.el.get('RE_OUT').get('SP_DICT');
elseif strcmp(b2_el.el.get('ELCLASS'), 'CosmicRayNoiseRemover')
    sp_dict = b2_el.el.get('RE_OUT').get('SP_DICT');
end
value = sp_dict.get('IT', 1).get('WAVELENGTH');

%%% ¡prop!
TRANSFORM_DATA (query, cell) applies TRANSFORMATION_RULE to a wavelength×datapoints matrix and returns the transformed data.
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
end
value = data;

%%% ¡prop!
INV_TRANSFORM_DATA (query, cell) applies the inverse of TRANSFORMATION_RULE to recover spectra from a derivative representation.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
deriv = varargin{1};
if isempty(deriv)
    value = {};
    return
end
transformation = dproc.get('TRANSFORMATION_RULE');
switch transformation
    case 'First derivative'
        base_row = varargin{2}; % raw_data(1, :)
        detransformed_x = base_row + cumsum([zeros(1, size(deriv, 2)); deriv(1:end-1, :)], 1);
end
value = detransformed_x;

%%% ¡prop!
NORMALIZE_DATA (query, cell) applies NORMALIZATION_RULE to a wavelength×datapoints matrix and returns the normalised data.
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
end
value = data;

%%% ¡prop!
INV_NORMALIZE_DATA (query, cell) applies the inverse of NORMALIZATION_RULE to restore original scale.
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
end
value = data;

%%% ¡prop!
RAW_DATA (result, cell) returns the raw spectral data as a cell array (one column per datapoint) extracted by EXTRACT_DATA.
%%%% ¡calculate!
value = dproc.get('EXTRACT_DATA');

%%% ¡prop!
PROCESS_DATA (query, cell) returns spectra processed by TRANSFORM_DATA followed by NORMALIZE_DATA, packaged as a cell array of column vectors.
%%%% ¡calculate!
X_raw = dproc.get('RAW_DATA');
if isempty(X_raw)
    value = {};
    return
end
X = cat(2, X_raw{:});
X_tr = dproc.get('TRANSFORM_DATA', X);
X_tr_nor = dproc.get('NORMALIZE_DATA', X_tr);

for i = 1:size(X_tr_nor, 2)
    value{i} = X_tr_nor(:, i);
end

%%% ¡prop!
REV_PROCESS_DATA (query, cell) returns spectra reconstructed by INV_NORMALIZE_DATA and INV_TRANSFORM_DATA, packaged as a cell array of column vectors.
%%%% ¡calculate!
if isempty(varargin)
    value = {};
    return
end
data = varargin{1};
selected_idx = varargin{2};
inv_norm_data = dproc.get('INV_NORMALIZE_DATA', data);
inv_tran_inv_norm_data = dproc.get('INV_TRANSFORM_DATA', inv_norm_data, selected_idx);

for i = 1:size(inv_tran_inv_norm_data, 2)
    value{i} = inv_tran_inv_norm_data(:, i);
end

%%% ¡prop!
EXTRACT_DATA (query, cell) extracts spectral intensities from all *.b2 files in RAW_DATA_DIR and returns a cell array of wavelength×1 vectors (one per spectrum).
%%%% ¡calculate!
dir_name = dproc.get('RAW_DATA_DIR');
if isempty(dir_name)
    value = {};
    return
end
file_list = dir([dir_name filesep '*b2']);
for i = 1:length(file_list)
    file_names(i) = string(file_list(i).name);
end
file_names = file_names';

X = [];
for file_idx = 1:length(file_names)
    file_name = file_names(file_idx);
    b2_el = load([dir_name filesep char(file_name)], '-mat');

    num_spectrum_file = b2_el.el.get('RE_OUT').get('SP_DICT').get('LENGTH');
    ids = cellfun(@(spectrum) spectrum.get('ID'), b2_el.el.get('RE_OUT').get('SP_DICT').get('IT_LIST'), 'UniformOutput', false);

    num_previous_col = size(X, 2);
    for i = 1:num_spectrum_file
        intensities = b2_el.el.get('RE_OUT').get('SP_DICT').get('IT', i).get('INTENSITIES');
        num_col = size(intensities, 2);
        if file_idx == 1
            counter1 = (i-1)*num_col + 1;
            counter2 = num_col*i;
        else
            counter1 = (i-1)*num_col + 1 + num_previous_col;
            counter2 = num_col*i + num_previous_col;
        end
        X(:, counter1:counter2) = intensities; %#ok<AGROW>
    end
end

for i = 1:size(X, 2)
    value{i} = X(:, i);
end

%%% ¡prop!
EXTRACT_LABELS (query, stringlist) extracts a 4-row label matrix per spectrum (species, stress, location, plant ID) using KIND_SEQ, STRESS_SEQ and LOCATION_SEQ, returned as a stringlist of char arrays.
%%%% ¡calculate!
dir_name = dproc.get('RAW_DATA_DIR');
if isempty(dir_name)
    value = {};
    return
end

stress_seq   = string(dproc.get('STRESS_SEQ'));
kind_seq     = string(dproc.get('KIND_SEQ'));
location_seq = string(dproc.get('LOCATION_SEQ'));

file_list = dir(fullfile(dir_name, '*b2'));
if isempty(file_list)
    value = {};
    return
end

Y = strings(4, 0);
col_offset = 0;

for f = 1:numel(file_list)
    file_name = string(file_list(f).name);
    b2_el = load(fullfile(dir_name, file_list(f).name), '-mat');

    sp_dict = b2_el.el.get('RE_OUT').get('SP_DICT');
    num_spectrum_file = sp_dict.get('LENGTH');
    ids = cellfun(@(sp) sp.get('ID'), sp_dict.get('IT_LIST'), 'UniformOutput', false);

    species_label = "";
    for kk = 1:numel(kind_seq)
        if contains(file_name, kind_seq(kk))
            species_label = kind_seq(kk);
            break
        end
    end

    for i = 1:num_spectrum_file
        sp_el = sp_dict.get('IT', i);
        intensities = sp_el.get('INTENSITIES');
        num_col = size(intensities, 2);
        if num_col == 0
            continue
        end

        id = string(ids{i});

        stress_label = "";
        for ss = 1:numel(stress_seq)
            if contains(id, stress_seq(ss))
                stress_label = stress_seq(ss);
                break
            end
        end

        location_label = "";
        for ll = 1:numel(location_seq)
            if contains(id, location_seq(ll))
                location_label = location_seq(ll);
                break
            end
        end

        Y(:, col_offset + (1:num_col)) = [
            repmat(species_label , 1, num_col)
            repmat(stress_label  , 1, num_col)
            repmat(location_label, 1, num_col)
            repmat(id            , 1, num_col)
        ];

        col_offset = col_offset + num_col;
    end
end

value = cell(1, size(Y, 2));
for i = 1:size(Y, 2)
    value{i} = char(Y(:, i));
end

%%% ¡prop!
MEMORIZE_DATA (query, empty) memorizes all the input data and their labels for quick training later on.
%%%% ¡calculate!
wb = braph2waitbar(dproc.get('WAITBAR'), 0, ['Memorizing. It may takes a while...']);

start = tic;
pause(0.5)
d_sp = dproc.memorize('D');
braph2waitbar(wb, 0.25, ['Memorize input data - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
d_sp.memorize('RAW_DATA');
d_sp.memorize('INPUTS');
braph2waitbar(wb, 0.75, ['Memorize input labels - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
d_sp.memorize('TARGETS');

braph2waitbar(wb, 'close')
value = {};
return

%% ¡tests!

%%% ¡excluded_props!
[NNDatasetProcess_RamanSpectra.GET_DIR]

%%% ¡test!
%%%% ¡name!
Construction of an empty Raman-spectra dataset
%%%% ¡code!
dproc = NNDatasetProcess_RamanSpectra();
d_sp = dproc.get('D');
assert(isequal(d_sp.get('DP_DICT').get('LENGTH'), 0), ...
    [BRAPH2.STR ':NNDatasetProcess_RamanSpectra:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_RamanSpectra does not construct the dataset correctly. The input value is not derived correctly.')

%%% ¡test!
%%%% ¡name!
Normalisation and inverse normalisation
%%%% ¡code!
scale_factor = 10;
dproc = NNDatasetProcess_RamanSpectra( ...
    'NORMALIZATION_RULE', 'Scale', ...
    'SCALE_FACTOR', scale_factor);

raw_data = cumsum(randn(5, 100), 2);
known_normed_data = raw_data / scale_factor;
calc_normed_data = dproc.get('NORMALIZE_DATA', raw_data);

tol = 1e-9;
assert(max(abs(calc_normed_data(:) - known_normed_data(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_RamanSpectra:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_RamanSpectra does not normalise the data correctly.')

calc_inv_normed_data = dproc.get('INV_NORMALIZE_DATA', calc_normed_data);
assert(max(abs(calc_inv_normed_data(:) - raw_data(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_RamanSpectra:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_RamanSpectra does not inverse-normalise the data correctly.')

%%% ¡test!
%%%% ¡name!
Transformation and inverse transformation
%%%% ¡code!
dproc = NNDatasetProcess_RamanSpectra('TRANSFORMATION_RULE', 'First derivative');

raw_data = cumsum(randn(5, 100), 2);
known_transformed = raw_data;
known_transformed(1:end-1, :) = raw_data(2:end, :) - raw_data(1:end-1, :);
known_transformed(end, :) = 0;
calc_transformed = dproc.get('TRANSFORM_DATA', raw_data);

tol = 1e-9;
assert(max(abs(calc_transformed(:) - known_transformed(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_RamanSpectra:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_RamanSpectra does not transform (first derivative) correctly.')

calc_inv_transformed = dproc.get('INV_TRANSFORM_DATA', calc_transformed, raw_data(1, :));
assert(max(abs(calc_inv_transformed(:) - raw_data(:))) <= tol, ...
    [BRAPH2.STR ':NNDatasetProcess_RamanSpectra:' BRAPH2.FAIL_TEST], ...
    'NNDatasetProcess_RamanSpectra does not inverse-transform (first derivative) correctly.')
