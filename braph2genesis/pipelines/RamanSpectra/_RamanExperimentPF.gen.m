%% ¡header!
RamanExperimentPF < PanelFig (pf, panel figure Raman experiment) is the base element to plot a Raman experiment.

%%% ¡description!
RamanExperimentPF manages the basic functionalities to plot of a Raman experiment.

%%% ¡seealso!
Measure

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ID
%%%% ¡title!
Raman Experiment Figure ID

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.LABEL
%%%% ¡title!
Raman Experiment Figure NAME

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.NOTES
%%%% ¡title!
Raman Experiment NOTES

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.SELECTED_SP
%%%% ¡title!
SPECTRUM

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ST_AREA
%%%% ¡title!
FILLED AREA (average spectrum)

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ST_LINE
%%%% ¡title!
LINE (average spectrum)

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.LINES
%%%% ¡title!
LINES ON/OFF (all spectra)

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.LINE_DICT
%%%% ¡title!
LINES PROPERTIES (all spectra)

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
RamanExperimentPF.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure Raman experiment.
%%%% ¡default!
'RamanExperimentPF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure Raman experiment.
%%%% ¡default!
'Panel figure Raman experiment'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure Raman experiment.
%%%% ¡default!
'RamanExperimentPF manages the basic functionalities to plot of a Raman experiment.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure Raman experiment.
%%%% ¡settings!
'RamanExperimentPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure Raman experiment.
%%%% ¡default!
'RamanExperimentPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure Raman experiment.
%%%% ¡default!
'RamanExperimentPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure Raman experiment.
%%%% ¡default!
'RamanExperimentPF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure Raman experiment.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')

    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', RamanExperimentPF.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');

    pf.memorize('H_AREA')
    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', RamanExperimentPF.H_AREA).get('SETUP')
    pf.memorize('LISTENER_ST_AREA');

    pf.memorize('H_LINES')
    pf.set('LINES', pf.get('LINES')) % sets also LINE_DICT  

    pf.memorize('H_LINE')
    pf.memorize('ST_LINE').set('PANEL', pf, 'PROP', RamanExperimentPF.H_LINE).get('SETUP')
    pf.memorize('LISTENER_ST_LINE');

    pf.memorize('H_TITLE')
    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', RamanExperimentPF.H_TITLE).get('SETUP')

    pf.memorize('H_XLABEL')
    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', RamanExperimentPF.H_XLABEL).get('SETUP')

    pf.memorize('H_YLABEL')
    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', RamanExperimentPF.H_YLABEL).get('SETUP')

    pf.get('SETUP')
end
%%%% ¡calculate_callbacks!
function cb_lines(~, ~, lines) % (src, event)
    pf.set('LINES', lines)
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())

    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
    
    pf.set('H_AREA', Element.getNoValue())
    pf.set('LISTENER_ST_AREA', Element.getNoValue())
 
    pf.set('H_LINES', Element.getNoValue())

    pf.set('H_LINE', Element.getNoValue())
    pf.set('LISTENER_ST_LINE', Element.getNoValue())

    pf.set('H_TITLE', Element.getNoValue())

    pf.set('H_XLABEL', Element.getNoValue())
    
    pf.set('H_YLABEL', Element.getNoValue())
