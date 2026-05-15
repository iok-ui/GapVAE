%% ¡header!
ImporterRamanExperiment_TXT < Importer (im, importer of Raman experiment from TXT) imports a Raman experiment from a series of TXT files.

%%% ¡description!
Raman experiment importer from TXT files (ImporterRamanExperiment_TXT) imports a set of Raman spectra acquired in TXT files.
The first row is the wavelength in cm-1, the subsequent rows contain the acquired spectra.
The first three columns contain metadata that can be ignored.
The values are tab-separated.

%%% ¡seealso!
RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the .
%%%% ¡default!
'ImporterRamanExperiment_TXT'

%%% ¡prop!
NAME (constant, string) is the name of the importer of Raman experiment from TXT.
%%%% ¡default!
'Importer of Raman experiment from TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the importer of Raman experiment from TXT.
%%%% ¡default!
'Raman experiment importer from TXT files (ImporterRamanExperiment_TXT) imports a set of Raman spectra acquired in TXT files. The first row is the wavelength in cm-1, the subsequent rows contain the acquired spectra. The first three columns contain metadata that can be ignored. The values are tab-separated.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the importer of Raman experiment from TXT.
%%%% ¡settings!
'ImporterRamanExperiment_TXT'

%%% ¡prop!
ID (data, string) is a few-letter code for the importer of Raman experiment from TXT.
%%%% ¡default!
'ImporterRamanExperiment_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the importer of Raman experiment from TXT.
%%%% ¡default!
'ImporterRamanExperiment_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the importer of Raman experiment from TXT.
%%%% ¡default!
'ImporterRamanExperiment_TXT notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the spectra files from which to load the Raman experiment.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the spectra.
%%%% ¡settings!
'ImporterRamanExperiment_TXT'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
	im.set('DIRECTORY', directory);
end
value = im;

%%% ¡prop!
RE (result, item) is a Raman experiment.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
re = RamanExperiment();

directory = im.get('DIRECTORY');
if isfolder(directory)  
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
    
    [~, name] = fileparts(directory);
    re.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Spectra loaded from ' directory] ...
        );

    try
        braph2waitbar(wb, .15, 'Loading spectra...')

        % analyzes file
        files = dir(fullfile(directory, '*.txt'));

        if ~isempty(files)
            sp_dict = re.memorize('SP_DICT');
            for i = 1:1:length(files)
                braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading spectrum ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                [~, sp_id] = fileparts(files(i).name);

                table = readtable(fullfile(directory, files(i).name), 'FileType', 'delimitedtext', 'Delimiter', '\t');
                table(:, 1:3) = []; % eliminates columns 1-3
                data = table2array(table);

                sp = Spectrum( ...
                    'ID', sp_id, ...
                    'LABEL', sp_id, ...
                    'WAVELENGTH', data(1, :)', ... % first row
                    'INTENSITIES', data(2:end, :)', ... % subsequent rows
                    'NOTES', ['Spectrum loaded from ' files(i).name] ...
                );
                sp_dict.get('ADD', sp);
            end
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
	braph2waitbar(wb, 'close')
else
    error([BRAPH2.STR ':ImporterRamanExperiment_TXT:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterRamanExperiment_TXT:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = re;

%% ¡tests!

%%% ¡excluded_props!
[ImporterRamanExperiment_TXT.GET_DIR]

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_re = ImporterRamanExperiment_TXT( ...
'DIRECTORY', [fileparts(which('RamanExperiment')) filesep 'TXT'], ...
    'WAITBAR', true ...
    );
re = im_re.get('RE');

gui = GUIElement('PE', re, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')