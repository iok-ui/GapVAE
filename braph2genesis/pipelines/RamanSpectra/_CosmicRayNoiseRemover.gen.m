%% ¡header!
CosmicRayNoiseRemover < REAnalysisModule (crnr, Cosmic Ray Noise Remover) is an REAnalysisModule that reads raw Raman spectra and outputs fixed spectra (with cosmic ray noise removed).

%%% ¡description!
A Cosmic Ray Noise Remover Module (CosmicRayNoiseRemover) is an REAnalysisModule that 
reads the raw Raman spectra and evaluates the fixed spectra with cosmic ray noise removed.
It also provides basic functionalities to view and plot the fixed spectra. 

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover'

%%% ¡prop!
NAME (constant, string) is the name of the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover reads and analyzes raw Raman spectra and evaluates and plots the resulting fixed spectra.'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', crnr, 'PROP', crnr.DESCRIPTION, varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Cosmic Ray Noise Remover.
%%%% ¡settings!
'CosmicRayNoiseRemover'

%%% ¡prop!
ID (data, string) is a few-letter code for the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover notes'


%%% ¡prop!
SP_OUT (result, item) is the fixed spectrum for SP_DICT_OUT and RE_OUT of CosmicRayNoiseRemover.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = crnr.get('SP_OUT', SP_IN) returns the Cosmic-Ray-Noise-removed
% (fixed) N-th spectrum in SP_DICT of RE_IN of CosmicRayNoiseRemover. 
if isempty(varargin)
    value = Spectrum();
    return
end
% Read the input spectrum
sp_in = varargin{1};

% Read the intensities of the raw Raman spectrum
% raw intensities
raw_intensities = sp_in.get('INTENSITIES');

% Apply median filter to raw intensities
fixed_intensities = medfilt1(raw_intensities'); 
fixed_intensities = fixed_intensities';

% Create unlocked copy of the spectrum being processed
% Set the Cosmic-Ray-Noise-removed intensities to the INTENSITIES of the spectrum 
sp_out = Spectrum(...
         'INTENSITIES', fixed_intensities, ...
         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
         'ID', sp_in.get('ID'), ...
         'LABEL', sp_in.get('LABEL'), ...
         'NOTES', sp_in.get('NOTES'));

% Set the updated sp_out to SP_OUT
value = sp_out;


%%% ¡prop!
REPF (gui, item) is a container of the panel figure for the CosmicRayNoiseRemover.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', crnr, 'PROP', CosmicRayNoiseRemover.REPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot Cosmic-Ray-Noise-removed spectra', ...
    varargin{:});


%% ¡tests!

%%% ¡excluded_props!
[CosmicRayNoiseRemover.TEMPLATE CosmicRayNoiseRemover.REPF]


%% ¡layout!

%%% ¡prop!
%%%% ¡id!
CosmicRayNoiseRemover.DESCRIPTION
%%%% ¡title!
MODULE INFO

%%% ¡prop!
%%%% ¡id!
CosmicRayNoiseRemover.RE_IN
%%%% ¡title!
Input Raman Spectra

%%% ¡prop!
%%%% ¡id!
CosmicRayNoiseRemover.RE_OUT
%%%% ¡title!
Output Raman Spectra

%%% ¡prop!
%%%% ¡id!
CosmicRayNoiseRemover.REPF
%%%% ¡title!
PLOT

%%% ¡prop!
%%%% ¡id!
CosmicRayNoiseRemover.NOTES
%%%% ¡title!
NOTES