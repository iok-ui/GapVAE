classdef GTA_PanelProp < ConcreteElement
	%GTA_PanelProp tests PanelProp.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_PanelProp tests PanelProp.
	%
	% The list of GTA_PanelProp properties is:
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
	% GTA_PanelProp methods (constructor):
	%  GTA_PanelProp - constructor
	%
	% GTA_PanelProp methods:
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
	% GTA_PanelProp methods (display):
	%  tostring - string with information about the test A PanelProp
	%  disp - displays information about the test A PanelProp
	%  tree - displays the tree of the test A PanelProp
	%
	% GTA_PanelProp methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelProp are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelProp
	%
	% GTA_PanelProp methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelProp as b2 file
	%  load - loads a BRAPH2 test A PanelProp from a b2 file
	%
	% GTA_PanelProp method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelProp
	%
	% GTA_PanelProp method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelProp
	%
	% GTA_PanelProp methods (inspection, Static):
	%  getClass - returns the class of the test A PanelProp
	%  getSubclasses - returns all subclasses of GTA_PanelProp
	%  getProps - returns the property list of the test A PanelProp
	%  getPropNumber - returns the property number of the test A PanelProp
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
	% GTA_PanelProp methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_PanelProp methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_PanelProp methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_PanelProp methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_PanelProp; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_PanelProp constants</a>.
	%
	%
	% See also PanelProp.
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
		function gt = GTA_PanelProp(varargin)
			%GTA_PanelProp() creates a test A PanelProp.
			%
			% GTA_PanelProp(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_PanelProp(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_PanelProp properties is:
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
			%GETBUILD returns the build of the test A PanelProp.
			%
			% BUILD = GTA_PanelProp.GETBUILD() returns the build of 'GTA_PanelProp'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelProp GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_PanelProp') returns the build of 'GTA_PanelProp'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_PanelProp')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelProp.
			%
			% CLASS = GTA_PanelProp.GETCLASS() returns the class 'GTA_PanelProp'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelProp GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_PanelProp') returns 'GTA_PanelProp'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_PanelProp')
			%  are less computationally efficient.
			
			gt_class = 'GTA_PanelProp';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelProp.
			%
			% LIST = GTA_PanelProp.GETSUBCLASSES() returns all subclasses of 'GTA_PanelProp'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelProp GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_PanelProp') returns all subclasses of 'GTA_PanelProp'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_PanelProp' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelProp.
			%
			% PROPS = GTA_PanelProp.GETPROPS() returns the property list of test A PanelProp
			%  as a row vector.
			%
			% PROPS = GTA_PanelProp.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelProp GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_PanelProp'[, CATEGORY]) returns the property list of 'GTA_PanelProp'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_PanelProp')
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
			%GETPROPNUMBER returns the property number of test A PanelProp.
			%
			% N = GTA_PanelProp.GETPROPNUMBER() returns the property number of test A PanelProp.
			%
			% N = GTA_PanelProp.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelProp
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelProp GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_PanelProp') returns the property number of 'GTA_PanelProp'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_PanelProp')
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
			%EXISTSPROP checks whether property exists in test A PanelProp/error.
			%
			% CHECK = GTA_PanelProp.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_PanelProp, PROP) checks whether PROP exists for GTA_PanelProp.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSPROP(GTA_PanelProp, PROP) throws error if PROP does NOT exist for GTA_PanelProp.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_PanelProp:' 'WrongInput'], ...
					['BRAPH2' ':GTA_PanelProp:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_PanelProp.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelProp/error.
			%
			% CHECK = GTA_PanelProp.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_PanelProp, TAG) checks whether TAG exists for GTA_PanelProp.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%  Element.EXISTSTAG(GTA_PanelProp, TAG) throws error if TAG does NOT exist for GTA_PanelProp.
			%   Error id: [BRAPH2:GTA_PanelProp:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'ST_C'  'ST_M'  'ST_P'  'ST_D'  'ST_R'  'ST_Q'  'ST_E'  'ST_F'  'ST_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_PanelProp:' 'WrongInput'], ...
					['BRAPH2' ':GTA_PanelProp:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_PanelProp.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_PanelProp, POINTER) returns property number of POINTER of GTA_PanelProp.
			%  PROPERTY = GT.GETPROPPROP(GTA_PanelProp, POINTER) returns property number of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_PanelProp')
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
			%  TAG = Element.GETPROPTAG(GTA_PanelProp, POINTER) returns tag of POINTER of GTA_PanelProp.
			%  TAG = GT.GETPROPTAG(GTA_PanelProp, POINTER) returns tag of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_panelprop_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'ST_C'  'ST_M'  'ST_P'  'ST_D'  'ST_R'  'ST_Q'  'ST_E'  'ST_F'  'ST_G' };
				tag = gta_panelprop_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_PanelProp, POINTER) returns category of POINTER of GTA_PanelProp.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_PanelProp, POINTER) returns category of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_panelprop_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_panelprop_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_PanelProp, POINTER) returns format of POINTER of GTA_PanelProp.
			%  FORMAT = GT.GETPROPFORMAT(GTA_PanelProp, POINTER) returns format of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_panelprop_format_list = { 2  2  2  8  2  2  2  2  2  2  2  2  2  2  2  2  2 };
			prop_format = gta_panelprop_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_PanelProp, POINTER) returns description of POINTER of GTA_PanelProp.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_PanelProp, POINTER) returns description of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_panelprop_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'ST_C (constant, string) is a prop constant string.'  'ST_M (metadata, string) is a prop metadata string.'  'ST_P (parameter, string) is a prop parameter string.'  'ST_D (data, string) is a prop data string.'  'ST_R (result, string) is a prop result string.'  'ST_Q (query, string) is a prop query string.'  'ST_E (evanescent, string) is a prop evanescent string.'  'ST_F (figure, string) is a prop figure string.'  'ST_G (gui, string) is a prop gui string.' };
			prop_description = gta_panelprop_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_PanelProp, POINTER) returns settings of POINTER of GTA_PanelProp.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_PanelProp, POINTER) returns settings of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_PanelProp.ST_C
					prop_settings = Format.getFormatSettings(2);
				case 10 % GTA_PanelProp.ST_M
					prop_settings = Format.getFormatSettings(2);
				case 11 % GTA_PanelProp.ST_P
					prop_settings = Format.getFormatSettings(2);
				case 12 % GTA_PanelProp.ST_D
					prop_settings = Format.getFormatSettings(2);
				case 13 % GTA_PanelProp.ST_R
					prop_settings = Format.getFormatSettings(2);
				case 14 % GTA_PanelProp.ST_Q
					prop_settings = Format.getFormatSettings(2);
				case 15 % GTA_PanelProp.ST_E
					prop_settings = Format.getFormatSettings(2);
				case 16 % GTA_PanelProp.ST_F
					prop_settings = Format.getFormatSettings(2);
				case 17 % GTA_PanelProp.ST_G
					prop_settings = Format.getFormatSettings(2);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_PanelProp, POINTER) returns the default value of POINTER of GTA_PanelProp.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_PanelProp, POINTER) returns the default value of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_PanelProp.ST_C
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 10 % GTA_PanelProp.ST_M
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 11 % GTA_PanelProp.ST_P
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 12 % GTA_PanelProp.ST_D
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 13 % GTA_PanelProp.ST_R
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 14 % GTA_PanelProp.ST_Q
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 15 % GTA_PanelProp.ST_E
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 16 % GTA_PanelProp.ST_F
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				case 17 % GTA_PanelProp.ST_G
					prop_default = Format.getFormatDefault(2, GTA_PanelProp.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_PanelProp.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_PanelProp, POINTER) returns the conditioned default value of POINTER of GTA_PanelProp.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_PanelProp, POINTER) returns the conditioned default value of POINTER of GTA_PanelProp.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			prop_default = GTA_PanelProp.conditioning(prop, GTA_PanelProp.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_PanelProp, PROP, VALUE) checks VALUE format for PROP of GTA_PanelProp.
			%  CHECK = GT.CHECKPROP(GTA_PanelProp, PROP, VALUE) checks VALUE format for PROP of GTA_PanelProp.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_PanelProp:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_PanelProp:WrongInput
			%  Element.CHECKPROP(GTA_PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_PanelProp.
			%   Error id: BRAPH2:GTA_PanelProp:WrongInput
			%  GT.CHECKPROP(GTA_PanelProp, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_PanelProp.
			%   Error id: BRAPH2:GTA_PanelProp:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_PanelProp')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_PanelProp.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_PanelProp.ST_C
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 10 % GTA_PanelProp.ST_M
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 11 % GTA_PanelProp.ST_P
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 12 % GTA_PanelProp.ST_D
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 13 % GTA_PanelProp.ST_R
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 14 % GTA_PanelProp.ST_Q
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 15 % GTA_PanelProp.ST_E
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 16 % GTA_PanelProp.ST_F
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				case 17 % GTA_PanelProp.ST_G
					check = Format.checkFormat(2, value, GTA_PanelProp.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_PanelProp:' 'WrongInput'], ...
					['BRAPH2' ':GTA_PanelProp:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_PanelProp.getPropTag(prop) ' (' GTA_PanelProp.getFormatTag(GTA_PanelProp.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
