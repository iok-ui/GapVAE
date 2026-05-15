%% ¡header!
BaselineRemover < REAnalysisModule (br, Baseline Remover) is an REAnalysisModule that reads smooth Raman spectra and outputs baseline-removed Raman and Raman baselines.

%%% ¡description!
A Baseline Remover (BaselineRemover) is an REAnalysisModule
that reads the smooth Raman spectra (from Smoothener) and evaluates 
the baseline-removed Raman spectra (smooth spectra with baselines removed)
and the baselines. It also provides basic functionalities to view and plot 
the baseline-removed spectra and the baselines. 

%%% ¡seealso!
REAnalysisModule, BaselineEstimator, RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Baseline Remover.
%%%% ¡default!
'BaselineRemover'

%%% ¡prop!
NAME (constant, string) is the name of the Baseline Remover.
%%%% ¡default!
'BaselineRemover'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Baseline Remover.
%%%% ¡default!
'BaselineRemover reads and analyzes smooth Raman spectra and evaluates and plots the baselined Raman spectra.'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', br, 'PROP', br.DESCRIPTION, varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Baseline Remover.
%%%% ¡settings!
'BaselineRemover'

%%% ¡prop!
ID (data, string) is a few-letter code for the Baseline Remover.
%%%% ¡default!
'BaselineRemover ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Baseline Remover.
%%%% ¡default!
'BaselineRemover label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Baseline Remover.
%%%% ¡default!
'BaselineRemover notes'

%%% ¡prop!
SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
%%%% ¡calculate!
% sp_dict_out = br.get('SP_DICT_OUT') returns the
% processed SP_DICT for input Raman Experiment RE_IN
% Create a new IndexedDictionary
sp_dict_out = IndexedDictionary('IT_CLASS', br.get('RE_IN').get('SP_DICT').get('IT_CLASS'));

% Get the length of SP_DICT of RE_IN. 
dict_length = br.get('RE_IN').get('SP_DICT').get('LENGTH');

% Update sp_dict_out with processed spectra
for n = 1:1:dict_length
    sp_in = br.get('RE_IN').get('SP_DICT').get('IT', n);

    smooth_intensities = sp_in.get('INTENSITIES');
    baselines = br.get('RE_BASELINES').get('SP_DICT').get('IT', n).get('INTENSITIES');
    baselined_intensities = smooth_intensities - baselines;

    sp_out = Spectrum( ...
         'INTENSITIES', baselined_intensities, ...
         'WAVELENGTH', br.get('RE_IN').get('SP_DICT').get('IT', n).get('WAVELENGTH'), ...
         'ID', br.get('RE_IN').get('SP_DICT').get('IT', n).get('ID'), ...
         'LABEL', br.get('RE_IN').get('SP_DICT').get('IT', n).get('LABEL'), ...
         'NOTES', br.get('RE_IN').get('SP_DICT').get('IT', n).get('NOTES'));

    sp_dict_out.get('ADD', sp_out);
end 
% Set the updated value of sp_dict_out to SP_DICT_OUT
value = sp_dict_out;

%%% ¡prop!
REPF (gui, item) is a container of the panel figure for the BaselineRemover.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', br, 'PROP', BaselineRemover.REPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot Baseline-removed spectra', ...
    varargin{:});


%% ¡props!

%%% ¡prop!
RE_BASELINES (result, item) is the output Raman Experiment with Raman baselines as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
% Call BaselineEstimator to evaluate baselines
be = BaselineEstimator('RE_IN', br.get('RE_IN'));

% Read RE_OUT of BaselineEstimator
re_out = be.get('RE_OUT');

% Set the re_out to RE_BASELINES
value = re_out;

% Set re_out to RE and memorize baselines for GUI output of BaselineRemover
br.memorize('BAPF').set('RE', re_out);


%%% ¡prop!
BAPF (gui, item) is a container of the panel figure for BaselineEstimator.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', br, 'PROP', BaselineRemover.BAPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot estimated baselines', ...
    varargin{:});


% Parameters for Lieberfit function for baseine estimation:
% LFIT_POLYORDER & LFIT_ITER

%%% ¡prop!
LFIT_POLYORDER (parameter, scalar) is the order of the polynomial for Lieberfit function.
%%%% ¡default!
5


%%% ¡prop!
LFIT_ITER (parameter, scalar) is the number of iterations for Lieberfit function.
%%%% ¡default!
100


%% ¡tests!

%%% ¡excluded_props!
[BaselineRemover.TEMPLATE BaselineRemover.REPF BaselineRemover.BAPF]


%% ¡layout!

%%% ¡prop!
%%%% ¡id!
BaselineRemover.DESCRIPTION
%%%% ¡title!
MODULE INFO

%%% ¡prop!
%%%% ¡id!
BaselineRemover.LFIT_POLYORDER
%%%% ¡title!
Order of Polynomial Fit

%%% ¡prop!
%%%% ¡id!
BaselineRemover.LFIT_ITER
%%%% ¡title!
Number of Iterations to Fit Baseline

%%% ¡prop!
%%%% ¡id!
BaselineRemover.RE_IN
%%%% ¡title!
Input Raman Spectra

%%% ¡prop!
%%%% ¡id!
BaselineRemover.RE_BASELINES
%%%% ¡title!
Baselines

%%% ¡prop!
%%%% ¡id!
BaselineRemover.BAPF
%%%% ¡title!
PLOT

%%% ¡prop!
%%%% ¡id!
BaselineRemover.RE_OUT
%%%% ¡title!
Output Raman Spectra

%%% ¡prop!
%%%% ¡id!
BaselineRemover.REPF
%%%% ¡title!
PLOT

%%% ¡prop!
%%%% ¡id!
BaselineRemover.NOTES
%%%% ¡title!
NOTES