end

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
%%%% ¡calculate!
toolbar = pf.memorize('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
    
    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % Axis
    tool_axis = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Axis', ...
        'Separator', 'on', ...
        'State', pf.get('ST_AXIS').get('AXIS'), ...
        'Tooltip', 'Show axis', ...
        'CData', imread('icon_axis.png'), ...
        'OnCallback', {@cb_axis, true}, ...
        'OffCallback', {@cb_axis, false});

    % Grid
    tool_grid = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Grid', ...
        'State', pf.get('ST_AXIS').get('GRID'), ...
        'Tooltip', 'Show grid', ...
        'CData', imread('icon_grid.png'), ...
        'OnCallback', {@cb_grid, true}, ...
        'OffCallback', {@cb_grid, false});

    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % Measure Area
    tool_area = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Area', ...
        'State', pf.get('ST_AREA').get('VISIBLE'), ...
        'Tooltip', 'Show measure area', ...
        'CData', imresize(imread('icon_area.png'), [16 16]), ...
        'OnCallback', {@cb_area, true}, ...
        'OffCallback', {@cb_area, false});
    
    % Measure Line
    tool_line = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Line', ...
        'State', pf.get('ST_LINE').get('VISIBLE'), ...
        'Tooltip', 'Show measure line', ...
        'CData', imresize(imread('icon_line.png'), [16 16]), ...
        'OnCallback', {@cb_line, true}, ...
        'OffCallback', {@cb_line, false});

    % Symbols
    tool_lines = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Lines', ...
        'Separator', 'on', ...
        'State', pf.get('LINES'), ...
        'Tooltip', 'Show Lines', ...
        'CData', imresize(imread('icon_3lines_mono.png'), [16 16]), ...
        'OnCallback', {@cb_lines, true}, ...
        'OffCallback', {@cb_lines, false});

    value = {value{:}, ...
        tool_separator_1, ...
        tool_axis, tool_grid, ...
        tool_separator_2, ...
        tool_area, tool_line, tool_lines ...
        };
else
    value = {};
end
%%%% ¡calculate_callbacks!
function cb_axis(~, ~, axis) % (src, event)
    pf.get('ST_AXIS').set('AXIS', axis);
    
    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_grid(~, ~, grid) % (src, event)
    pf.get('ST_AXIS').set('GRID', grid);

    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_area(~, ~, visible) % (src, event)
    pf.get('ST_AREA').set('VISIBLE', visible)

    % triggers the update of ST_AREA
    pf.set('ST_AREA', pf.get('ST_AREA'))
end
function cb_line(~, ~, visible) % (src, event)
	pf.get('ST_LINE').set('VISIBLE', visible)

    % triggers the update of ST_LINE
    pf.set('ST_LINE', pf.get('ST_LINE'))
end

%% ¡props!

%%% ¡prop!
H_AXES (evanescent, handle) is the handle for the axes.
%%%% ¡calculate!
h_axes = uiaxes( ...
    'Parent', pf.memorize('H'), ...
    'Tag', 'H_AXES', ...
    'Units', 'normalized', ...
    'OuterPosition', [.2 .2 .6 .6] ... % % % %TODO transform this into a prop?
    );
h_axes.Toolbar.Visible = 'on';
%h_axes.Interactions = [];
box(h_axes, 'on')
hold(h_axes, 'on')
value = h_axes;

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false)
%%%% ¡postset!
if pf.get('DRAWN')
    toolbar = pf.get('H_TOOLBAR');
    if check_graphics(toolbar, 'uitoolbar')
        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
    end
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', RamanExperimentPF.ST_AXIS, varargin{:});

