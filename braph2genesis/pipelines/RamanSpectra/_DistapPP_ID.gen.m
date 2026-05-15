%% ¡header!
DistapPP_ID < PanelPropString (pr, panel DiSTAP id) plots the panel of a DiSTAP property id.

%%% ¡description!
DistapPP_ID plots the panel for a STRING property with an edit field.
It is to be used with the ID properties of the DiSTAP elements.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel DiSTAP id.
%%%% ¡default!
'DistapPP_ID'

%%% ¡prop!
NAME (constant, string) is the name of the panel DiSTAP id.
%%%% ¡default!
'panel DiSTAP id'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel DiSTAP id.
%%%% ¡default!
'DistapPP_ID plots the panel for a STRING property with an edit field.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel DiSTAP id.
%%%% ¡settings!
'DistapPP_ID'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel DiSTAP id.
%%%% ¡default!
'DistapPP_ID ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel DiSTAP id.
%%%% ¡default!
'DistapPP_ID label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel DiSTAP id.
%%%% ¡default!
'DistapPP_ID notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
Spectrum()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Spectrum.ID

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(12)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelPropString(pr, PanelPropString.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('AXES')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelPropString(pr, PanelPropString.UPDATE, varargin{:}); % also warning
if value
    %
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelPropString(pr, PanelPropString.REDRAW, varargin{:}); % also warning
if value
    %
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelPropString(pr, PanelPropString.DELETE, varargin{:}); % also warning
if value
    pr.set('AXES', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
AXES (evanescent, handle) is the marker value axes.
%%%% ¡calculate!
axes = uiaxes( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'AXES', ...
    'Units', 'pixels', ...
    'InnerPosition', [s(.3) s(2.5) s(24) s(8)] ...
    );

im = imread('DiSTAPlogo.jpg');
imshow(im(50:450, 320:1620, :), 'Parent', axes)
xlim(axes, [1, 1300])
ylim(axes, [1, 400])

axes.Toolbar.Visible = 'off';
axes.Interactions = [];
axis(axes, 'off')

value = axes;

%% ¡tests!

%%% ¡excluded_props!
[DistapPP_ID.PARENT DistapPP_ID.H DistapPP_ID.LISTENER_CB DistapPP_ID.EDITFIELD DistapPP_ID.AXES]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':DistapPP_ID'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':DistapPP_ID'])