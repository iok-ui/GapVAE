%% ¡header!
SpectraTrimmer < REAnalysisModule (st, Spectra Trimmer) is an REAnalysisModule that reads and trims the raw Raman spectra.

%%% ¡description!
A Spectra Trimmer Module (SpectraTrimmer) is an REAnalysisModule that 
reads and trims the raw Raman spectra. This is used in all the instances 
of REAnalysisModule. 

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Spectra Trimmer.
%%%% ¡default!
'SpectraTrimmer'

%%% ¡prop!
NAME (constant, string) is the name of the Spectra Trimmer.
%%%% ¡default!
'SpectraTrimmer'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Spectra Trimmer.
%%%% ¡default!
'SpectraTrimmer reads reads and trims the raw Raman spectra for further pre-processing.'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', st, 'PROP', st.DESCRIPTION, varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Spectra Trimmer.
%%%% ¡settings!
'SpectraTrimmer'

%%% ¡prop!
ID (data, string) is a few-letter code for the Spectra Trimmer.
%%%% ¡default!
'SpectraTrimmer ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Spectra Trimmer.
%%%% ¡default!
'SpectraTrimmer label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Spectra Trimmer.
%%%% ¡default!
'SpectraTrimmer notes'


%%% ¡prop!
SP_OUT (result, item) is the trimmed spectrum for SP_DICT_OUT and RE_OUT of SpectraTrimmer.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = st.get('SP_OUT', SP_IN) returns the trimmed N-th spectrum
% in SP_DICT of RE_IN of SpectraTrimmer. 
if isempty(varargin)
    value = Spectrum();
    return
end
% Read the input spectrum
sp_in = varargin{1};

% Read the raw Raman spectra
% raw wavelengths
raw_wavelengths = sp_in.get('WAVELENGTH');
% raw intensities
raw_intensities = sp_in.get('INTENSITIES');


% Apply trimming to the wavelengths and intensities
trimmed_rows = (find(raw_wavelengths(:,1) > st.get('START_WAVELENGTH') & raw_wavelengths(:,1) < st.get('STOP_WAVELENGTH')));
trimmed_wavelengths = raw_wavelengths(trimmed_rows,:);
trimmed_intensities = raw_intensities(trimmed_rows,:);

% Create unlocked copy of the spectrum being processed
% Set the trimmed wavelengths and intensities to the 
% WAVELENGTH and INTENSITIES of the spectrum 
sp_out = Spectrum(...
         'INTENSITIES', trimmed_intensities, ...
         'WAVELENGTH', trimmed_wavelengths, ...
         'ID', sp_in.get('ID'), ...
         'LABEL', sp_in.get('LABEL'), ...
         'NOTES', sp_in.get('NOTES'));

% Set the updated sp_out to SP_OUT
value = sp_out;


%%% ¡prop!
REPF (gui, item) is a container of the panel figure for the SpectraTrimmer.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', st, 'PROP', SpectraTrimmer.REPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot trimmed spectra', ...
    varargin{:});


%% ¡props!

%Parameters for Spectra Trimming
%%% ¡prop!
START_WAVELENGTH (parameter, scalar) is the wavelength below which the spectral portion is removed.
%%%% ¡default!
400

%%% ¡prop!
STOP_WAVELENGTH (parameter, scalar) is wavelength above which the spectral portion is removed.
%%%% ¡default!
1750


%% ¡tests!

%%% ¡excluded_props!
[SpectraTrimmer.TEMPLATE SpectraTrimmer.REPF]


%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SpectraTrimmer.DESCRIPTION
%%%% ¡title!
MODULE INFO

%%% ¡prop!
%%%% ¡id!
SpectraTrimmer.RE_IN
%%%% ¡title!
Input Raman Spectra

%%% ¡prop!
%%%% ¡id!
SpectraTrimmer.START_WAVELENGTH
%%%% ¡title!
START_WAVELENGTH

%%% ¡prop!
%%%% ¡id!
SpectraTrimmer.STOP_WAVELENGTH
%%%% ¡title!
STOP_WAVELENGTH

%%% ¡prop!
%%%% ¡id!
SpectraTrimmer.RE_OUT
%%%% ¡title!
Output Raman Spectra

%%% ¡prop!
%%%% ¡id!
SpectraTrimmer.REPF
%%%% ¡title!
PLOT

%%% ¡prop!
%%%% ¡id!
SpectraTrimmer.NOTES
%%%% ¡title!
NOTES
