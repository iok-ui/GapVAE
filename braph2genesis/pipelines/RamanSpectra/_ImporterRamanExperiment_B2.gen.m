%% ¡header!
ImporterRamanExperiment_B2 < Importer (im, importer of Raman experiment from B2) imports a Raman experiment from a .b2 file.

%%% ¡description!
Raman experiment importer from B2 file (ImporterRamanExperiment_B2) imports a set of Raman spectra acquired in a Raman Experiment stored in a B2 file.

%%% ¡seealso!
RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2'

%%% ¡prop!
NAME (constant, string) is the name of the importer of Raman experiment from B2.
%%%% ¡default!
'Importer of Raman experiment from B2'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the importer of Raman experiment from B2.
%%%% ¡default!
'Raman experiment importer from B2 file (ImporterRamanExperiment_B2) imports a set of Raman spectra acquired in a Raman Experiment stored in a B2 file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the importer of Raman experiment from B2.
%%%% ¡settings!
'ImporterRamanExperiment_B2'

%%% ¡prop!
ID (data, string) is a few-letter code for the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2 ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2 label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2 notes'

%% ¡props!

%%% ¡prop!
FILE (data, string) is the loaded B2 file.
%%%% ¡default!
'test.b2'

%%% ¡prop!
GET_FILE (query, item) opens a dialog box to get the B2 file from which the Raman Experiment can be loaded.
%%%% ¡settings!
'ImporterRamanExperiment_B2'
%%%% ¡calculate!
[filename, filepath, filterindex] = uigetfile({'*.b2'}, 'Select B2 file');
if filterindex
    file = [filepath filename];
    im.set('FILE', file);
end
value = im;
    
%%% ¡prop!
RE (result, item) is a Raman Experiment.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡default!
RamanExperiment()
%%%% ¡calculate!
% creates empty RamanExperiment
re = RamanExperiment();

% analyzes file
file = im.get('FILE');

if isfile(file)
	wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');

    try
        % loads the element EL from the b2 file
        % also loads the BRAPH2 BUILD, the MatLab
        % version number, and the details of the MatLab version
        [el, build, v, vd] = Element.load(file);
        re = el;
       
        braph2waitbar(wb, .15, 'Loading Raman Experiment ...');
    catch e
        braph2waitbar(wb, 'close')
        rethrow(e)
    end
    
	braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterRamanExperiment_B2:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterRamanExperiment_B2:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = re;


%% ¡tests!

%%% ¡excluded_props!
[ImporterRamanExperiment_B2.GET_FILE]
