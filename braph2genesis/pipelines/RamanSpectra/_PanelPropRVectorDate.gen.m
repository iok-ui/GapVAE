%% ¡header!
PanelPropRVectorDate < PanelProp (pr, panel property date) plots the panel of a property row vector used to represent a date.

%%% ¡description!
PanelPropRVectorDate plots the panel for a RVECTOR property with a numeric edit field used to represent a date.
It works for all categories.

It can be personalized with the following prop:
 FORMAT - Format of the date, see <a href="matlab:help datetime/Format">datetime/Format</a>.

%%% ¡seealso!
uieditfield, GUI, PanelElement, datetime

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel property date.
%%%% ¡default!
'PanelPropRVectorDate'

%%% ¡prop!
NAME (constant, string) is the name of the panel property date.
%%%% ¡default!
'panel property date'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel property date.
%%%% ¡default!
'PanelPropRVectorDate plots the panel for a RVECTOR property with a numeric edit field used to represent a date.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel property date.
%%%% ¡settings!
'PanelPropRVectorDate'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel property date.
%%%% ¡default!
'PanelPropRVectorDate ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel property date.
%%%% ¡default!
'PanelPropRVectorDate label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel property date.
%%%% ¡default!
'PanelPropRVectorDate notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
RamanExperiment()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
RamanExperiment.DATE

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('EDITFIELD')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    switch el.getPropCategory(prop)
        case Category.CONSTANT % __Category.CONSTANT__
            set(pr.get('EDITFIELD'), ...
                'Value', string(datetime(el.get(prop), 'Format', pr.get('FORMAT'))), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
            
        case Category.METADATA % __Category.METADATA__
            set(pr.get('EDITFIELD'), 'Value', string(datetime(el.get(prop), 'Format', pr.get('FORMAT'))))

            if el.isLocked(prop)
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case {Category.PARAMETER Category.DATA Category.FIGURE Category.GUI} % {__Category.PARAMETER__ __Category.DATA__ __Category.FIGURE__ __Category.GUI__}
            set(pr.get('EDITFIELD'), 'Value', string(datetime(el.get(prop), 'Format', pr.get('FORMAT'))))

            prop_value = el.getr(prop);
            if el.isLocked(prop) || isa(prop_value, 'Callback')
                set(pr.get('EDITFIELD'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case {Category.RESULT Category.QUERY Category.EVANESCENT} % {__Category.RESULT__ __Category.QUERY__ __Category.EVANESCENT__}
            prop_value = el.getr(prop);

            if isa(prop_value, 'NoValue')
                set(pr.get('EDITFIELD'), 'Value', string(datetime(el.getPropDefault(prop), 'Format', pr.get('FORMAT'))))
            else
                set(pr.get('EDITFIELD'), 'Value', string(datetime(el.get(prop), 'Format', pr.get('FORMAT'))))
            end
            
            set(pr.get('EDITFIELD'), ...
                'Editable', 'off', ...
                'Enable', pr.get('ENABLE') ...
                )
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('EDITFIELD'), 'Position', [s(.3) s(.3) .25*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('EDITFIELD', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
EDITFIELD (evanescent, handle) is the alpha value edit field.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

editfield = uieditfield( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'EDITFIELD', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_editfield} ...
    );

value = editfield;
%%%% ¡calculate_callbacks!
function cb_editfield(~, ~)
    try
        t = datetime(get(pr.get('EDITFIELD'), 'Value'), 'InputFormat', pr.get('FORMAT'));
        pr.get('EL').set(pr.get('PROP'), datevec(t))
    catch
        pr.get('UPDATE')
    end
end

%%% ¡prop!
FORMAT (gui, string) is the date format.
%%%% ¡default!
'yyyy-MM-dd'

%% ¡tests!

%%% ¡excluded_props!
[PanelPropRVectorDate.PARENT PanelPropRVectorDate.H PanelPropRVectorDate.LISTENER_CB PanelPropRVectorDate.EDITFIELD]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PanelPropRVectorDate'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PanelPropRVectorDate'])