%%% ¡prop!
LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
%%%% ¡calculate!
value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis); 
%%%% ¡calculate_callbacks!
function cb_listener_st_axis(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
        end
    end
end

%%% ¡prop!
RE (metadata, item) is the Raman experiment.
%%%% ¡settings!
'RamanExperiment'

%%% ¡prop!
SELECTED_SP (figure, scalar) is the spectrum number to be plotted.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡gui!
pr = RamanExperimentPFPP_SelectedSp('EL', pf, 'PROP', RamanExperimentPF.SELECTED_SP);

%%% ¡prop!
SETUP (query, empty) calculates the Raman spectrum and stores it.
%%%% ¡calculate!
sp_dict = pf.get('RE').get('SP_DICT');

if sp_dict.get('LENGTH')
    sp = sp_dict.get('IT', pf.get('SELECTED_SP'));

    x = sp.get('WAVELENGTH');
    y = sp.get('INTENSITY_MEAN');

    pf.memorize('ST_AREA').set('X', [x(1); x; x(end)], 'Y', [0; y; 0])

    for i = 1:1:sp.get('NO_AQUISITIONS')
        pf.get('LINE_DICT').get('IT', i).set('X', x, 'Y', sp.get('INTENSITY', i))
    end

    % % % set the other lines

    pf.memorize('ST_LINE').set('X', x, 'Y', y)

    xlim = [ ...
        min(cellfun(@(sp) min(sp.get('WAVELENGTH')), sp_dict.get('IT_LIST'))) ...
        max(cellfun(@(sp) max(sp.get('WAVELENGTH')), sp_dict.get('IT_LIST'))) ...
        ];
    set(pf.get('H_AXES'), 'XLim', xlim);

    ylim = [ ...
        min(sp.get('INTENSITY_MEAN')) ... % min(cellfun(@(sp) min(sp.get('INTENSITY_MEAN')), sp_dict.get('IT_LIST'))) ...
        max(sp.get('INTENSITY_MEAN')) ... % max(cellfun(@(sp) max(sp.get('INTENSITY_MEAN')), sp_dict.get('IT_LIST'))) ...
        ];
    set(pf.get('H_AXES'), 'YLim', ylim);
    
    pf.get('ST_TITLE').set( ...
        'TXT', sp.get('LABEL'), ...
        'X', .5 * (xlim(2) + xlim(1)), ...
        'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
        'Z', 0 ...
        )
    pf.get('ST_XLABEL').set( ...
        'TXT', 'Raman Shift (cm-1)', ...
        'X', .5 * (xlim(2) + xlim(1)), ...
        'Y', ylim(1) - .10 * (ylim(2) - ylim(1)), ...
        'Z', 0 ...
        )
    pf.get('ST_YLABEL').set( ...
        'TXT', 'Intensity', ...
        'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
        'Y', .5 * (ylim(2) + ylim(1)), ...
        'Z', 0 ...
        )
end

value = [];

%%% ¡prop!
H_AREA (evanescent, handle) is the handle for the average spectrum area.
%%%% ¡calculate!
value = fill(pf.get('H_AXES'), [0], [0], 'k');

%%% ¡prop!
ST_AREA (figure, item) determines the average spectrum area settings.
%%%% ¡settings!
'SettingsArea'
%%%% ¡gui!
pr = SettingsAreaPP('EL', pf, 'PROP', RamanExperimentPF.ST_AREA, varargin{:});

%%% ¡prop!
LISTENER_ST_AREA (evanescent, handle) contains the listener to the average spectrum area settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area); 
%%%% ¡calculate_callbacks!
function cb_listener_st_area(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Area'), 'State', pf.get('ST_AREA').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_LINE (evanescent, handle) is the handle for the average spectrum line.
%%%% ¡calculate!
value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);

%%% ¡prop!
ST_LINE (figure, item) determines the average spectrum line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡default!
SettingsLine('SYMBOLSIZE', 1)
%%%% ¡gui!
pr = SettingsLinePP('EL', pf, 'PROP', RamanExperimentPF.ST_LINE, varargin{:});

