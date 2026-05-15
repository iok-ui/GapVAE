%% ¡header!
RamanExperimentPFPP_SelectedSp < PanelProp (pr, panel property selected spectrum) plots the panel of to select a sprectum.

%%% ¡description!
RamanExperimentPFPP_SelectedSp plots the panel to select a spectrum from a drop-down list.
It is supposed to be used with the property SELECTED_SP of RamanExperimentPF.

%%% ¡seealso!
uidropdown, GUI, PanelElement, RamanExperimentPF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the .
%%%% ¡default!
'RamanExperimentPFPP_SelectedSp'

%%% ¡prop!
NAME (constant, string) is the name of the panel property selected spectrum.
%%%% ¡default!
'RamanExperimentPFPP_SelectedSp'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel property selected spectrum.
%%%% ¡default!
'RamanExperimentPFPP_SelectedSp plots the panel to select a spectrum from a drop-down list. It is supposed to be used with the property SELECTED_SP of RamanExperimentPF.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel property selected spectrum.
%%%% ¡settings!
'RamanExperimentPFPP_SelectedSp'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel property selected spectrum.
%%%% ¡default!
'RamanExperimentPFPP_SelectedSp ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel property selected spectrum.
%%%% ¡default!
'RamanExperimentPFPP_SelectedSp label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel property selected spectrum.
%%%% ¡default!
'RamanExperimentPFPP_SelectedSp notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
RamanExperimentPF()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
RamanExperimentPF.SELECTED_SP

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('DROPDOWN')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    pf = pr.get('EL');
    SELECTED_SP = pr.get('PROP');
    
    keys = pf.get('RE').get('SP_DICT').get('KEYS');
    
    set(pr.get('DROPDOWN'), ...
        'Items', keys, ...
        'ItemsData', [1:1:length(keys)], ...
        'Value', pf.get(SELECTED_SP) ...
        )

    prop_value = pf.getr(SELECTED_SP);
    if pf.isLocked(SELECTED_SP) || isa(prop_value, 'Callback')
        set(pr.get('DROPDOWN'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('DROPDOWN', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
DROPDOWN (evanescent, handle) is the logical value dropdown.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_dropdown} ...
    );

value = dropdown;
%%%% ¡calculate_callbacks!
function cb_dropdown(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
end

%% ¡tests!

%%% ¡excluded_props!
[RamanExperimentPFPP_SelectedSp.DRAW RamanExperimentPFPP_SelectedSp.PARENT RamanExperimentPFPP_SelectedSp.H RamanExperimentPFPP_SelectedSp.UPDATE RamanExperimentPFPP_SelectedSp.LISTENER_CB RamanExperimentPFPP_SelectedSp.DROPDOWN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':RamanExperimentPFPP_SelectedSp'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':RamanExperimentPFPP_SelectedSp'])