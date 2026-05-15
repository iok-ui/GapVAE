classdef GTA_LL < ConcreteElement
	%GTA_LL tests PanelPropCell.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_LL tests PanelPropCell.
	%
	% The list of GTA_LL properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>LL_C</strong> 	LL_C (constant, cell) is a prop constant cell.
	%  <strong>10</strong> <strong>LL_M</strong> 	LL_M (metadata, cell) is a prop metadata cell.
	%  <strong>11</strong> <strong>LL_P</strong> 	LL_P (parameter, cell) is a prop parameter cell.
	%  <strong>12</strong> <strong>LL_D</strong> 	LL_D (data, cell) is a prop data cell.
	%  <strong>13</strong> <strong>LL_R</strong> 	LL_R (result, cell) is a prop result cell.
	%  <strong>14</strong> <strong>LL_Q</strong> 	LL_Q (query, cell) is a prop query cell.
	%  <strong>15</strong> <strong>LL_E</strong> 	LL_E (evanescent, cell) is a prop evanescent cell.
	%  <strong>16</strong> <strong>LL_F</strong> 	LL_F (figure, cell) is a prop figure cell.
	%  <strong>17</strong> <strong>LL_G</strong> 	LL_G (gui, cell) is a prop gui cell.
	%
	% GTA_LL methods (constructor):
	%  GTA_LL - constructor
	%
	% GTA_LL methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% GTA_LL methods (display):
	%  tostring - string with information about the test A PanelPropCell
	%  disp - displays information about the test A PanelPropCell
	%  tree - displays the tree of the test A PanelPropCell
	%
	% GTA_LL methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropCell are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropCell
	%
	% GTA_LL methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropCell as b2 file
	%  load - loads a BRAPH2 test A PanelPropCell from a b2 file
	%
	% GTA_LL method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropCell
	%
	% GTA_LL method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropCell
	%
	% GTA_LL methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropCell
	%  getSubclasses - returns all subclasses of GTA_LL
	%  getProps - returns the property list of the test A PanelPropCell
	%  getPropNumber - returns the property number of the test A PanelPropCell
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% GTA_LL methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_LL methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_LL methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_LL methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_LL; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_LL constants</a>.
	%
	%
	% See also PanelPropCell.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		LL_C = 9; %CET: Computational Efficiency Trick
		LL_C_TAG = 'LL_C';
		LL_C_CATEGORY = 1;
		LL_C_FORMAT = 16;
		
		LL_M = 10; %CET: Computational Efficiency Trick
		LL_M_TAG = 'LL_M';
		LL_M_CATEGORY = 2;
		LL_M_FORMAT = 16;
		
		LL_P = 11; %CET: Computational Efficiency Trick
		LL_P_TAG = 'LL_P';
		LL_P_CATEGORY = 3;
		LL_P_FORMAT = 16;
		
		LL_D = 12; %CET: Computational Efficiency Trick
		LL_D_TAG = 'LL_D';
		LL_D_CATEGORY = 4;
		LL_D_FORMAT = 16;
		
		LL_R = 13; %CET: Computational Efficiency Trick
		LL_R_TAG = 'LL_R';
		LL_R_CATEGORY = 5;
		LL_R_FORMAT = 16;
		
		LL_Q = 14; %CET: Computational Efficiency Trick
		LL_Q_TAG = 'LL_Q';
		LL_Q_CATEGORY = 6;
		LL_Q_FORMAT = 16;
		
		LL_E = 15; %CET: Computational Efficiency Trick
		LL_E_TAG = 'LL_E';
		LL_E_CATEGORY = 7;
		LL_E_FORMAT = 16;
		
		LL_F = 16; %CET: Computational Efficiency Trick
		LL_F_TAG = 'LL_F';
		LL_F_CATEGORY = 8;
		LL_F_FORMAT = 16;
		
		LL_G = 17; %CET: Computational Efficiency Trick
		LL_G_TAG = 'LL_G';
		LL_G_CATEGORY = 9;
		LL_G_FORMAT = 16;
	end
	methods % constructor
		function gt = GTA_LL(varargin)
			%GTA_LL() creates a test A PanelPropCell.
			%
			% GTA_LL(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_LL(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_LL properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>LL_C</strong> 	LL_C (constant, cell) is a prop constant cell.
			%  <strong>10</strong> <strong>LL_M</strong> 	LL_M (metadata, cell) is a prop metadata cell.
			%  <strong>11</strong> <strong>LL_P</strong> 	LL_P (parameter, cell) is a prop parameter cell.
			%  <strong>12</strong> <strong>LL_D</strong> 	LL_D (data, cell) is a prop data cell.
			%  <strong>13</strong> <strong>LL_R</strong> 	LL_R (result, cell) is a prop result cell.
			%  <strong>14</strong> <strong>LL_Q</strong> 	LL_Q (query, cell) is a prop query cell.
			%  <strong>15</strong> <strong>LL_E</strong> 	LL_E (evanescent, cell) is a prop evanescent cell.
			%  <strong>16</strong> <strong>LL_F</strong> 	LL_F (figure, cell) is a prop figure cell.
			%  <strong>17</strong> <strong>LL_G</strong> 	LL_G (gui, cell) is a prop gui cell.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropCell.
			%
			% BUILD = GTA_LL.GETBUILD() returns the build of 'GTA_LL'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropCell GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_LL') returns the build of 'GTA_LL'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_LL')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropCell.
			%
			% CLASS = GTA_LL.GETCLASS() returns the class 'GTA_LL'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropCell GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_LL') returns 'GTA_LL'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_LL')
			%  are less computationally efficient.
			
			gt_class = 'GTA_LL';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropCell.
			%
			% LIST = GTA_LL.GETSUBCLASSES() returns all subclasses of 'GTA_LL'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropCell GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_LL') returns all subclasses of 'GTA_LL'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_LL')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_LL' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropCell.
			%
			% PROPS = GTA_LL.GETPROPS() returns the property list of test A PanelPropCell
			%  as a row vector.
			%
			% PROPS = GTA_LL.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropCell GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_LL'[, CATEGORY]) returns the property list of 'GTA_LL'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3 9];
				case 2 % Category.METADATA
					prop_list = [6 7 10];
				case 3 % Category.PARAMETER
					prop_list = [4 11];
				case 4 % Category.DATA
					prop_list = [5 12];
				case 5 % Category.RESULT
					prop_list = 13;
				case 6 % Category.QUERY
					prop_list = [8 14];
				case 7 % Category.EVANESCENT
					prop_list = 15;
				case 8 % Category.FIGURE
					prop_list = 16;
				case 9 % Category.GUI
					prop_list = 17;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of test A PanelPropCell.
			%
			% N = GTA_LL.GETPROPNUMBER() returns the property number of test A PanelPropCell.
			%
			% N = GTA_LL.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropCell
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropCell GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_LL') returns the property number of 'GTA_LL'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 17;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 4;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 2;
				case 7 % Category.EVANESCENT
					prop_number = 1;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in test A PanelPropCell/error.
			%
			% CHECK = GTA_LL.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_LL, PROP) checks whether PROP exists for GTA_LL.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSPROP(GTA_LL, PROP) throws error if PROP does NOT exist for GTA_LL.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LL:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LL:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_LL.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropCell/error.
			%
			% CHECK = GTA_LL.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_LL, TAG) checks whether TAG exists for GTA_LL.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%  Element.EXISTSTAG(GTA_LL, TAG) throws error if TAG does NOT exist for GTA_LL.
			%   Error id: [BRAPH2:GTA_LL:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LL_C'  'LL_M'  'LL_P'  'LL_D'  'LL_R'  'LL_Q'  'LL_E'  'LL_F'  'LL_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LL:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LL:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_LL.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = GT.GETPROPPROP(POINTER) returns property number of POINTER of GT.
			%  PROPERTY = Element.GETPROPPROP(GTA_LL, POINTER) returns property number of POINTER of GTA_LL.
			%  PROPERTY = GT.GETPROPPROP(GTA_LL, POINTER) returns property number of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LL_C'  'LL_M'  'LL_P'  'LL_D'  'LL_R'  'LL_Q'  'LL_E'  'LL_F'  'LL_G' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = GT.GETPROPTAG(POINTER) returns tag of POINTER of GT.
			%  TAG = Element.GETPROPTAG(GTA_LL, POINTER) returns tag of POINTER of GTA_LL.
			%  TAG = GT.GETPROPTAG(GTA_LL, POINTER) returns tag of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_ll_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LL_C'  'LL_M'  'LL_P'  'LL_D'  'LL_R'  'LL_Q'  'LL_E'  'LL_F'  'LL_G' };
				tag = gta_ll_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = GT.GETPROPCATEGORY(POINTER) returns category of POINTER of GT.
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_LL, POINTER) returns category of POINTER of GTA_LL.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_LL, POINTER) returns category of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_LL')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_ll_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_ll_category_list{prop};
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = GT.GETPROPFORMAT(POINTER) returns format of POINTER of GT.
			%  FORMAT = Element.GETPROPFORMAT(GTA_LL, POINTER) returns format of POINTER of GTA_LL.
			%  FORMAT = GT.GETPROPFORMAT(GTA_LL, POINTER) returns format of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_LL')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_ll_format_list = { 2  2  2  8  2  2  2  2  16  16  16  16  16  16  16  16  16 };
			prop_format = gta_ll_format_list{prop};
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(POINTER) returns description of POINTER of GT.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_LL, POINTER) returns description of POINTER of GTA_LL.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_LL, POINTER) returns description of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_ll_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'LL_C (constant, cell) is a prop constant cell.'  'LL_M (metadata, cell) is a prop metadata cell.'  'LL_P (parameter, cell) is a prop parameter cell.'  'LL_D (data, cell) is a prop data cell.'  'LL_R (result, cell) is a prop result cell.'  'LL_Q (query, cell) is a prop query cell.'  'LL_E (evanescent, cell) is a prop evanescent cell.'  'LL_F (figure, cell) is a prop figure cell.'  'LL_G (gui, cell) is a prop gui cell.' };
			prop_description = gta_ll_description_list{prop};
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = GT.GETPROPSETTINGS(POINTER) returns settings of POINTER of GT.
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_LL, POINTER) returns settings of POINTER of GTA_LL.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_LL, POINTER) returns settings of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_LL.LL_C
					prop_settings = Format.getFormatSettings(16);
				case 10 % GTA_LL.LL_M
					prop_settings = Format.getFormatSettings(16);
				case 11 % GTA_LL.LL_P
					prop_settings = Format.getFormatSettings(16);
				case 12 % GTA_LL.LL_D
					prop_settings = Format.getFormatSettings(16);
				case 13 % GTA_LL.LL_R
					prop_settings = Format.getFormatSettings(16);
				case 14 % GTA_LL.LL_Q
					prop_settings = Format.getFormatSettings(16);
				case 15 % GTA_LL.LL_E
					prop_settings = Format.getFormatSettings(16);
				case 16 % GTA_LL.LL_F
					prop_settings = Format.getFormatSettings(16);
				case 17 % GTA_LL.LL_G
					prop_settings = Format.getFormatSettings(16);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_LL, POINTER) returns the default value of POINTER of GTA_LL.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_LL, POINTER) returns the default value of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_LL')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_LL.LL_C
					prop_default = {ones(3, 5)};
				case 10 % GTA_LL.LL_M
					prop_default = {ones(2, 3) 2*ones(3, 2) 3*ones(4, 1)};
				case 11 % GTA_LL.LL_P
					prop_default = {ones(2, 3); 2*ones(3, 2); 3*ones(4, 1)};
				case 12 % GTA_LL.LL_D
					prop_default = {1.1*ones(1, 1) 1.2*ones(1, 2); 2.1*ones(2, 1) 2.2*ones(2, 2); 3.1*ones(3, 1) 3.2*ones(3, 2)};
				case 13 % GTA_LL.LL_R
					prop_default = Format.getFormatDefault(16, GTA_LL.getPropSettings(prop));
				case 14 % GTA_LL.LL_Q
					prop_default = Format.getFormatDefault(16, GTA_LL.getPropSettings(prop));
				case 15 % GTA_LL.LL_E
					prop_default = Format.getFormatDefault(16, GTA_LL.getPropSettings(prop));
				case 16 % GTA_LL.LL_F
					prop_default = {1.1*ones(1, 1) 1.2*ones(1, 2); 2.1*ones(2, 1) 2.2*ones(2, 2)};
				case 17 % GTA_LL.LL_G
					prop_default = Format.getFormatDefault(16, GTA_LL.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LL.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_LL, POINTER) returns the conditioned default value of POINTER of GTA_LL.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_LL, POINTER) returns the conditioned default value of POINTER of GTA_LL.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_LL')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_LL.getPropProp(pointer);
			
			prop_default = GTA_LL.conditioning(prop, GTA_LL.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = GT.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = GT.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of GT.
			%  CHECK = Element.CHECKPROP(GTA_LL, PROP, VALUE) checks VALUE format for PROP of GTA_LL.
			%  CHECK = GT.CHECKPROP(GTA_LL, PROP, VALUE) checks VALUE format for PROP of GTA_LL.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_LL:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_LL:WrongInput
			%  Element.CHECKPROP(GTA_LL, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LL.
			%   Error id: BRAPH2:GTA_LL:WrongInput
			%  GT.CHECKPROP(GTA_LL, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LL.
			%   Error id: BRAPH2:GTA_LL:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_LL')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_LL.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_LL.LL_C
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 10 % GTA_LL.LL_M
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 11 % GTA_LL.LL_P
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 12 % GTA_LL.LL_D
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 13 % GTA_LL.LL_R
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 14 % GTA_LL.LL_Q
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 15 % GTA_LL.LL_E
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 16 % GTA_LL.LL_F
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				case 17 % GTA_LL.LL_G
					check = Format.checkFormat(16, value, GTA_LL.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LL:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LL:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_LL.getPropTag(prop) ' (' GTA_LL.getFormatTag(GTA_LL.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
