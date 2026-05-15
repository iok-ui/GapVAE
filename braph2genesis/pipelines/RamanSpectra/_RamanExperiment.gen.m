%% ¡header!
RamanExperiment < ConcreteElement (re, Raman spectroscopy experiment) is a  Raman spectroscopy experiment.

%%% ¡description!
RamanExperiment is a  Raman spectroscopy experiment.

%%% ¡seealso!

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
RamanExperiment.ID
%%%% ¡title!
Raman Experiment ID

%%% ¡prop!
%%%% ¡id!
RamanExperiment.LABEL
%%%% ¡title!
Raman Experiment NAME

%%% ¡prop!
%%%% ¡id!
RamanExperiment.SP_DICT
%%%% ¡title!
Raman Spectra

%%% ¡prop!
%%%% ¡id!
RamanExperiment.NOTES
%%%% ¡title!
Raman Experiment NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment'

%%% ¡prop!
NAME (constant, string) is the name of the Raman spectroscopy experiment.
%%%% ¡default!
'Raman spectroscopy experiment'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment is a Raman spectroscopy experiment.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Raman spectroscopy experiment.
%%%% ¡settings!
'RamanExperiment'

%%% ¡prop!
ID (data, string) is a few-letter code for the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment ID'
%%%% ¡gui!
pr = DistapPP_ID('EL', re, 'PROP', RamanExperiment.ID);

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment notes'

%% ¡props!

%%% ¡prop!
SP_DICT (data, idict) contains the aquired Raman spectra.
%%%% ¡settings!
'Spectrum'
%%%% ¡gui!
pr = PanelPropIDictTable('EL', re, 'PROP', RamanExperiment.SP_DICT, ... 
    'COLS', [PanelPropIDictTable.SELECTOR Spectrum.CALIBRATION Spectrum.ID Spectrum.LABEL Spectrum.WAVELENGTH Spectrum.INTENSITIES ...
    Spectrum.RESEARCHER Spectrum.PLANT_NAME Spectrum.PLANT_TYPE Spectrum.PLANT_TYPE_COMMENT Spectrum.PLANT_AGE Spectrum.LEAF_NUMBER Spectrum.GROWTH_MEDIUM Spectrum.STRESS_TYPE Spectrum.SETUP ...
    Spectrum.NOTES], ... 
    'ROWNAME', 'numbered', ...
    'MENU_OPEN_ITEMS', true, ...
	varargin{:});

