%% ¡header!
ImporterRamanExperiment_ASC < Importer (im, importer of Raman experiment from ASC) imports a Raman experiment from a series of ASC files.

%%% ¡description!
Raman experiment importer from ASC files (ImporterRamanExperiment_ASC) imports a set of Raman spectra acquired in ASC files.
The first column is the wavelength in cm-1, the subsequent columns contain the acquired spectra.
The values are either tab-separated or comma-separated.

%%% ¡seealso!
RamanExperiment, Spectrum

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the importer of Raman experiment from ASC.
%%%% ¡default!
'ImporterRamanExperiment_ASC'

%%% ¡prop!
NAME (constant, string) is the name of the importer of Raman experiment from ASC.
%%%% ¡default!
'Importer of Raman experiment from ASC'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the importer of Raman experiment from ASC.
%%%% ¡default!
'Raman experiment importer from ASC files (ImporterRamanExperiment_ASC) imports a set of Raman spectra acquired in ASC files. The first column is the wavelength in cm-1, the subsequent columns contain the acquired spectra. The values are tab-separated.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the importer of Raman experiment from ASC.
%%%% ¡settings!
'ImporterRamanExperiment_ASC'

%%% ¡prop!
ID (data, string) is a few-letter code for the importer of Raman experiment from ASC.
%%%% ¡default!
'ImporterRamanExperiment_ASC ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the importer of Raman experiment from ASC.
%%%% ¡default!
'ImporterRamanExperiment_ASC label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the importer of Raman experiment from ASC.
%%%% ¡default!
'ImporterRamanExperiment_ASC notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the spectra files from which to load the Raman experiment.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where to load the ASC files of the spectra.
%%%% ¡settings!
'ImporterRamanExperiment_ASC'
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
        files = dir(fullfile(directory, '*.asc'));

        if ~isempty(files)
            sp_dict = re.memorize('SP_DICT');
            for i = 1:1:length(files)
                braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading spectrum ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                [~, sp_id] = fileparts(files(i).name);

                % Determine the delimiter
                file = fopen(fullfile(directory, files(i).name), 'r');
                first_line = fgets(file);
                fclose(file);
    
                if contains(first_line, '\t')
                    delimiter = '\t';
                elseif contains(first_line, ',')
                    delimiter = ',';
                else
                    error('Unknown delimiter in file %s', filename);
                end

                % Load data 
                data = table2array(readtable(fullfile(directory, files(i).name), 'FileType', 'delimitedtext', 'Delimiter', delimiter));

                sp = Spectrum( ...
                    'ID', sp_id, ...
                    'LABEL', sp_id, ...
                    'WAVELENGTH', data(:, 1), ...
                    'INTENSITIES', data(:, 2:end), ...
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
    error([BRAPH2.STR ':ImporterRamanExperiment_ASC:' BRAPH2.ERR_IO], ...
        [BRAPH2.STR ':ImporterRamanExperiment_ASC:' BRAPH2.ERR_IO '\\n' ...
        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
        );
end

value = re;

%% ¡tests!

%%% ¡excluded_props!
[ImporterRamanExperiment_ASC.GET_DIR]

%%% ¡test!
%%%% ¡name!
GUI 1
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_re = ImporterRamanExperiment_ASC( ...
    'DIRECTORY', [fileparts(which('RamanExperiment')) filesep 'ASC1'], ...
    'WAITBAR', true ...
    );
re = im_re.get('RE');

gui = GUIElement('PE', re, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
GUI 2
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_re = ImporterRamanExperiment_ASC( ...
    'DIRECTORY', [fileparts(which('RamanExperiment')) filesep 'ASC2'], ...
    'WAITBAR', true ...
    );
re = im_re.get('RE');

gui = GUIElement('PE', re, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')