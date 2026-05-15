%% ¡header!
BaselineEstimator < REAnalysisModule (be, Baseline Estimator) is an REAnalysisModule that reads smooth Raman spectra and outputs baselines.

%%% ¡description!
A Baseline Estimator Module (BaselineEstimator) is an REAnalysisModule that 
reads the smooth Raman spectra (from Smoothener) and evaluates 
the baselines. It also provides basic functionalities to view and 
plot the baselines. 

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator'

%%% ¡prop!
NAME (constant, string) is the name of the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Baseline Estimator.
%%%% ¡default!
'BaselineEstimator reads and analyzes smooth Raman spectra and evaluates and plots the baselines.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Baseline Estimator.
%%%% ¡settings!
'BaselineEstimator'

%%% ¡prop!
ID (data, string) is a few-letter code for the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Baseline Estimator.
%%%% ¡default!
'BaselineEstimator notes'

%%% ¡prop!
SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baseline Estimator.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = be.get('SP_OUT', SP_IN) returns the baseline of the N-th spectrum
% in SP_DICT of RE_IN of BaselineEstimator. 
if isempty(varargin)
    value = Spectrum();
    return
end
% Read the input spectrum
sp_in = varargin{1};

% Read the intensities of the smooth Raman spectrum
% smooth intensities
smooth_intensities = sp_in.get('INTENSITIES');

% Baseline estimation using Lieberfit function
% Apply Lieberfit function to smooth intensities from
% Smoothener
[baselines, baselined_intensities] = lieberfit(smooth_intensities', ...
                                               be.get('LFIT_POLYORDER'), ...
                                               be.get('LFIT_ITER')); 

% Create unlocked copy of the spectrum being processed
% Set the baselines to the INTENSITIES of the spectrum 
sp_out = Spectrum(...
         'INTENSITIES', baselines, ...
         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
         'ID', sp_in.get('ID'), ...
         'LABEL', sp_in.get('LABEL'), ...
         'NOTES', sp_in.get('NOTES'));

% Set the updated sp_out to SP_OUT
value = sp_out;


%% ¡props!

%Parameters for Lieberfit function for baseine estimation:
%LFIT_POLYORDER & LFIT_ITER
%%% ¡prop!
LFIT_POLYORDER (parameter, scalar) is the order of the polynomial for Lieberfit function.
%%%% ¡default!
5


%%% ¡prop!
LFIT_ITER (parameter, scalar) is the number of odd points in the window for Lieberfit function.
%%%% ¡default!
100


%% ¡tests!

%%% ¡excluded_props!
[BaselineEstimator.TEMPLATE BaselineEstimator.REPF]
