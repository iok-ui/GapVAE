%% ¡header!
NNDataPoint_RamanSpectra < NNDataPoint (dp, a neural-network data point for Raman spectra) is a neural-network data point for Raman spectra.

%%% ¡description!
A neural-network data point for Raman spectra (NNDataPoint_RamanSpectra) that holds both the spectral input and the target used in learning tasks.
 The input is the spectrum intensity vector clipped to the wavelength range defined by WL_START and WL_END.
 The target is derived from variables of interest (VOIs) of this data point, typically specified via TARGET_CLASS (for example, a spectrum type or class label).

%%% ¡seealso!
NNDataPoint, NNDataset, NNVariationalAutoencoderEvaluator_RS

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Raman-spectra data point.
%%%% ¡default!
'NNDataPoint_RamanSpectra'

%%% ¡prop!
NAME (constant, string) is the name of the Raman-spectra data point.
%%%% ¡default!
'Neural Network Data Point for Raman Spectra'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Raman-spectra data point.
%%%% ¡default!
'A neural-network data point for Raman spectra (NNDataPoint_RamanSpectra) that holds both the spectral input and the target used in learning tasks. The input is the spectrum intensity vector clipped to the wavelength range defined by WL_START and WL_END. The target is derived from variables of interest (VOIs) of this data point, typically specified via TARGET_CLASS (for example, a spectrum type or class label).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Raman-spectra data point.
%%%% ¡settings!
'NNDataPoint_RamanSpectra'

%%% ¡prop!
ID (data, string) is a few-letter code of the Raman-spectra data point.
%%%% ¡default!
'NNDataPoint_RamanSpectra ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Raman-spectra data point.
%%%% ¡default!
'NNDataPoint_RamanSpectra label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes of the Raman-spectra data point.
%%%% ¡default!
'NNDataPoint_RamanSpectra notes'

%%% ¡prop!
INPUT (result, cell) returns the spectral input within the wavelength range WL_RANGE for this Raman-spectra data point.
%%%% ¡calculate!
wl_range = dp.get('WL_RANGE');
if isempty(wl_range)
    value = {};
    return
end

idx_wav_start = wl_range(1);
idx_wav_end = wl_range(2);

sp_data = dp.get('SP_DATA');
if isempty(sp_data)
    value = {};
else
    value = {sp_data(idx_wav_start:idx_wav_end)};
end

%%% ¡prop!
INPUT (result, cell) returns the spectral input within the wavelength range WL_RANGE for this Raman-spectra data point.
%%%% ¡calculate!
value = cellfun(@(c) sum(double(c)), dp.get('TARGET_CLASS'), 'UniformOutput', false);

%% ¡props!

%%% ¡prop!
SP_DATA (data, cvector) is the vector of spectral intensities for this Raman spectrum.

%%% ¡prop!
WL (data, cvector) is the wavelength vector (cm^-1) aligned element-wise with SP_DATA.

%%% ¡prop!
WL_START (data, scalar) is the lower wavelength bound (cm^-1) used to crop the spectrum.
%%%% ¡default!
600

%%% ¡prop!
WL_END (data, scalar) is the upper wavelength bound (cm^-1) used to crop the spectrum.
%%%% ¡default!
1750

%%% ¡prop!
TARGET_CLASS (parameter, stringlist) lists variable-of-interest IDs used to construct TARGET.

%%% ¡prop!
WL_LABELS (query, stringlist) returns string labels for wavelength WL in the form "<wavenumber> cm^-1".
%%%% ¡calculate!
value = arrayfun(@(wavelength) [num2str(wavelength) ' cm-1'], dp.get('WL')', 'UniformOutput', false);

%%% ¡prop!
WL_RANGE (result, rvector) returns the index pair [i_start, i_end] delimiting WL_START to WL_END within WL.
%%%% ¡calculate!
wavelength = dp.get('WL');
wavelength_start = dp.get('WL_START');
wavelength_end = dp.get('WL_END');

diff_start = wavelength - wavelength_start;
[~, idx_wav_start] = min(abs(diff_start));
diff_end = wavelength - wavelength_end;
[~, idx_wav_end] = min(abs(diff_end));
value = [idx_wav_start, idx_wav_end];

%%% ¡prop!
WL_OF_INTEREST (result, rvector) returns the wavelength values within WL_RANGE.
%%%% ¡calculate!
wl = dp.get('WL');
wl_range = dp.get('WL_RANGE');
if isempty(wl_range)
    value = [];
else
    value = wl(wl_range(1):wl_range(2));
end