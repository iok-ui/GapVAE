classdef GTA_ST_TA < ConcreteElement
	%GTA_ST_TA tests PanelPropStringTextArea.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_ST_TA tests PanelPropStringTextArea.
	%
	% The list of GTA_ST_TA properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>ST_C</strong> 	ST_C (constant, string) is a prop constant string.
	%  <strong>10</strong> <strong>ST_M</strong> 	ST_M (metadata, string) is a prop metadata string.
	%  <strong>11</strong> <strong>ST_P</strong> 	ST_P (parameter, string) is a prop parameter string.
	%  <strong>12</strong> <strong>ST_D</strong> 	ST_D (data, string) is a prop data string.
	%  <strong>13</strong> <strong>ST_R</strong> 	ST_R (result, string) is a prop result string.
	%  <strong>14</strong> <strong>ST_Q</strong> 	ST_Q (query, string) is a prop query string.
	%  <strong>15</strong> <strong>ST_E</strong> 	ST_E (evanescent, string) is a prop evanescent string.
	%  <strong>16</strong> <strong>ST_F</strong> 	ST_F (figure, string) is a prop figure string.
	%  <strong>17</strong> <strong>ST_G</strong> 	ST_G (gui, string) is a prop gui string.
	%
	% GTA_ST_TA methods (constructor):
	%  GTA_ST_TA - constructor
	%
	% GTA_ST_TA methods:
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
	% GTA_ST_TA methods (display):
	%  tostring - string with information about the test A PanelPropStringTextArea
	%  disp - displays information about the test A PanelPropStringTextArea
	%  tree - displays the tree of the test A PanelPropStringTextArea
	%
	% GTA_ST_TA methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropStringTextArea are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropStringTextArea
	%
	% GTA_ST_TA methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropStringTextArea as b2 file
	%  load - loads a BRAPH2 test A PanelPropStringTextArea from a b2 file
	%
	% GTA_ST_TA method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropStringTextArea
	%
	% GTA_ST_TA method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropStringTextArea
	%
	% GTA_ST_TA methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropStringTextArea
	%  getSubclasses - returns all subclasses of GTA_ST_TA
	%  getProps - returns the property list of the test A PanelPropStringTextArea
	%  getPropNumber - returns the property number of the test A PanelPropStringTextArea
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
	% GTA_ST_TA methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_ST_TA methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_ST_TA methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_ST_TA methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_ST_TA; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_ST_TA constants</a>.
	%
	%
	% See also PanelPropStringTextArea.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		ST_C = 9; %CET: Computational Efficiency Trick
		ST_C_TAG = 'ST_C';
		ST_C_CATEGORY = 1;
		ST_C_FORMAT = 2;
		
		ST_M = 10; %CET: Computational Efficiency Trick
		ST_M_TAG = 'ST_M';
		ST_M_CATEGORY = 2;
		ST_M_FORMAT = 2;
		
		ST_P = 11; %CET: Computational Efficiency Trick
		ST_P_TAG = 'ST_P';
		ST_P_CATEGORY = 3;
		ST_P_FORMAT = 2;
		
		ST_D = 12; %CET: Computational Efficiency Trick
		ST_D_TAG = 'ST_D';
		ST_D_CATEGORY = 4;
		ST_D_FORMAT = 2;
		
		ST_R = 13; %CET: Computational Efficiency Trick
		ST_R_TAG = 'ST_R';
		ST_R_CATEGORY = 5;
		ST_R_FORMAT = 2;
		
		ST_Q = 14; %CET: Computational Efficiency Trick
		ST_Q_TAG = 'ST_Q';
		ST_Q_CATEGORY = 6;
		ST_Q_FORMAT = 2;
		
		ST_E = 15; %CET: Computational Efficiency Trick
		ST_E_TAG = 'ST_E';
		ST_E_CATEGORY = 7;
		ST_E_FORMAT = 2;
		
		ST_F = 16; %CET: Computational Efficiency Trick
		ST_F_TAG = 'ST_F';
		ST_F_CATEGORY = 8;
		ST_F_FORMAT = 2;
		
		ST_G = 17; %CET: Computational Efficiency Trick
		ST_G_TAG = 'ST_G';
		ST_G_CATEGORY = 9;
		ST_G_FORMAT = 2;
	end
	methods % constructor
		function gt = GTA_ST_TA(varargin)
			%GTA_ST_TA() creates a test A PanelPropStringTextArea.
			%
			% GTA_ST_TA(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_ST_TA(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_ST_TA properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>ST_C</strong> 	ST_C (constant, string) is a prop constant string.
			%  <strong>10</strong> <strong>ST_M</strong> 	ST_M (metadata, string) is a prop metadata string.
			%  <strong>11</strong> <strong>ST_P</strong> 	ST_P (parameter, string) is a prop parameter string.
			%  <strong>12</strong> <strong>ST_D</strong> 	ST_D (data, string) is a prop data string.
			%  <strong>13</strong> <strong>ST_R</strong> 	ST_R (result, string) is a prop result string.
			%  <strong>14</strong> <strong>ST_Q</strong> 	ST_Q (query, string) is a prop query string.
			%  <strong>15</strong> <strong>ST_E</strong> 	ST_E (evanescent, string) is a prop evanescent string.
			%  <strong>16</strong> <strong>ST_F</strong> 	ST_F (figure, string) is a prop figure string.
			%  <strong>17</strong> <strong>ST_G</strong> 	ST_G (gui, string) is a prop gui string.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropStringTextArea.
			%
			% BUILD = GTA_ST_TA.GETBUILD() returns the build of 'GTA_ST_TA'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropStringTextArea GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_ST_TA') returns the build of 'GTA_ST_TA'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_ST_TA')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropStringTextArea.
			%
			% CLASS = GTA_ST_TA.GETCLASS() returns the class 'GTA_ST_TA'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropStringTextArea GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_ST_TA') returns 'GTA_ST_TA'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_ST_TA')
			%  are less computationally efficient.
			
			gt_class = 'GTA_ST_TA';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropStringTextArea.
			%
			% LIST = GTA_ST_TA.GETSUBCLASSES() returns all subclasses of 'GTA_ST_TA'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropStringTextArea GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_ST_TA') returns all subclasses of 'GTA_ST_TA'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_ST_TA' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropStringTextArea.
			%
			% PROPS = GTA_ST_TA.GETPROPS() returns the property list of test A PanelPropStringTextArea
			%  as a row vector.
			%
			% PROPS = GTA_ST_TA.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropStringTextArea GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_ST_TA'[, CATEGORY]) returns the property list of 'GTA_ST_TA'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_ST_TA')
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
			%GETPROPNUMBER returns the property number of test A PanelPropStringTextArea.
			%
			% N = GTA_ST_TA.GETPROPNUMBER() returns the property number of test A PanelPropStringTextArea.
			%
			% N = GTA_ST_TA.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropStringTextArea
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropStringTextArea GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_ST_TA') returns the property number of 'GTA_ST_TA'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_ST_TA')
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
			%EXISTSPROP checks whether property exists in test A PanelPropStringTextArea/error.
			%
			% CHECK = GTA_ST_TA.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_ST_TA, PROP) checks whether PROP exists for GTA_ST_TA.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSPROP(GTA_ST_TA, PROP) throws error if PROP does NOT exist for GTA_ST_TA.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_ST_TA:' 'WrongInput'], ...
					['BRAPH2' ':GTA_ST_TA:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_ST_TA.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropStringTextArea/error.
			%
			% CHECK = GTA_ST_TA.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_ST_TA, TAG) checks whether TAG exists for GTA_ST_TA.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%  Element.EXISTSTAG(GTA_ST_TA, TAG) throws error if TAG does NOT exist for GTA_ST_TA.
			%   Error id: [BRAPH2:GTA_ST_TA:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'ST_C'  'ST_M'  'ST_P'  'ST_D'  'ST_R'  'ST_Q'  'ST_E'  'ST_F'  'ST_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_ST_TA:' 'WrongInput'], ...
					['BRAPH2' ':GTA_ST_TA:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_ST_TA.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_ST_TA, POINTER) returns property number of POINTER of GTA_ST_TA.
			%  PROPERTY = GT.GETPROPPROP(GTA_ST_TA, POINTER) returns property number of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'ST_C'  'ST_M'  'ST_P'  'ST_D'  'ST_R'  'ST_Q'  'ST_E'  'ST_F'  'ST_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_ST_TA, POINTER) returns tag of POINTER of GTA_ST_TA.
			%  TAG = GT.GETPROPTAG(GTA_ST_TA, POINTER) returns tag of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_st_ta_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'ST_C'  'ST_M'  'ST_P'  'ST_D'  'ST_R'  'ST_Q'  'ST_E'  'ST_F'  'ST_G' };
				tag = gta_st_ta_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_ST_TA, POINTER) returns category of POINTER of GTA_ST_TA.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_ST_TA, POINTER) returns category of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_st_ta_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_st_ta_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_ST_TA, POINTER) returns format of POINTER of GTA_ST_TA.
			%  FORMAT = GT.GETPROPFORMAT(GTA_ST_TA, POINTER) returns format of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_st_ta_format_list = { 2  2  2  8  2  2  2  2  2  2  2  2  2  2  2  2  2 };
			prop_format = gta_st_ta_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_ST_TA, POINTER) returns description of POINTER of GTA_ST_TA.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_ST_TA, POINTER) returns description of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_st_ta_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'ST_C (constant, string) is a prop constant string.'  'ST_M (metadata, string) is a prop metadata string.'  'ST_P (parameter, string) is a prop parameter string.'  'ST_D (data, string) is a prop data string.'  'ST_R (result, string) is a prop result string.'  'ST_Q (query, string) is a prop query string.'  'ST_E (evanescent, string) is a prop evanescent string.'  'ST_F (figure, string) is a prop figure string.'  'ST_G (gui, string) is a prop gui string.' };
			prop_description = gta_st_ta_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_ST_TA, POINTER) returns settings of POINTER of GTA_ST_TA.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_ST_TA, POINTER) returns settings of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_ST_TA.ST_C
					prop_settings = Format.getFormatSettings(2);
				case 10 % GTA_ST_TA.ST_M
					prop_settings = Format.getFormatSettings(2);
				case 11 % GTA_ST_TA.ST_P
					prop_settings = Format.getFormatSettings(2);
				case 12 % GTA_ST_TA.ST_D
					prop_settings = Format.getFormatSettings(2);
				case 13 % GTA_ST_TA.ST_R
					prop_settings = Format.getFormatSettings(2);
				case 14 % GTA_ST_TA.ST_Q
					prop_settings = Format.getFormatSettings(2);
				case 15 % GTA_ST_TA.ST_E
					prop_settings = Format.getFormatSettings(2);
				case 16 % GTA_ST_TA.ST_F
					prop_settings = Format.getFormatSettings(2);
				case 17 % GTA_ST_TA.ST_G
					prop_settings = Format.getFormatSettings(2);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_ST_TA, POINTER) returns the default value of POINTER of GTA_ST_TA.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_ST_TA, POINTER) returns the default value of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_ST_TA.ST_C
					prop_default = Format.getFormatDefault(2, GTA_ST_TA.getPropSettings(prop));
				case 10 % GTA_ST_TA.ST_M
					prop_default = 'M\nM\nM\n';
				case 11 % GTA_ST_TA.ST_P
					prop_default = 'P\nP\nP\n';
				case 12 % GTA_ST_TA.ST_D
					prop_default = 'D\nD\nD\n';
				case 13 % GTA_ST_TA.ST_R
					prop_default = 'result\ndefault\n';
				case 14 % GTA_ST_TA.ST_Q
					prop_default = 'query\ndefault\n';
				case 15 % GTA_ST_TA.ST_E
					prop_default = 'evanescent\ndefault\n';
				case 16 % GTA_ST_TA.ST_F
					prop_default = 'F\nF\nF\n';
				case 17 % GTA_ST_TA.ST_G
					prop_default = 'G\nG\nG\n';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_ST_TA.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_ST_TA, POINTER) returns the conditioned default value of POINTER of GTA_ST_TA.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_ST_TA, POINTER) returns the conditioned default value of POINTER of GTA_ST_TA.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			prop_default = GTA_ST_TA.conditioning(prop, GTA_ST_TA.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_ST_TA, PROP, VALUE) checks VALUE format for PROP of GTA_ST_TA.
			%  CHECK = GT.CHECKPROP(GTA_ST_TA, PROP, VALUE) checks VALUE format for PROP of GTA_ST_TA.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_ST_TA:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_ST_TA:WrongInput
			%  Element.CHECKPROP(GTA_ST_TA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_ST_TA.
			%   Error id: BRAPH2:GTA_ST_TA:WrongInput
			%  GT.CHECKPROP(GTA_ST_TA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_ST_TA.
			%   Error id: BRAPH2:GTA_ST_TA:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_ST_TA')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_ST_TA.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_ST_TA.ST_C
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
				case 10 % GTA_ST_TA.ST_M
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case 11 % GTA_ST_TA.ST_P
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case 12 % GTA_ST_TA.ST_D
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case 13 % GTA_ST_TA.ST_R
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
				case 14 % GTA_ST_TA.ST_Q
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
				case 15 % GTA_ST_TA.ST_E
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
				case 16 % GTA_ST_TA.ST_F
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				case 17 % GTA_ST_TA.ST_G
					check = Format.checkFormat(2, value, GTA_ST_TA.getPropSettings(prop));
					if check
						check = true;
					end
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_ST_TA:' 'WrongInput'], ...
					['BRAPH2' ':GTA_ST_TA:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_ST_TA.getPropTag(prop) ' (' GTA_ST_TA.getFormatTag(GTA_ST_TA.getPropFormat(prop)) ').'] ...
					)
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
				case 13 % GTA_ST_TA.ST_R
					rng_settings_ = rng(); rng(gt.getPropSeed(13), 'twister')
					
					value = 'result\ncalculated\n';
					
					rng(rng_settings_)
					
				case 14 % GTA_ST_TA.ST_Q
					value = 'query\ncalculated\n';
					
				case 15 % GTA_ST_TA.ST_E
					value = 'evanescent\ncalculated\n';
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(gt, prop, varargin{:});
					else
						value = calculateValue@Element(gt, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(gt, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 9 % GTA_ST_TA.ST_C
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 9, varargin{:});
					
				case 10 % GTA_ST_TA.ST_M
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 10, varargin{:});
					
				case 11 % GTA_ST_TA.ST_P
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 11, varargin{:});
					
				case 12 % GTA_ST_TA.ST_D
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 12, varargin{:});
					
				case 13 % GTA_ST_TA.ST_R
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 13, varargin{:});
					
				case 14 % GTA_ST_TA.ST_Q
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 14, varargin{:});
					
				case 15 % GTA_ST_TA.ST_E
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 15, varargin{:});
					
				case 16 % GTA_ST_TA.ST_F
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 16, varargin{:});
					
				case 17 % GTA_ST_TA.ST_G
					pr = PanelPropStringTextArea('EL', gt, 'PROP', 17, varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(gt, prop, varargin{:});
					
			end
		end
	end
end
