%% ¡header!
WavelengthCalibrator < REAnalysisModule (wc, Wavelength Calibrator) is an REAnalysisModule that reads raw Raman spectra and outputs fixed spectra (with cosmic ray noise removed).

%%% ¡description!
A Wavelength Calibrator Module (WavelengthCalibrator) is an REAnalysisModule that 
reads the wavelengths from the Raman experiment and evaluates the calibrated
wavelengths based on the Raman spectra of the standard (polystyrene). This is 
used in all the instances of REAnalysisModule. 

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Wavelength Calibrator.
%%%% ¡default!
'WavelengthCalibrator'

%%% ¡prop!
NAME (constant, string) is the name of the Wavelength Calibrator.
%%%% ¡default!
'WavelengthCalibrator'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Wavelength Calibrator.
%%%% ¡default!
'WavelengthCalibrator reads the wavelengths of the raw Raman spectra and evaluates the calibrated wavelengths based on the standard (polystyrene).'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', wc, 'PROP', wc.DESCRIPTION, varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Wavelength Calibrator.
%%%% ¡settings!
'WavelengthCalibrator'

%%% ¡prop!
ID (data, string) is a few-letter code for the Wavelength Calibrator.
%%%% ¡default!
'WavelengthCalibrator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Wavelength Calibrator.
%%%% ¡default!
'WavelengthCalibrator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Wavelength Calibrator.
%%%% ¡default!
'WavelengthCalibrator notes'


%%% ¡prop!
SP_OUT (result, item) is the spectrum with calibrated wavelengths for SP_DICT_OUT and RE_OUT of WavelengthCalibrator.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = wc.get('SP_OUT', SP_IN) returns the N-th spectrum
% in SP_DICT of RE_IN of WavelengthCalibrator with calibrated wavelengths. 
if isempty(varargin)
    value = Spectrum();
    return
end
% Read the input spectrum
sp_in = varargin{1};

% % Read the length of the trimmed wavelength vector of the 
% trimmed Raman spectra
trimmed_length = size((sp_in.get('WAVELENGTH')),1);

% Reference wavelengths for polystyrene signature peaks
reference_wavelengths = [620.9 1001.4 1031.8 1602.3];

% Get the pixel values (wavelength indices) for the corresponding peaks in
% the baseline-removed trimmed Raman spectra of the polystyrene sample
pix = [wc.get('PIXEL_1') wc.get('PIXEL_2') wc.get('PIXEL_3') wc.get('PIXEL_4')];

% Calibrate the raw wavelengths
calibrated_wavelengths = interp1(pix, reference_wavelengths, [1:trimmed_length], 'linear', 'extrap'); 
calibrated_wavelengths = calibrated_wavelengths';

% Create unlocked copy of the spectrum being processed
% Set the calibrated_wavelengths to the WAVELENGTH of the spectrum 
sp_out = Spectrum(...
         'INTENSITIES', sp_in.get('INTENSITIES'), ...
         'WAVELENGTH', calibrated_wavelengths, ...
         'ID', sp_in.get('ID'), ...
         'LABEL', sp_in.get('LABEL'), ...
         'NOTES', sp_in.get('NOTES'));

% Set the updated sp_out to SP_OUT
value = sp_out;


%%% ¡prop!
REPF (gui, item) is a container of the panel figure for the WavelengthCalibrator.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', wc, 'PROP', WavelengthCalibrator.REPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot calibrated spectra', ...
    varargin{:});


%% ¡props!

% Pixel Parameters for Wavelength Calibration
% Pixel values to be read from baseline-removed trimmed Raman spectra of
% polystyrene standard

%%% ¡prop!
PIXEL_1 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 620.9 nm.
%%%% ¡default!
138

%%% ¡prop!
PIXEL_2 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1001.4 nm.
%%%% ¡default!
394

%%% ¡prop!
PIXEL_3 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1031.8 nm.
%%%% ¡default!
416

%%% ¡prop!
PIXEL_4 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1602.3 nm.
%%%% ¡default!
843


%% ¡tests!

%%% ¡excluded_props!
[WavelengthCalibrator.TEMPLATE WavelengthCalibrator.REPF]


%% ¡layout!

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.DESCRIPTION
%%%% ¡title!
MODULE INFO

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.RE_IN
%%%% ¡title!
Input Raman Spectra

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.PIXEL_1
%%%% ¡title!
PIXEL for 620.9 nm PS Raman peak

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.PIXEL_2
%%%% ¡title!
PIXEL for 1001.4 nm PS Raman peak

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.PIXEL_3
%%%% ¡title!
PIXEL for 1031.8 nm PS Raman peak

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.PIXEL_4
%%%% ¡title!
PIXEL for 1602.3 nm PS Raman peak

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.RE_OUT
%%%% ¡title!
Output Raman Spectra

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.REPF
%%%% ¡title!
PLOT

%%% ¡prop!
%%%% ¡id!
WavelengthCalibrator.NOTES
%%%% ¡title!
NOTES

