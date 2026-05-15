classdef GTA_DI < ConcreteElement
	%GTA_DI tests PanelPropIDict.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_DI tests PanelPropIDict.
	%
	% The list of GTA_DI properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>DI_C</strong> 	DI_C (constant, idict) is a prop constant idict.
	%  <strong>10</strong> <strong>DI_M</strong> 	DI_M (metadata, idict) is a prop metadata idict.
	%  <strong>11</strong> <strong>DI_P</strong> 	DI_P (parameter, idict) is a prop parameter idict.
	%  <strong>12</strong> <strong>DI_D</strong> 	DI_D (data, idict) is a prop data idict.
	%  <strong>13</strong> <strong>DI_R</strong> 	DI_R (result, idict) is a prop result idict.
	%  <strong>14</strong> <strong>DI_Q</strong> 	DI_Q (query, idict) is a prop query idict.
	%  <strong>15</strong> <strong>DI_E</strong> 	DI_E (evanescent, idict) is a prop evanescent idict.
	%  <strong>16</strong> <strong>DI_F</strong> 	DI_F (figure, idict) is a prop figure idict.
	%  <strong>17</strong> <strong>DI_G</strong> 	DI_G (gui, idict) is a prop gui idict.
	%
	% GTA_DI methods (constructor):
	%  GTA_DI - constructor
	%
	% GTA_DI methods:
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
	% GTA_DI methods (display):
	%  tostring - string with information about the test A PanelPropIDict
	%  disp - displays information about the test A PanelPropIDict
	%  tree - displays the tree of the test A PanelPropIDict
	%
	% GTA_DI methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropIDict are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropIDict
	%
	% GTA_DI methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropIDict as b2 file
	%  load - loads a BRAPH2 test A PanelPropIDict from a b2 file
	%
	% GTA_DI method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropIDict
	%
	% GTA_DI method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropIDict
	%
	% GTA_DI methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropIDict
	%  getSubclasses - returns all subclasses of GTA_DI
	%  getProps - returns the property list of the test A PanelPropIDict
	%  getPropNumber - returns the property number of the test A PanelPropIDict
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
	% GTA_DI methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_DI methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_DI methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_DI methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_DI; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_DI constants</a>.
	%
	%
	% See also PanelPropIDict.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		DI_C = 9; %CET: Computational Efficiency Trick
		DI_C_TAG = 'DI_C';
		DI_C_CATEGORY = 1;
		DI_C_FORMAT = 10;
		
		DI_M = 10; %CET: Computational Efficiency Trick
		DI_M_TAG = 'DI_M';
		DI_M_CATEGORY = 2;
		DI_M_FORMAT = 10;
		
		DI_P = 11; %CET: Computational Efficiency Trick
		DI_P_TAG = 'DI_P';
		DI_P_CATEGORY = 3;
		DI_P_FORMAT = 10;
		
		DI_D = 12; %CET: Computational Efficiency Trick
		DI_D_TAG = 'DI_D';
		DI_D_CATEGORY = 4;
		DI_D_FORMAT = 10;
		
		DI_R = 13; %CET: Computational Efficiency Trick
		DI_R_TAG = 'DI_R';
		DI_R_CATEGORY = 5;
		DI_R_FORMAT = 10;
		
		DI_Q = 14; %CET: Computational Efficiency Trick
		DI_Q_TAG = 'DI_Q';
		DI_Q_CATEGORY = 6;
		DI_Q_FORMAT = 10;
		
		DI_E = 15; %CET: Computational Efficiency Trick
		DI_E_TAG = 'DI_E';
		DI_E_CATEGORY = 7;
		DI_E_FORMAT = 10;
		
		DI_F = 16; %CET: Computational Efficiency Trick
		DI_F_TAG = 'DI_F';
		DI_F_CATEGORY = 8;
		DI_F_FORMAT = 10;
		
		DI_G = 17; %CET: Computational Efficiency Trick
		DI_G_TAG = 'DI_G';
		DI_G_CATEGORY = 9;
		DI_G_FORMAT = 10;
	end
	methods % constructor
		function gt = GTA_DI(varargin)
			%GTA_DI() creates a test A PanelPropIDict.
			%
			% GTA_DI(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_DI(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_DI properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>DI_C</strong> 	DI_C (constant, idict) is a prop constant idict.
			%  <strong>10</strong> <strong>DI_M</strong> 	DI_M (metadata, idict) is a prop metadata idict.
			%  <strong>11</strong> <strong>DI_P</strong> 	DI_P (parameter, idict) is a prop parameter idict.
			%  <strong>12</strong> <strong>DI_D</strong> 	DI_D (data, idict) is a prop data idict.
			%  <strong>13</strong> <strong>DI_R</strong> 	DI_R (result, idict) is a prop result idict.
			%  <strong>14</strong> <strong>DI_Q</strong> 	DI_Q (query, idict) is a prop query idict.
			%  <strong>15</strong> <strong>DI_E</strong> 	DI_E (evanescent, idict) is a prop evanescent idict.
			%  <strong>16</strong> <strong>DI_F</strong> 	DI_F (figure, idict) is a prop figure idict.
			%  <strong>17</strong> <strong>DI_G</strong> 	DI_G (gui, idict) is a prop gui idict.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropIDict.
			%
			% BUILD = GTA_DI.GETBUILD() returns the build of 'GTA_DI'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropIDict GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_DI') returns the build of 'GTA_DI'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_DI')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropIDict.
			%
			% CLASS = GTA_DI.GETCLASS() returns the class 'GTA_DI'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropIDict GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_DI') returns 'GTA_DI'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_DI')
			%  are less computationally efficient.
			
			gt_class = 'GTA_DI';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropIDict.
			%
			% LIST = GTA_DI.GETSUBCLASSES() returns all subclasses of 'GTA_DI'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropIDict GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_DI') returns all subclasses of 'GTA_DI'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_DI')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_DI' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropIDict.
			%
			% PROPS = GTA_DI.GETPROPS() returns the property list of test A PanelPropIDict
			%  as a row vector.
			%
			% PROPS = GTA_DI.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropIDict GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_DI'[, CATEGORY]) returns the property list of 'GTA_DI'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_DI')
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
			%GETPROPNUMBER returns the property number of test A PanelPropIDict.
			%
			% N = GTA_DI.GETPROPNUMBER() returns the property number of test A PanelPropIDict.
			%
			% N = GTA_DI.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropIDict
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropIDict GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_DI') returns the property number of 'GTA_DI'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_DI')
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
			%EXISTSPROP checks whether property exists in test A PanelPropIDict/error.
			%
			% CHECK = GTA_DI.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_DI, PROP) checks whether PROP exists for GTA_DI.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSPROP(GTA_DI, PROP) throws error if PROP does NOT exist for GTA_DI.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_DI:' 'WrongInput'], ...
					['BRAPH2' ':GTA_DI:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_DI.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropIDict/error.
			%
			% CHECK = GTA_DI.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_DI, TAG) checks whether TAG exists for GTA_DI.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%  Element.EXISTSTAG(GTA_DI, TAG) throws error if TAG does NOT exist for GTA_DI.
			%   Error id: [BRAPH2:GTA_DI:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'DI_C'  'DI_M'  'DI_P'  'DI_D'  'DI_R'  'DI_Q'  'DI_E'  'DI_F'  'DI_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_DI:' 'WrongInput'], ...
					['BRAPH2' ':GTA_DI:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_DI.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_DI, POINTER) returns property number of POINTER of GTA_DI.
			%  PROPERTY = GT.GETPROPPROP(GTA_DI, POINTER) returns property number of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'DI_C'  'DI_M'  'DI_P'  'DI_D'  'DI_R'  'DI_Q'  'DI_E'  'DI_F'  'DI_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_DI, POINTER) returns tag of POINTER of GTA_DI.
			%  TAG = GT.GETPROPTAG(GTA_DI, POINTER) returns tag of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_di_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'DI_C'  'DI_M'  'DI_P'  'DI_D'  'DI_R'  'DI_Q'  'DI_E'  'DI_F'  'DI_G' };
				tag = gta_di_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_DI, POINTER) returns category of POINTER of GTA_DI.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_DI, POINTER) returns category of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_DI')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_di_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_di_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_DI, POINTER) returns format of POINTER of GTA_DI.
			%  FORMAT = GT.GETPROPFORMAT(GTA_DI, POINTER) returns format of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_DI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_di_format_list = { 2  2  2  8  2  2  2  2  10  10  10  10  10  10  10  10  10 };
			prop_format = gta_di_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_DI, POINTER) returns description of POINTER of GTA_DI.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_DI, POINTER) returns description of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_di_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'DI_C (constant, idict) is a prop constant idict.'  'DI_M (metadata, idict) is a prop metadata idict.'  'DI_P (parameter, idict) is a prop parameter idict.'  'DI_D (data, idict) is a prop data idict.'  'DI_R (result, idict) is a prop result idict.'  'DI_Q (query, idict) is a prop query idict.'  'DI_E (evanescent, idict) is a prop evanescent idict.'  'DI_F (figure, idict) is a prop figure idict.'  'DI_G (gui, idict) is a prop gui idict.' };
			prop_description = gta_di_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_DI, POINTER) returns settings of POINTER of GTA_DI.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_DI, POINTER) returns settings of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_DI.DI_C
					prop_settings = Format.getFormatSettings(10);
				case 10 % GTA_DI.DI_M
					prop_settings = Format.getFormatSettings(10);
				case 11 % GTA_DI.DI_P
					prop_settings = Format.getFormatSettings(10);
				case 12 % GTA_DI.DI_D
					prop_settings = Format.getFormatSettings(10);
				case 13 % GTA_DI.DI_R
					prop_settings = Format.getFormatSettings(10);
				case 14 % GTA_DI.DI_Q
					prop_settings = Format.getFormatSettings(10);
				case 15 % GTA_DI.DI_E
					prop_settings = Format.getFormatSettings(10);
				case 16 % GTA_DI.DI_F
					prop_settings = Format.getFormatSettings(10);
				case 17 % GTA_DI.DI_G
					prop_settings = Format.getFormatSettings(10);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_DI, POINTER) returns the default value of POINTER of GTA_DI.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_DI, POINTER) returns the default value of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_DI')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_DI.DI_C
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 10 % GTA_DI.DI_M
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 11 % GTA_DI.DI_P
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 12 % GTA_DI.DI_D
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 13 % GTA_DI.DI_R
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 14 % GTA_DI.DI_Q
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 15 % GTA_DI.DI_E
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 16 % GTA_DI.DI_F
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				case 17 % GTA_DI.DI_G
					prop_default = Format.getFormatDefault(10, GTA_DI.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_DI.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_DI, POINTER) returns the conditioned default value of POINTER of GTA_DI.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_DI, POINTER) returns the conditioned default value of POINTER of GTA_DI.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_DI')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_DI.getPropProp(pointer);
			
			prop_default = GTA_DI.conditioning(prop, GTA_DI.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_DI, PROP, VALUE) checks VALUE format for PROP of GTA_DI.
			%  CHECK = GT.CHECKPROP(GTA_DI, PROP, VALUE) checks VALUE format for PROP of GTA_DI.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_DI:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_DI:WrongInput
			%  Element.CHECKPROP(GTA_DI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_DI.
			%   Error id: BRAPH2:GTA_DI:WrongInput
			%  GT.CHECKPROP(GTA_DI, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_DI.
			%   Error id: BRAPH2:GTA_DI:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_DI')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_DI.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_DI.DI_C
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 10 % GTA_DI.DI_M
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 11 % GTA_DI.DI_P
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 12 % GTA_DI.DI_D
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 13 % GTA_DI.DI_R
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 14 % GTA_DI.DI_Q
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 15 % GTA_DI.DI_E
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 16 % GTA_DI.DI_F
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				case 17 % GTA_DI.DI_G
					check = Format.checkFormat(10, value, GTA_DI.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_DI:' 'WrongInput'], ...
					['BRAPH2' ':GTA_DI:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_DI.getPropTag(prop) ' (' GTA_DI.getFormatTag(GTA_DI.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
