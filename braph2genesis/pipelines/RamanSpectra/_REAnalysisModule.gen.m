%% ¡header!
REAnalysisModule < ConcreteElement (ream, RE Analysis Module) is a Raman Experiment analysis element.

%%% ¡description!
A RE Analysis Module (REAnalysisModule) is the base module that 
copies the RamanExperiment to read and process the Raman spectra 
and plots the processed spectra. 

%%% ¡seealso!
RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the RE Analysis Module.
%%%% ¡default!
'REAnalysisModule'

%%% ¡prop!
NAME (constant, string) is the name of the RE Analysis Module.
%%%% ¡default!
'REAnalysisModule'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of RE Analysis Module.
%%%% ¡default!
'REAnalysisModule copies the RamanExperiment element and analyzes and plots the resulting spectra.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the RE Analysis Module.
%%%% ¡settings!
'REAnalysisModule'

%%% ¡prop!
ID (data, string) is a few-letter code for the RE Analysis Module.
%%%% ¡default!
'REAnalysisModule ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the RE Analysis Module.
%%%% ¡default!
'REAnalysisModule label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about RE Analysis Module.
%%%% ¡default!
'REAnalysisModule notes'



%% ¡props!

%%% ¡prop!
RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
%%%% ¡settings!
'RamanExperiment'


%%% ¡prop!
SP_OUT (query, item) is the processed spectrum in SP_DICT of RE_IN for RE_OUT.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = ream.get('SP_OUT', SP_IN) returns the processed N-th spectrum in 
% SP_DICT of input Raman Experiment RE_IN
if isempty(varargin)
    value = Spectrum();
    return
end
sp_in = varargin{1};
% Create unlocked copy of the input spectrum
sp_out = Spectrum(...
         'INTENSITIES', sp_in.get('INTENSITIES'), ...
         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
         'ID', sp_in.get('ID'), ...
         'LABEL', sp_in.get('LABEL'), ...
         'NOTES', sp_in.get('NOTES'));
value = sp_out;


%%% ¡prop!
SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
%%%% ¡calculate!
% sp_dict_out = ream.get('SP_DICT_OUT') returns the
% processed SP_DICT for input Raman Experiment RE_IN
% Create a new IndexedDictionary
sp_dict_out = IndexedDictionary('IT_CLASS', ream.get('RE_IN').get('SP_DICT').get('IT_CLASS'));

% Get the length of SP_DICT of RE_IN. 
dict_length = ream.get('RE_IN').get('SP_DICT').get('LENGTH');

% Update sp_dict_out with processed spectra
for n = 1:1:dict_length
    sp_in = ream.get('RE_IN').get('SP_DICT').get('IT', n);
    sp_out = ream.get('SP_OUT', sp_in);
    sp_dict_out.get('ADD', sp_out);
end 
% Set the updated value of sp_dict_out to SP_DICT_OUT
value = sp_dict_out;




%%% ¡prop!
RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
% Read input Raman experiment
re_in = ream.get('RE_IN');

% Copy the data_props of input Raman experiment
data_props = re_in.getProps(Category.DATA);
varargin = cell(1, 2 * length(data_props));
for i = 1:1:length(data_props)
    data_prop = data_props(i);
    varargin{2 * i - 1} = data_prop;
    varargin{2 * i} = re_in.getCallback(data_prop);    
end

% Create an output Raman experiment with metadata and data props info
re_out = RamanExperiment('LABEL', re_in.get('LABEL'), ...
                         'NOTES', re_in.get('NOTES'), ...
                         varargin{:});

% Copy the processed SP_DICT of RE_IN to 
% the SP_DICT of RE_OUT
re_out.set('SP_DICT', ream.get('SP_DICT_OUT'));

% Set the re_out to RE_OUT of REAnalysisModule
value = re_out;

% Set re_out to RE and memorize for GUI output of REAnalysisModule
ream.memorize('REPF').set('RE', re_out);



%%% ¡prop!
REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', ream, 'PROP', REAnalysisModule.REPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot Raman Experiment', ...
    varargin{:});





%% ¡tests!

%%% ¡excluded_props!
[REAnalysisModule.TEMPLATE REAnalysisModule.REPF]

%%% ¡test!
%%%% ¡name!
Basic read functions and setting props
%%%% ¡probability!
.01
%%%% ¡code!
m1 = [1 2 3 4 5; 2 4 6 8 10; 3 6 9 12 15; 4 8 12 16 20; 5 10 15 20 25];
m2 = m1 + 1;
m3 = m1 + 2;
m4 = m1 + 3;
m5 = m1 + 4;
m6 = m1 + 5;
s1 = Spectrum('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', ...
    'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m1);
s2 = Spectrum('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', ...
    'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m2);
s3 = Spectrum('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', ...
    'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m3);
s4 = Spectrum('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', ...
    'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m4);
s5 = Spectrum('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', ...
    'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m5);
s6 = Spectrum('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', ...
    'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m6);

items = {s1, s2, s3, s4, s5, s6};

idict_1 = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'Spectrum', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
re = RamanExperiment('ID', 'REid1', ...
                     'LABEL', 'RElabel1', ...
                     'NOTES', 'REnotes1', ...
                     'SP_DICT', idict_1);
ream = REAnalysisModule('ID', 'REAM_TEST1', ...
                        'LABEL', 'RE Analysis Test Module 1', ...
                        'NOTES', 'Testing RE Analysis Module 1.', ...
                        'RE_IN', re);
re_out = ream.get('RE_OUT');

gui = GUIElement('PE', ream, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')
gui.get('CLOSE')
