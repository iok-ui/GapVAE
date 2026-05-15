classdef GTA_LO < ConcreteElement
	%GTA_LO tests PanelPropLogical.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_LO tests PanelPropLogical.
	%
	% The list of GTA_LO properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>LO_C</strong> 	LO_C (constant, logical) is a prop constant logical.
	%  <strong>10</strong> <strong>LO_M</strong> 	LO_M (metadata, logical) is a prop metadata logical.
	%  <strong>11</strong> <strong>LO_P</strong> 	LO_P (parameter, logical) is a prop parameter logical.
	%  <strong>12</strong> <strong>LO_D</strong> 	LO_D (data, logical) is a prop data logical.
	%  <strong>13</strong> <strong>LO_R</strong> 	LO_R (result, logical) is a prop result logical.
	%  <strong>14</strong> <strong>LO_Q</strong> 	LO_Q (query, logical) is a prop query logical.
	%  <strong>15</strong> <strong>LO_E</strong> 	LO_E (evanescent, logical) is a prop evanescent logical.
	%  <strong>16</strong> <strong>LO_F</strong> 	LO_F (figure, logical) is a prop figure logical.
	%  <strong>17</strong> <strong>LO_G</strong> 	LO_G (gui, logical) is a prop gui logical.
	%
	% GTA_LO methods (constructor):
	%  GTA_LO - constructor
	%
	% GTA_LO methods:
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
	% GTA_LO methods (display):
	%  tostring - string with information about the test A PanelPropLogical
	%  disp - displays information about the test A PanelPropLogical
	%  tree - displays the tree of the test A PanelPropLogical
	%
	% GTA_LO methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropLogical are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropLogical
	%
	% GTA_LO methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropLogical as b2 file
	%  load - loads a BRAPH2 test A PanelPropLogical from a b2 file
	%
	% GTA_LO method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropLogical
	%
	% GTA_LO method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropLogical
	%
	% GTA_LO methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropLogical
	%  getSubclasses - returns all subclasses of GTA_LO
	%  getProps - returns the property list of the test A PanelPropLogical
	%  getPropNumber - returns the property number of the test A PanelPropLogical
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
	% GTA_LO methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_LO methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_LO methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_LO methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_LO; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_LO constants</a>.
	%
	%
	% See also PanelPropLogical.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		LO_C = 9; %CET: Computational Efficiency Trick
		LO_C_TAG = 'LO_C';
		LO_C_CATEGORY = 1;
		LO_C_FORMAT = 4;
		
		LO_M = 10; %CET: Computational Efficiency Trick
		LO_M_TAG = 'LO_M';
		LO_M_CATEGORY = 2;
		LO_M_FORMAT = 4;
		
		LO_P = 11; %CET: Computational Efficiency Trick
		LO_P_TAG = 'LO_P';
		LO_P_CATEGORY = 3;
		LO_P_FORMAT = 4;
		
		LO_D = 12; %CET: Computational Efficiency Trick
		LO_D_TAG = 'LO_D';
		LO_D_CATEGORY = 4;
		LO_D_FORMAT = 4;
		
		LO_R = 13; %CET: Computational Efficiency Trick
		LO_R_TAG = 'LO_R';
		LO_R_CATEGORY = 5;
		LO_R_FORMAT = 4;
		
		LO_Q = 14; %CET: Computational Efficiency Trick
		LO_Q_TAG = 'LO_Q';
		LO_Q_CATEGORY = 6;
		LO_Q_FORMAT = 4;
		
		LO_E = 15; %CET: Computational Efficiency Trick
		LO_E_TAG = 'LO_E';
		LO_E_CATEGORY = 7;
		LO_E_FORMAT = 4;
		
		LO_F = 16; %CET: Computational Efficiency Trick
		LO_F_TAG = 'LO_F';
		LO_F_CATEGORY = 8;
		LO_F_FORMAT = 4;
		
		LO_G = 17; %CET: Computational Efficiency Trick
		LO_G_TAG = 'LO_G';
		LO_G_CATEGORY = 9;
		LO_G_FORMAT = 4;
	end
	methods % constructor
		function gt = GTA_LO(varargin)
			%GTA_LO() creates a test A PanelPropLogical.
			%
			% GTA_LO(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_LO(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_LO properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>LO_C</strong> 	LO_C (constant, logical) is a prop constant logical.
			%  <strong>10</strong> <strong>LO_M</strong> 	LO_M (metadata, logical) is a prop metadata logical.
			%  <strong>11</strong> <strong>LO_P</strong> 	LO_P (parameter, logical) is a prop parameter logical.
			%  <strong>12</strong> <strong>LO_D</strong> 	LO_D (data, logical) is a prop data logical.
			%  <strong>13</strong> <strong>LO_R</strong> 	LO_R (result, logical) is a prop result logical.
			%  <strong>14</strong> <strong>LO_Q</strong> 	LO_Q (query, logical) is a prop query logical.
			%  <strong>15</strong> <strong>LO_E</strong> 	LO_E (evanescent, logical) is a prop evanescent logical.
			%  <strong>16</strong> <strong>LO_F</strong> 	LO_F (figure, logical) is a prop figure logical.
			%  <strong>17</strong> <strong>LO_G</strong> 	LO_G (gui, logical) is a prop gui logical.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropLogical.
			%
			% BUILD = GTA_LO.GETBUILD() returns the build of 'GTA_LO'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropLogical GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_LO') returns the build of 'GTA_LO'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_LO')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropLogical.
			%
			% CLASS = GTA_LO.GETCLASS() returns the class 'GTA_LO'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropLogical GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_LO') returns 'GTA_LO'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_LO')
			%  are less computationally efficient.
			
			gt_class = 'GTA_LO';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropLogical.
			%
			% LIST = GTA_LO.GETSUBCLASSES() returns all subclasses of 'GTA_LO'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropLogical GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_LO') returns all subclasses of 'GTA_LO'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_LO')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_LO' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropLogical.
			%
			% PROPS = GTA_LO.GETPROPS() returns the property list of test A PanelPropLogical
			%  as a row vector.
			%
			% PROPS = GTA_LO.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropLogical GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_LO'[, CATEGORY]) returns the property list of 'GTA_LO'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_LO')
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
			%GETPROPNUMBER returns the property number of test A PanelPropLogical.
			%
			% N = GTA_LO.GETPROPNUMBER() returns the property number of test A PanelPropLogical.
			%
			% N = GTA_LO.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropLogical
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropLogical GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_LO') returns the property number of 'GTA_LO'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_LO')
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
			%EXISTSPROP checks whether property exists in test A PanelPropLogical/error.
			%
			% CHECK = GTA_LO.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_LO, PROP) checks whether PROP exists for GTA_LO.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSPROP(GTA_LO, PROP) throws error if PROP does NOT exist for GTA_LO.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LO:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LO:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_LO.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropLogical/error.
			%
			% CHECK = GTA_LO.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_LO, TAG) checks whether TAG exists for GTA_LO.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%  Element.EXISTSTAG(GTA_LO, TAG) throws error if TAG does NOT exist for GTA_LO.
			%   Error id: [BRAPH2:GTA_LO:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LO_C'  'LO_M'  'LO_P'  'LO_D'  'LO_R'  'LO_Q'  'LO_E'  'LO_F'  'LO_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LO:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LO:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_LO.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_LO, POINTER) returns property number of POINTER of GTA_LO.
			%  PROPERTY = GT.GETPROPPROP(GTA_LO, POINTER) returns property number of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LO_C'  'LO_M'  'LO_P'  'LO_D'  'LO_R'  'LO_Q'  'LO_E'  'LO_F'  'LO_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_LO, POINTER) returns tag of POINTER of GTA_LO.
			%  TAG = GT.GETPROPTAG(GTA_LO, POINTER) returns tag of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_lo_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LO_C'  'LO_M'  'LO_P'  'LO_D'  'LO_R'  'LO_Q'  'LO_E'  'LO_F'  'LO_G' };
				tag = gta_lo_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_LO, POINTER) returns category of POINTER of GTA_LO.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_LO, POINTER) returns category of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_LO')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_lo_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_lo_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_LO, POINTER) returns format of POINTER of GTA_LO.
			%  FORMAT = GT.GETPROPFORMAT(GTA_LO, POINTER) returns format of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_LO')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_lo_format_list = { 2  2  2  8  2  2  2  2  4  4  4  4  4  4  4  4  4 };
			prop_format = gta_lo_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_LO, POINTER) returns description of POINTER of GTA_LO.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_LO, POINTER) returns description of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_lo_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'LO_C (constant, logical) is a prop constant logical.'  'LO_M (metadata, logical) is a prop metadata logical.'  'LO_P (parameter, logical) is a prop parameter logical.'  'LO_D (data, logical) is a prop data logical.'  'LO_R (result, logical) is a prop result logical.'  'LO_Q (query, logical) is a prop query logical.'  'LO_E (evanescent, logical) is a prop evanescent logical.'  'LO_F (figure, logical) is a prop figure logical.'  'LO_G (gui, logical) is a prop gui logical.' };
			prop_description = gta_lo_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_LO, POINTER) returns settings of POINTER of GTA_LO.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_LO, POINTER) returns settings of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_LO.LO_C
					prop_settings = Format.getFormatSettings(4);
				case 10 % GTA_LO.LO_M
					prop_settings = Format.getFormatSettings(4);
				case 11 % GTA_LO.LO_P
					prop_settings = Format.getFormatSettings(4);
				case 12 % GTA_LO.LO_D
					prop_settings = Format.getFormatSettings(4);
				case 13 % GTA_LO.LO_R
					prop_settings = Format.getFormatSettings(4);
				case 14 % GTA_LO.LO_Q
					prop_settings = Format.getFormatSettings(4);
				case 15 % GTA_LO.LO_E
					prop_settings = Format.getFormatSettings(4);
				case 16 % GTA_LO.LO_F
					prop_settings = Format.getFormatSettings(4);
				case 17 % GTA_LO.LO_G
					prop_settings = Format.getFormatSettings(4);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_LO, POINTER) returns the default value of POINTER of GTA_LO.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_LO, POINTER) returns the default value of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_LO')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_LO.LO_C
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 10 % GTA_LO.LO_M
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 11 % GTA_LO.LO_P
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 12 % GTA_LO.LO_D
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 13 % GTA_LO.LO_R
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 14 % GTA_LO.LO_Q
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 15 % GTA_LO.LO_E
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 16 % GTA_LO.LO_F
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				case 17 % GTA_LO.LO_G
					prop_default = Format.getFormatDefault(4, GTA_LO.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LO.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_LO, POINTER) returns the conditioned default value of POINTER of GTA_LO.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_LO, POINTER) returns the conditioned default value of POINTER of GTA_LO.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_LO')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_LO.getPropProp(pointer);
			
			prop_default = GTA_LO.conditioning(prop, GTA_LO.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_LO, PROP, VALUE) checks VALUE format for PROP of GTA_LO.
			%  CHECK = GT.CHECKPROP(GTA_LO, PROP, VALUE) checks VALUE format for PROP of GTA_LO.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_LO:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_LO:WrongInput
			%  Element.CHECKPROP(GTA_LO, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LO.
			%   Error id: BRAPH2:GTA_LO:WrongInput
			%  GT.CHECKPROP(GTA_LO, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LO.
			%   Error id: BRAPH2:GTA_LO:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_LO')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_LO.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_LO.LO_C
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 10 % GTA_LO.LO_M
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 11 % GTA_LO.LO_P
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 12 % GTA_LO.LO_D
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 13 % GTA_LO.LO_R
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 14 % GTA_LO.LO_Q
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 15 % GTA_LO.LO_E
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 16 % GTA_LO.LO_F
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				case 17 % GTA_LO.LO_G
					check = Format.checkFormat(4, value, GTA_LO.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LO:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LO:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_LO.getPropTag(prop) ' (' GTA_LO.getFormatTag(GTA_LO.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
