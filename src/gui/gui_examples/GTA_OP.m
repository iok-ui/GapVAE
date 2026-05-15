classdef GTA_OP < ConcreteElement
	%GTA_OP tests PanelPropOption.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_OP tests PanelPropOption.
	%
	% The list of GTA_OP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>OP_C</strong> 	OP_C (constant, option) is a prop constant option.
	%  <strong>10</strong> <strong>OP_M</strong> 	OP_M (metadata, option) is a prop metadata option.
	%  <strong>11</strong> <strong>OP_P</strong> 	OP_P (parameter, option) is a prop parameter option.
	%  <strong>12</strong> <strong>OP_D</strong> 	OP_D (data, option) is a prop data option.
	%  <strong>13</strong> <strong>OP_R</strong> 	OP_R (result, option) is a prop result option.
	%  <strong>14</strong> <strong>OP_Q</strong> 	OP_Q (query, option) is a prop query option.
	%  <strong>15</strong> <strong>OP_E</strong> 	OP_E (evanescent, option) is a prop evanescent option.
	%  <strong>16</strong> <strong>OP_F</strong> 	OP_F (figure, option) is a prop figure option.
	%  <strong>17</strong> <strong>OP_G</strong> 	OP_G (gui, option) is a prop gui option.
	%
	% GTA_OP methods (constructor):
	%  GTA_OP - constructor
	%
	% GTA_OP methods:
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
	% GTA_OP methods (display):
	%  tostring - string with information about the test A PanelPropOption
	%  disp - displays information about the test A PanelPropOption
	%  tree - displays the tree of the test A PanelPropOption
	%
	% GTA_OP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropOption are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropOption
	%
	% GTA_OP methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropOption as b2 file
	%  load - loads a BRAPH2 test A PanelPropOption from a b2 file
	%
	% GTA_OP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropOption
	%
	% GTA_OP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropOption
	%
	% GTA_OP methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropOption
	%  getSubclasses - returns all subclasses of GTA_OP
	%  getProps - returns the property list of the test A PanelPropOption
	%  getPropNumber - returns the property number of the test A PanelPropOption
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
	% GTA_OP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_OP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_OP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_OP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_OP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_OP constants</a>.
	%
	%
	% See also PanelPropOption.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		OP_C = 9; %CET: Computational Efficiency Trick
		OP_C_TAG = 'OP_C';
		OP_C_CATEGORY = 1;
		OP_C_FORMAT = 5;
		
		OP_M = 10; %CET: Computational Efficiency Trick
		OP_M_TAG = 'OP_M';
		OP_M_CATEGORY = 2;
		OP_M_FORMAT = 5;
		
		OP_P = 11; %CET: Computational Efficiency Trick
		OP_P_TAG = 'OP_P';
		OP_P_CATEGORY = 3;
		OP_P_FORMAT = 5;
		
		OP_D = 12; %CET: Computational Efficiency Trick
		OP_D_TAG = 'OP_D';
		OP_D_CATEGORY = 4;
		OP_D_FORMAT = 5;
		
		OP_R = 13; %CET: Computational Efficiency Trick
		OP_R_TAG = 'OP_R';
		OP_R_CATEGORY = 5;
		OP_R_FORMAT = 5;
		
		OP_Q = 14; %CET: Computational Efficiency Trick
		OP_Q_TAG = 'OP_Q';
		OP_Q_CATEGORY = 6;
		OP_Q_FORMAT = 5;
		
		OP_E = 15; %CET: Computational Efficiency Trick
		OP_E_TAG = 'OP_E';
		OP_E_CATEGORY = 7;
		OP_E_FORMAT = 5;
		
		OP_F = 16; %CET: Computational Efficiency Trick
		OP_F_TAG = 'OP_F';
		OP_F_CATEGORY = 8;
		OP_F_FORMAT = 5;
		
		OP_G = 17; %CET: Computational Efficiency Trick
		OP_G_TAG = 'OP_G';
		OP_G_CATEGORY = 9;
		OP_G_FORMAT = 5;
	end
	methods % constructor
		function gt = GTA_OP(varargin)
			%GTA_OP() creates a test A PanelPropOption.
			%
			% GTA_OP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_OP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_OP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>OP_C</strong> 	OP_C (constant, option) is a prop constant option.
			%  <strong>10</strong> <strong>OP_M</strong> 	OP_M (metadata, option) is a prop metadata option.
			%  <strong>11</strong> <strong>OP_P</strong> 	OP_P (parameter, option) is a prop parameter option.
			%  <strong>12</strong> <strong>OP_D</strong> 	OP_D (data, option) is a prop data option.
			%  <strong>13</strong> <strong>OP_R</strong> 	OP_R (result, option) is a prop result option.
			%  <strong>14</strong> <strong>OP_Q</strong> 	OP_Q (query, option) is a prop query option.
			%  <strong>15</strong> <strong>OP_E</strong> 	OP_E (evanescent, option) is a prop evanescent option.
			%  <strong>16</strong> <strong>OP_F</strong> 	OP_F (figure, option) is a prop figure option.
			%  <strong>17</strong> <strong>OP_G</strong> 	OP_G (gui, option) is a prop gui option.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropOption.
			%
			% BUILD = GTA_OP.GETBUILD() returns the build of 'GTA_OP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropOption GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_OP') returns the build of 'GTA_OP'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_OP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropOption.
			%
			% CLASS = GTA_OP.GETCLASS() returns the class 'GTA_OP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropOption GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_OP') returns 'GTA_OP'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_OP')
			%  are less computationally efficient.
			
			gt_class = 'GTA_OP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropOption.
			%
			% LIST = GTA_OP.GETSUBCLASSES() returns all subclasses of 'GTA_OP'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropOption GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_OP') returns all subclasses of 'GTA_OP'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_OP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_OP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropOption.
			%
			% PROPS = GTA_OP.GETPROPS() returns the property list of test A PanelPropOption
			%  as a row vector.
			%
			% PROPS = GTA_OP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropOption GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_OP'[, CATEGORY]) returns the property list of 'GTA_OP'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_OP')
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
			%GETPROPNUMBER returns the property number of test A PanelPropOption.
			%
			% N = GTA_OP.GETPROPNUMBER() returns the property number of test A PanelPropOption.
			%
			% N = GTA_OP.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropOption
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropOption GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_OP') returns the property number of 'GTA_OP'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_OP')
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
			%EXISTSPROP checks whether property exists in test A PanelPropOption/error.
			%
			% CHECK = GTA_OP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_OP, PROP) checks whether PROP exists for GTA_OP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSPROP(GTA_OP, PROP) throws error if PROP does NOT exist for GTA_OP.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_OP:' 'WrongInput'], ...
					['BRAPH2' ':GTA_OP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_OP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropOption/error.
			%
			% CHECK = GTA_OP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_OP, TAG) checks whether TAG exists for GTA_OP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%  Element.EXISTSTAG(GTA_OP, TAG) throws error if TAG does NOT exist for GTA_OP.
			%   Error id: [BRAPH2:GTA_OP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'OP_C'  'OP_M'  'OP_P'  'OP_D'  'OP_R'  'OP_Q'  'OP_E'  'OP_F'  'OP_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_OP:' 'WrongInput'], ...
					['BRAPH2' ':GTA_OP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_OP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_OP, POINTER) returns property number of POINTER of GTA_OP.
			%  PROPERTY = GT.GETPROPPROP(GTA_OP, POINTER) returns property number of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'OP_C'  'OP_M'  'OP_P'  'OP_D'  'OP_R'  'OP_Q'  'OP_E'  'OP_F'  'OP_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_OP, POINTER) returns tag of POINTER of GTA_OP.
			%  TAG = GT.GETPROPTAG(GTA_OP, POINTER) returns tag of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_op_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'OP_C'  'OP_M'  'OP_P'  'OP_D'  'OP_R'  'OP_Q'  'OP_E'  'OP_F'  'OP_G' };
				tag = gta_op_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_OP, POINTER) returns category of POINTER of GTA_OP.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_OP, POINTER) returns category of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_OP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_op_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_op_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_OP, POINTER) returns format of POINTER of GTA_OP.
			%  FORMAT = GT.GETPROPFORMAT(GTA_OP, POINTER) returns format of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_OP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_op_format_list = { 2  2  2  8  2  2  2  2  5  5  5  5  5  5  5  5  5 };
			prop_format = gta_op_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_OP, POINTER) returns description of POINTER of GTA_OP.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_OP, POINTER) returns description of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_op_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'OP_C (constant, option) is a prop constant option.'  'OP_M (metadata, option) is a prop metadata option.'  'OP_P (parameter, option) is a prop parameter option.'  'OP_D (data, option) is a prop data option.'  'OP_R (result, option) is a prop result option.'  'OP_Q (query, option) is a prop query option.'  'OP_E (evanescent, option) is a prop evanescent option.'  'OP_F (figure, option) is a prop figure option.'  'OP_G (gui, option) is a prop gui option.' };
			prop_description = gta_op_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_OP, POINTER) returns settings of POINTER of GTA_OP.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_OP, POINTER) returns settings of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_OP.OP_C
					prop_settings = Format.getFormatSettings(5);
				case 10 % GTA_OP.OP_M
					prop_settings = {'M_A', 'M_B', 'M_C', 'M_D', 'M_E', 'M_F', 'M_G', 'M_H', 'M_J', 'M_K'};
				case 11 % GTA_OP.OP_P
					prop_settings = {'P_A', 'P_B', 'P_C', 'P_D', 'P_E', 'P_F', 'P_G', 'P_H', 'P_J', 'P_K'};
				case 12 % GTA_OP.OP_D
					prop_settings = {'D_A', 'D_B', 'D_C', 'D_D', 'D_E', 'D_F', 'D_G', 'D_H', 'D_J', 'D_K'};
				case 13 % GTA_OP.OP_R
					prop_settings = {'R_A', 'R_B', 'R_C', 'R_D', 'R_E', 'R_F', 'R_G', 'R_H', 'R_J', 'R_K'};
				case 14 % GTA_OP.OP_Q
					prop_settings = {'Q_A', 'Q_B', 'Q_C', 'Q_D', 'Q_E', 'Q_F', 'Q_G', 'Q_H', 'Q_J', 'Q_K'};
				case 15 % GTA_OP.OP_E
					prop_settings = {'E_A', 'E_B', 'E_C', 'E_D', 'E_E', 'E_F', 'E_G', 'E_H', 'E_J', 'E_K'};
				case 16 % GTA_OP.OP_F
					prop_settings = {'F_A', 'F_B', 'F_C', 'F_D', 'F_E', 'F_F', 'F_G', 'F_H', 'F_J', 'F_K'};
				case 17 % GTA_OP.OP_G
					prop_settings = {'G_A', 'G_B', 'G_C', 'G_D', 'G_E', 'G_F', 'G_G', 'G_H', 'G_J', 'G_K'};
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_OP, POINTER) returns the default value of POINTER of GTA_OP.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_OP, POINTER) returns the default value of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_OP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_OP.OP_C
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 10 % GTA_OP.OP_M
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 11 % GTA_OP.OP_P
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 12 % GTA_OP.OP_D
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 13 % GTA_OP.OP_R
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 14 % GTA_OP.OP_Q
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 15 % GTA_OP.OP_E
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 16 % GTA_OP.OP_F
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				case 17 % GTA_OP.OP_G
					prop_default = Format.getFormatDefault(5, GTA_OP.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_OP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_OP, POINTER) returns the conditioned default value of POINTER of GTA_OP.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_OP, POINTER) returns the conditioned default value of POINTER of GTA_OP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_OP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_OP.getPropProp(pointer);
			
			prop_default = GTA_OP.conditioning(prop, GTA_OP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_OP, PROP, VALUE) checks VALUE format for PROP of GTA_OP.
			%  CHECK = GT.CHECKPROP(GTA_OP, PROP, VALUE) checks VALUE format for PROP of GTA_OP.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_OP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_OP:WrongInput
			%  Element.CHECKPROP(GTA_OP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_OP.
			%   Error id: BRAPH2:GTA_OP:WrongInput
			%  GT.CHECKPROP(GTA_OP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_OP.
			%   Error id: BRAPH2:GTA_OP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_OP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_OP.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_OP.OP_C
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 10 % GTA_OP.OP_M
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 11 % GTA_OP.OP_P
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 12 % GTA_OP.OP_D
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 13 % GTA_OP.OP_R
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 14 % GTA_OP.OP_Q
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 15 % GTA_OP.OP_E
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 16 % GTA_OP.OP_F
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				case 17 % GTA_OP.OP_G
					check = Format.checkFormat(5, value, GTA_OP.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_OP:' 'WrongInput'], ...
					['BRAPH2' ':GTA_OP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_OP.getPropTag(prop) ' (' GTA_OP.getFormatTag(GTA_OP.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(gt, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 10 % GTA_OP.OP_M
					if strcmp(gt.get('OP_M'), 'M_B')
					    gt.set( ...
					        'OP_P', 'P_B', ...
					        'OP_D', 'D_B', ...
					        'OP_F', 'F_B', ...
					        'OP_G', 'G_B' ...
					        )
					end
					
				case 11 % GTA_OP.OP_P
					if strcmp(gt.get('OP_P'), 'P_C')
					    gt.set( ...
					        'OP_M', 'M_C', ...
					        'OP_D', 'D_C', ...
					        'OP_F', 'F_C', ...
					        'OP_G', 'G_C' ...
					        )
					end
					
				case 12 % GTA_OP.OP_D
					if strcmp(gt.get('OP_D'), 'D_D')
					    gt.set( ...
					        'OP_M', 'M_D', ...
					        'OP_P', 'P_D', ...
					        'OP_F', 'F_D', ...
					        'OP_G', 'G_D' ...
					        )
					end
					
				case 16 % GTA_OP.OP_F
					if strcmp(gt.get('OP_F'), 'F_E')
					    gt.set( ...
					        'OP_M', 'M_E', ...
					        'OP_P', 'P_E', ...
					        'OP_D', 'D_E', ...
					        'OP_G', 'G_E' ...
					        )
					end
					
				case 17 % GTA_OP.OP_G
					if strcmp(gt.get('OP_G'), 'G_F')
					    gt.set( ...
					        'OP_M', 'M_F', ...
					        'OP_P', 'P_F', ...
					        'OP_D', 'D_F', ...
					        'OP_F', 'F_F' ...
					        )
					end
					
				otherwise
					if prop <= 8
						postset@ConcreteElement(gt, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(gt, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 13 % GTA_OP.OP_R
					rng_settings_ = rng(); rng(gt.getPropSeed(13), 'twister')
					
					settings = GTA_OP.getPropSettings('OP_R');
					index = randi(length(settings));
					value = settings{index};
					
					rng(rng_settings_)
					
				case 14 % GTA_OP.OP_Q
					settings = GTA_OP.getPropSettings('OP_Q');
					index = randi(length(settings));
					value = settings{index};
					
				case 15 % GTA_OP.OP_E
					settings = GTA_OP.getPropSettings('OP_E');
					index = randi(length(settings));
					value = settings{index};
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(gt, prop, varargin{:});
					else
						value = calculateValue@Element(gt, prop, varargin{:});
					end
			end
			
		end
	end
end
