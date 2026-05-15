classdef GTA_LN < ConcreteElement
	%GTA_LN tests PanelPropLine.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_LN tests PanelPropLine.
	%
	% The list of GTA_LN properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>LN_C</strong> 	LN_C (constant, line) is a prop constant line.
	%  <strong>10</strong> <strong>LN_M</strong> 	LN_M (metadata, line) is a prop metadata line.
	%  <strong>11</strong> <strong>LN_P</strong> 	LN_P (parameter, line) is a prop parameter line.
	%  <strong>12</strong> <strong>LN_D</strong> 	LN_D (data, line) is a prop data line.
	%  <strong>13</strong> <strong>LN_R</strong> 	LN_R (result, line) is a prop result line.
	%  <strong>14</strong> <strong>LN_Q</strong> 	LN_Q (query, line) is a prop query line.
	%  <strong>15</strong> <strong>LN_E</strong> 	LN_E (evanescent, line) is a prop evanescent line.
	%  <strong>16</strong> <strong>LN_F</strong> 	LN_F (figure, line) is a prop figure line.
	%  <strong>17</strong> <strong>LN_G</strong> 	LN_G (gui, line) is a prop gui line.
	%
	% GTA_LN methods (constructor):
	%  GTA_LN - constructor
	%
	% GTA_LN methods:
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
	% GTA_LN methods (display):
	%  tostring - string with information about the test A PanelPropLine
	%  disp - displays information about the test A PanelPropLine
	%  tree - displays the tree of the test A PanelPropLine
	%
	% GTA_LN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropLine are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropLine
	%
	% GTA_LN methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropLine as b2 file
	%  load - loads a BRAPH2 test A PanelPropLine from a b2 file
	%
	% GTA_LN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropLine
	%
	% GTA_LN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropLine
	%
	% GTA_LN methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropLine
	%  getSubclasses - returns all subclasses of GTA_LN
	%  getProps - returns the property list of the test A PanelPropLine
	%  getPropNumber - returns the property number of the test A PanelPropLine
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
	% GTA_LN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_LN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_LN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_LN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_LN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_LN constants</a>.
	%
	%
	% See also PanelPropLine.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		LN_C = 9; %CET: Computational Efficiency Trick
		LN_C_TAG = 'LN_C';
		LN_C_CATEGORY = 1;
		LN_C_FORMAT = 24;
		
		LN_M = 10; %CET: Computational Efficiency Trick
		LN_M_TAG = 'LN_M';
		LN_M_CATEGORY = 2;
		LN_M_FORMAT = 24;
		
		LN_P = 11; %CET: Computational Efficiency Trick
		LN_P_TAG = 'LN_P';
		LN_P_CATEGORY = 3;
		LN_P_FORMAT = 24;
		
		LN_D = 12; %CET: Computational Efficiency Trick
		LN_D_TAG = 'LN_D';
		LN_D_CATEGORY = 4;
		LN_D_FORMAT = 24;
		
		LN_R = 13; %CET: Computational Efficiency Trick
		LN_R_TAG = 'LN_R';
		LN_R_CATEGORY = 5;
		LN_R_FORMAT = 24;
		
		LN_Q = 14; %CET: Computational Efficiency Trick
		LN_Q_TAG = 'LN_Q';
		LN_Q_CATEGORY = 6;
		LN_Q_FORMAT = 24;
		
		LN_E = 15; %CET: Computational Efficiency Trick
		LN_E_TAG = 'LN_E';
		LN_E_CATEGORY = 7;
		LN_E_FORMAT = 24;
		
		LN_F = 16; %CET: Computational Efficiency Trick
		LN_F_TAG = 'LN_F';
		LN_F_CATEGORY = 8;
		LN_F_FORMAT = 24;
		
		LN_G = 17; %CET: Computational Efficiency Trick
		LN_G_TAG = 'LN_G';
		LN_G_CATEGORY = 9;
		LN_G_FORMAT = 24;
	end
	methods % constructor
		function gt = GTA_LN(varargin)
			%GTA_LN() creates a test A PanelPropLine.
			%
			% GTA_LN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_LN(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_LN properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>LN_C</strong> 	LN_C (constant, line) is a prop constant line.
			%  <strong>10</strong> <strong>LN_M</strong> 	LN_M (metadata, line) is a prop metadata line.
			%  <strong>11</strong> <strong>LN_P</strong> 	LN_P (parameter, line) is a prop parameter line.
			%  <strong>12</strong> <strong>LN_D</strong> 	LN_D (data, line) is a prop data line.
			%  <strong>13</strong> <strong>LN_R</strong> 	LN_R (result, line) is a prop result line.
			%  <strong>14</strong> <strong>LN_Q</strong> 	LN_Q (query, line) is a prop query line.
			%  <strong>15</strong> <strong>LN_E</strong> 	LN_E (evanescent, line) is a prop evanescent line.
			%  <strong>16</strong> <strong>LN_F</strong> 	LN_F (figure, line) is a prop figure line.
			%  <strong>17</strong> <strong>LN_G</strong> 	LN_G (gui, line) is a prop gui line.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropLine.
			%
			% BUILD = GTA_LN.GETBUILD() returns the build of 'GTA_LN'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropLine GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_LN') returns the build of 'GTA_LN'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_LN')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropLine.
			%
			% CLASS = GTA_LN.GETCLASS() returns the class 'GTA_LN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropLine GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_LN') returns 'GTA_LN'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_LN')
			%  are less computationally efficient.
			
			gt_class = 'GTA_LN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropLine.
			%
			% LIST = GTA_LN.GETSUBCLASSES() returns all subclasses of 'GTA_LN'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropLine GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_LN') returns all subclasses of 'GTA_LN'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_LN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_LN' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropLine.
			%
			% PROPS = GTA_LN.GETPROPS() returns the property list of test A PanelPropLine
			%  as a row vector.
			%
			% PROPS = GTA_LN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropLine GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_LN'[, CATEGORY]) returns the property list of 'GTA_LN'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_LN')
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
			%GETPROPNUMBER returns the property number of test A PanelPropLine.
			%
			% N = GTA_LN.GETPROPNUMBER() returns the property number of test A PanelPropLine.
			%
			% N = GTA_LN.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropLine
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropLine GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_LN') returns the property number of 'GTA_LN'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_LN')
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
			%EXISTSPROP checks whether property exists in test A PanelPropLine/error.
			%
			% CHECK = GTA_LN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_LN, PROP) checks whether PROP exists for GTA_LN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSPROP(GTA_LN, PROP) throws error if PROP does NOT exist for GTA_LN.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LN:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LN:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_LN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropLine/error.
			%
			% CHECK = GTA_LN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_LN, TAG) checks whether TAG exists for GTA_LN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%  Element.EXISTSTAG(GTA_LN, TAG) throws error if TAG does NOT exist for GTA_LN.
			%   Error id: [BRAPH2:GTA_LN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LN_C'  'LN_M'  'LN_P'  'LN_D'  'LN_R'  'LN_Q'  'LN_E'  'LN_F'  'LN_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LN:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LN:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_LN.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_LN, POINTER) returns property number of POINTER of GTA_LN.
			%  PROPERTY = GT.GETPROPPROP(GTA_LN, POINTER) returns property number of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LN_C'  'LN_M'  'LN_P'  'LN_D'  'LN_R'  'LN_Q'  'LN_E'  'LN_F'  'LN_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_LN, POINTER) returns tag of POINTER of GTA_LN.
			%  TAG = GT.GETPROPTAG(GTA_LN, POINTER) returns tag of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_ln_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'LN_C'  'LN_M'  'LN_P'  'LN_D'  'LN_R'  'LN_Q'  'LN_E'  'LN_F'  'LN_G' };
				tag = gta_ln_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_LN, POINTER) returns category of POINTER of GTA_LN.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_LN, POINTER) returns category of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_LN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_ln_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_ln_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_LN, POINTER) returns format of POINTER of GTA_LN.
			%  FORMAT = GT.GETPROPFORMAT(GTA_LN, POINTER) returns format of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_LN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_ln_format_list = { 2  2  2  8  2  2  2  2  24  24  24  24  24  24  24  24  24 };
			prop_format = gta_ln_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_LN, POINTER) returns description of POINTER of GTA_LN.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_LN, POINTER) returns description of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_ln_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'LN_C (constant, line) is a prop constant line.'  'LN_M (metadata, line) is a prop metadata line.'  'LN_P (parameter, line) is a prop parameter line.'  'LN_D (data, line) is a prop data line.'  'LN_R (result, line) is a prop result line.'  'LN_Q (query, line) is a prop query line.'  'LN_E (evanescent, line) is a prop evanescent line.'  'LN_F (figure, line) is a prop figure line.'  'LN_G (gui, line) is a prop gui line.' };
			prop_description = gta_ln_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_LN, POINTER) returns settings of POINTER of GTA_LN.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_LN, POINTER) returns settings of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_LN.LN_C
					prop_settings = Format.getFormatSettings(24);
				case 10 % GTA_LN.LN_M
					prop_settings = Format.getFormatSettings(24);
				case 11 % GTA_LN.LN_P
					prop_settings = Format.getFormatSettings(24);
				case 12 % GTA_LN.LN_D
					prop_settings = Format.getFormatSettings(24);
				case 13 % GTA_LN.LN_R
					prop_settings = Format.getFormatSettings(24);
				case 14 % GTA_LN.LN_Q
					prop_settings = Format.getFormatSettings(24);
				case 15 % GTA_LN.LN_E
					prop_settings = Format.getFormatSettings(24);
				case 16 % GTA_LN.LN_F
					prop_settings = Format.getFormatSettings(24);
				case 17 % GTA_LN.LN_G
					prop_settings = Format.getFormatSettings(24);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_LN, POINTER) returns the default value of POINTER of GTA_LN.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_LN, POINTER) returns the default value of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_LN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_LN.LN_C
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 10 % GTA_LN.LN_M
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 11 % GTA_LN.LN_P
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 12 % GTA_LN.LN_D
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 13 % GTA_LN.LN_R
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 14 % GTA_LN.LN_Q
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 15 % GTA_LN.LN_E
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 16 % GTA_LN.LN_F
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				case 17 % GTA_LN.LN_G
					prop_default = Format.getFormatDefault(24, GTA_LN.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_LN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_LN, POINTER) returns the conditioned default value of POINTER of GTA_LN.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_LN, POINTER) returns the conditioned default value of POINTER of GTA_LN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_LN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_LN.getPropProp(pointer);
			
			prop_default = GTA_LN.conditioning(prop, GTA_LN.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_LN, PROP, VALUE) checks VALUE format for PROP of GTA_LN.
			%  CHECK = GT.CHECKPROP(GTA_LN, PROP, VALUE) checks VALUE format for PROP of GTA_LN.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_LN:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_LN:WrongInput
			%  Element.CHECKPROP(GTA_LN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LN.
			%   Error id: BRAPH2:GTA_LN:WrongInput
			%  GT.CHECKPROP(GTA_LN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_LN.
			%   Error id: BRAPH2:GTA_LN:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_LN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_LN.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_LN.LN_C
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 10 % GTA_LN.LN_M
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 11 % GTA_LN.LN_P
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 12 % GTA_LN.LN_D
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 13 % GTA_LN.LN_R
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 14 % GTA_LN.LN_Q
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 15 % GTA_LN.LN_E
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 16 % GTA_LN.LN_F
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				case 17 % GTA_LN.LN_G
					check = Format.checkFormat(24, value, GTA_LN.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_LN:' 'WrongInput'], ...
					['BRAPH2' ':GTA_LN:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_LN.getPropTag(prop) ' (' GTA_LN.getFormatTag(GTA_LN.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
