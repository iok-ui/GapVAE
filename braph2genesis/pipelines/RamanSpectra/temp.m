close all; delete(findall(0, 'type', 'figure')); clear all

el_class_list = {'RamanExperimentPFPP_SelectedSp'} % {'DistapPP_ID' 'Spectrum' 'RamanExperiment' 'ImporterRamanExperiment_ASC' 'ImporterRamanExperiment_TXT' 'RamanExperimentPF' 'RamanExperimentPFPP_SelectedSp'} 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    el_path = '/pipelines/DiSTAP-RamanSpectra';
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    eval(['test_' el_class])
end

% el_class_list = {'SettingsTextPP'} % {'SettingsTextPP' 'PipelinePP_PSDict'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/DiSTAP-RamanSpectra';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end


% im_re = ImporterRamanExperiment_ASC( ...
% 'DIRECTORY', [fileparts(which('RamanExperiment')) filesep 'data_plantImmuneResponse'], ...
%     'WAITBAR', true ...
%     );
% re = im_re.get('RE');
% 
% gui = GUIElement('PE', re, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')


% im_re = ImporterRamanExperiment_TXT( ...
% 'DIRECTORY', [fileparts(which('RamanExperiment')) filesep 'ML data Thrust C'], ...
%     'WAITBAR', true ...
%     );
% re = im_re.get('RE');
% 
% gui = GUIElement('PE', re, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')


% im = ImporterPipelineBRAPH2(...
%     'FILE', [fileparts(which('RamanExperiment')) filesep 'pipeline_load_raman_ASC.braph2'], ...
%     'WAITBAR', true ...
%     );
% pip = im.get('PIP');
% gui = GUIElement( ...
%     'PE', pip, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui.get('DRAW')
% gui.get('SHOW')


im_re = ImporterRamanExperiment_TXT( ...
'DIRECTORY', [fileparts(which('RamanExperiment')) filesep 'ML data Thrust C'], ...
    'WAITBAR', true ...
    );
re = im_re.get('RE');

pf = RamanExperimentPF('RE', re);

gui = GUIFig('PF', pf, 'WAITBAR', true, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui_settings = gui.memorize('GUI_SETTINGS');
gui_settings.get('DRAW')
gui_settings.get('SHOW')