%%% ¡prop!
LISTENER_ST_LINE (evanescent, handle) contains the listener to the average spectrum line settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_LINE'), 'PropSet', @cb_listener_st_line); 
%%%% ¡calculate_callbacks!
function cb_listener_st_line(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Line'), 'State', pf.get('ST_LINE').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_LINES (evanescent, handlelist) is the set of handles for the symbols.
%%%% ¡calculate!
sp_dict = pf.memorize('RE').get('SP_DICT');
if sp_dict.get('LENGTH')
    L = sp_dict.get('IT', pf.get('SELECTED_SP')).get('NO_AQUISITIONS');
else
    L = 0;
end

h_lines = cell(1, L);
for i = 1:1:L
    h_lines{i} = plot(0, 0, ...
        'Parent', pf.get('H_AXES'), ...
        'Tag', ['H_LINES{' int2str(i) '}'], ...
        'Visible', false ...
        );
end
value = h_lines;

%%% ¡prop!
LINES (figure, logical) determines whether the single spectra are shown.
%%%% ¡default!
true
%%%% ¡postset!
if ~pf.get('LINES') % false
    h_lines = pf.get('H_LINES');
    for i = 1:1:length(h_lines)
        set(h_lines{i}, 'Visible', false)
    end        
else % true
    % triggers the update of LINE_DICT
    pf.set('LINE_DICT', pf.get('LINE_DICT'))
end

% update state of toggle tool
toolbar = pf.get('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    set(findobj(toolbar, 'Tag', 'TOOL.Lines'), 'State', pf.get('LINES'))
end

%%% ¡prop!
LINE_DICT (figure, idict) contains the lines of the spectra.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postset!
if pf.get('LINES') && ~isa(pf.getr('RE'), 'NoValue')
    
    sp_dict = pf.get('RE').get('SP_DICT');
    if sp_dict.get('LENGTH')
        sp = sp_dict.get('IT', pf.get('SELECTED_SP'));
    else
        sp = Spectrum();
    end

	if pf.get('LINE_DICT').get('LENGTH') == 0 && sp.get('NO_AQUISITIONS')
        for i = 1:1:sp.get('NO_AQUISITIONS')
            lines{i} = SettingsLine( ...
                'PANEL', pf, ...
                'PROP', RamanExperimentPF.H_LINES, ...
                'I', i, ...
                'VISIBLE', true, ...
                'ID', sp.get('ID'), ...
                'LINEWIDTH', .5, ...
                'LINECOLOR', [.7 .7 .7], ...
                'SYMBOL', 'none' ...
                );
        end
        pf.get('LINE_DICT').set('IT_LIST', lines)
    end
    
    for i = 1:1:sp.get('NO_AQUISITIONS')
        pf.get('LINE_DICT').get('IT', i).get('SETUP')
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', RamanExperimentPF.LINE_DICT, ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsLine.VISIBLE SettingsLine.LINESTYLE SettingsLine.LINEWIDTH SettingsLine.LINECOLOR SettingsLine.SYMBOL SettingsLine.SYMBOLSIZE SettingsLine.EDGECOLOR SettingsLine.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
H_TITLE (evanescent, handle) is the axis title.
%%%% ¡calculate!
value = title(pf.get('H_AXES'), '');

if isa(pf.getr('ST_TITLE'), 'NoValue')
    st = pf.memorize('ST_TITLE');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', pf.get('RE').get('LABEL'), ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_TITLE (figure, item) determines the title settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle')
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', RamanExperimentPF.ST_TITLE, varargin{:});

%%% ¡prop!
H_XLABEL (evanescent, handle) is the axis x-label.
%%%% ¡calculate!
value = xlabel(pf.get('H_AXES'), '');

if isa(pf.getr('ST_XLABEL'), 'NoValue')
    st = pf.memorize('ST_XLABEL');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', 'Wavelength', ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_XLABEL (figure, item) determines the x-label settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle')
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', RamanExperimentPF.ST_XLABEL, varargin{:});

%%% ¡prop!
H_YLABEL (evanescent, handle) is the axis y-label.
%%%% ¡calculate!
value = ylabel(pf.get('H_AXES'), '');

if isa(pf.getr('ST_YLABEL'), 'NoValue')
    st = pf.memorize('ST_YLABEL');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', 'Intensity', ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_YLABEL (figure, item) determines the y-label settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90)
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', RamanExperimentPF.ST_YLABEL, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[RamanExperimentPF.PARENT RamanExperimentPF.H RamanExperimentPF.ST_POSITION RamanExperimentPF.ST_AXIS RamanExperimentPF.ST_AREA RamanExperimentPF.ST_LINE RamanExperimentPF.ST_TITLE RamanExperimentPF.ST_XLABEL RamanExperimentPF.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':RamanExperimentPF'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':RamanExperimentPF'])