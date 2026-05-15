classdef GTA_NN < ConcreteElement
	%GTA_NN tests PanelPropScalar.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_NN tests PanelPropScalar.
	%
	% The list of GTA_NN properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NN_C</strong> 	NN_C (constant, scalar) is a prop constant scalar.
	%  <strong>10</strong> <strong>NN_M</strong> 	NN_M (metadata, scalar) is a prop metadata scalar.
	%  <strong>11</strong> <strong>NN_P</strong> 	NN_P (parameter, scalar) is a prop parameter scalar.
	%  <strong>12</strong> <strong>NN_D</strong> 	NN_D (data, scalar) is a prop data scalar.
	%  <strong>13</strong> <strong>NN_R</strong> 	NN_R (result, scalar) is a prop result scalar.
	%  <strong>14</strong> <strong>NN_Q</strong> 	NN_Q (query, scalar) is a prop query scalar.
	%  <strong>15</strong> <strong>NN_E</strong> 	NN_E (evanescent, scalar) is a prop evanescent scalar.
	%  <strong>16</strong> <strong>NN_F</strong> 	NN_F (figure, scalar) is a prop figure scalar.
	%  <strong>17</strong> <strong>NN_G</strong> 	NN_G (gui, scalar) is a prop gui scalar.
	%
	% GTA_NN methods (constructor):
	%  GTA_NN - constructor
	%
	% GTA_NN methods:
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
	% GTA_NN methods (display):
	%  tostring - string with information about the test A PanelPropScalar
	%  disp - displays information about the test A PanelPropScalar
	%  tree - displays the tree of the test A PanelPropScalar
	%
	% GTA_NN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropScalar are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropScalar
	%
	% GTA_NN methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropScalar as b2 file
	%  load - loads a BRAPH2 test A PanelPropScalar from a b2 file
	%
	% GTA_NN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropScalar
	%
	% GTA_NN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropScalar
	%
	% GTA_NN methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropScalar
	%  getSubclasses - returns all subclasses of GTA_NN
	%  getProps - returns the property list of the test A PanelPropScalar
	%  getPropNumber - returns the property number of the test A PanelPropScalar
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
	% GTA_NN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_NN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_NN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_NN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_NN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_NN constants</a>.
	%
	%
	% See also PanelPropScalar.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		NN_C = 9; %CET: Computational Efficiency Trick
		NN_C_TAG = 'NN_C';
		NN_C_CATEGORY = 1;
		NN_C_FORMAT = 11;
		
		NN_M = 10; %CET: Computational Efficiency Trick
		NN_M_TAG = 'NN_M';
		NN_M_CATEGORY = 2;
		NN_M_FORMAT = 11;
		
		NN_P = 11; %CET: Computational Efficiency Trick
		NN_P_TAG = 'NN_P';
		NN_P_CATEGORY = 3;
		NN_P_FORMAT = 11;
		
		NN_D = 12; %CET: Computational Efficiency Trick
		NN_D_TAG = 'NN_D';
		NN_D_CATEGORY = 4;
		NN_D_FORMAT = 11;
		
		NN_R = 13; %CET: Computational Efficiency Trick
		NN_R_TAG = 'NN_R';
		NN_R_CATEGORY = 5;
		NN_R_FORMAT = 11;
		
		NN_Q = 14; %CET: Computational Efficiency Trick
		NN_Q_TAG = 'NN_Q';
		NN_Q_CATEGORY = 6;
		NN_Q_FORMAT = 11;
		
		NN_E = 15; %CET: Computational Efficiency Trick
		NN_E_TAG = 'NN_E';
		NN_E_CATEGORY = 7;
		NN_E_FORMAT = 11;
		
		NN_F = 16; %CET: Computational Efficiency Trick
		NN_F_TAG = 'NN_F';
		NN_F_CATEGORY = 8;
		NN_F_FORMAT = 11;
		
		NN_G = 17; %CET: Computational Efficiency Trick
		NN_G_TAG = 'NN_G';
		NN_G_CATEGORY = 9;
		NN_G_FORMAT = 11;
	end
	methods % constructor
		function gt = GTA_NN(varargin)
			%GTA_NN() creates a test A PanelPropScalar.
			%
			% GTA_NN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_NN(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_NN properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NN_C</strong> 	NN_C (constant, scalar) is a prop constant scalar.
			%  <strong>10</strong> <strong>NN_M</strong> 	NN_M (metadata, scalar) is a prop metadata scalar.
			%  <strong>11</strong> <strong>NN_P</strong> 	NN_P (parameter, scalar) is a prop parameter scalar.
			%  <strong>12</strong> <strong>NN_D</strong> 	NN_D (data, scalar) is a prop data scalar.
			%  <strong>13</strong> <strong>NN_R</strong> 	NN_R (result, scalar) is a prop result scalar.
			%  <strong>14</strong> <strong>NN_Q</strong> 	NN_Q (query, scalar) is a prop query scalar.
			%  <strong>15</strong> <strong>NN_E</strong> 	NN_E (evanescent, scalar) is a prop evanescent scalar.
			%  <strong>16</strong> <strong>NN_F</strong> 	NN_F (figure, scalar) is a prop figure scalar.
			%  <strong>17</strong> <strong>NN_G</strong> 	NN_G (gui, scalar) is a prop gui scalar.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropScalar.
			%
			% BUILD = GTA_NN.GETBUILD() returns the build of 'GTA_NN'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropScalar GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_NN') returns the build of 'GTA_NN'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_NN')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropScalar.
			%
			% CLASS = GTA_NN.GETCLASS() returns the class 'GTA_NN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropScalar GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_NN') returns 'GTA_NN'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_NN')
			%  are less computationally efficient.
			
			gt_class = 'GTA_NN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropScalar.
			%
			% LIST = GTA_NN.GETSUBCLASSES() returns all subclasses of 'GTA_NN'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropScalar GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_NN') returns all subclasses of 'GTA_NN'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_NN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_NN' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropScalar.
			%
			% PROPS = GTA_NN.GETPROPS() returns the property list of test A PanelPropScalar
			%  as a row vector.
			%
			% PROPS = GTA_NN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropScalar GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_NN'[, CATEGORY]) returns the property list of 'GTA_NN'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_NN')
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
			%GETPROPNUMBER returns the property number of test A PanelPropScalar.
			%
			% N = GTA_NN.GETPROPNUMBER() returns the property number of test A PanelPropScalar.
			%
			% N = GTA_NN.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropScalar
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropScalar GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_NN') returns the property number of 'GTA_NN'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_NN')
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
			%EXISTSPROP checks whether property exists in test A PanelPropScalar/error.
			%
			% CHECK = GTA_NN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_NN, PROP) checks whether PROP exists for GTA_NN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSPROP(GTA_NN, PROP) throws error if PROP does NOT exist for GTA_NN.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NN:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NN:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_NN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropScalar/error.
			%
			% CHECK = GTA_NN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_NN, TAG) checks whether TAG exists for GTA_NN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%  Element.EXISTSTAG(GTA_NN, TAG) throws error if TAG does NOT exist for GTA_NN.
			%   Error id: [BRAPH2:GTA_NN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN_C'  'NN_M'  'NN_P'  'NN_D'  'NN_R'  'NN_Q'  'NN_E'  'NN_F'  'NN_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NN:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NN:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_NN.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_NN, POINTER) returns property number of POINTER of GTA_NN.
			%  PROPERTY = GT.GETPROPPROP(GTA_NN, POINTER) returns property number of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN_C'  'NN_M'  'NN_P'  'NN_D'  'NN_R'  'NN_Q'  'NN_E'  'NN_F'  'NN_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_NN, POINTER) returns tag of POINTER of GTA_NN.
			%  TAG = GT.GETPROPTAG(GTA_NN, POINTER) returns tag of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_nn_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN_C'  'NN_M'  'NN_P'  'NN_D'  'NN_R'  'NN_Q'  'NN_E'  'NN_F'  'NN_G' };
				tag = gta_nn_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_NN, POINTER) returns category of POINTER of GTA_NN.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_NN, POINTER) returns category of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_NN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nn_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_nn_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_NN, POINTER) returns format of POINTER of GTA_NN.
			%  FORMAT = GT.GETPROPFORMAT(GTA_NN, POINTER) returns format of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_NN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nn_format_list = { 2  2  2  8  2  2  2  2  11  11  11  11  11  11  11  11  11 };
			prop_format = gta_nn_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_NN, POINTER) returns description of POINTER of GTA_NN.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_NN, POINTER) returns description of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nn_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NN_C (constant, scalar) is a prop constant scalar.'  'NN_M (metadata, scalar) is a prop metadata scalar.'  'NN_P (parameter, scalar) is a prop parameter scalar.'  'NN_D (data, scalar) is a prop data scalar.'  'NN_R (result, scalar) is a prop result scalar.'  'NN_Q (query, scalar) is a prop query scalar.'  'NN_E (evanescent, scalar) is a prop evanescent scalar.'  'NN_F (figure, scalar) is a prop figure scalar.'  'NN_G (gui, scalar) is a prop gui scalar.' };
			prop_description = gta_nn_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_NN, POINTER) returns settings of POINTER of GTA_NN.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_NN, POINTER) returns settings of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_NN.NN_C
					prop_settings = Format.getFormatSettings(11);
				case 10 % GTA_NN.NN_M
					prop_settings = Format.getFormatSettings(11);
				case 11 % GTA_NN.NN_P
					prop_settings = Format.getFormatSettings(11);
				case 12 % GTA_NN.NN_D
					prop_settings = Format.getFormatSettings(11);
				case 13 % GTA_NN.NN_R
					prop_settings = Format.getFormatSettings(11);
				case 14 % GTA_NN.NN_Q
					prop_settings = Format.getFormatSettings(11);
				case 15 % GTA_NN.NN_E
					prop_settings = Format.getFormatSettings(11);
				case 16 % GTA_NN.NN_F
					prop_settings = Format.getFormatSettings(11);
				case 17 % GTA_NN.NN_G
					prop_settings = Format.getFormatSettings(11);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_NN, POINTER) returns the default value of POINTER of GTA_NN.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_NN, POINTER) returns the default value of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_NN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_NN.NN_C
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 10 % GTA_NN.NN_M
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 11 % GTA_NN.NN_P
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 12 % GTA_NN.NN_D
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 13 % GTA_NN.NN_R
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 14 % GTA_NN.NN_Q
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 15 % GTA_NN.NN_E
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 16 % GTA_NN.NN_F
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				case 17 % GTA_NN.NN_G
					prop_default = Format.getFormatDefault(11, GTA_NN.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_NN, POINTER) returns the conditioned default value of POINTER of GTA_NN.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_NN, POINTER) returns the conditioned default value of POINTER of GTA_NN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_NN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_NN.getPropProp(pointer);
			
			prop_default = GTA_NN.conditioning(prop, GTA_NN.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_NN, PROP, VALUE) checks VALUE format for PROP of GTA_NN.
			%  CHECK = GT.CHECKPROP(GTA_NN, PROP, VALUE) checks VALUE format for PROP of GTA_NN.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_NN:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_NN:WrongInput
			%  Element.CHECKPROP(GTA_NN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NN.
			%   Error id: BRAPH2:GTA_NN:WrongInput
			%  GT.CHECKPROP(GTA_NN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NN.
			%   Error id: BRAPH2:GTA_NN:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_NN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_NN.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_NN.NN_C
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 10 % GTA_NN.NN_M
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 11 % GTA_NN.NN_P
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 12 % GTA_NN.NN_D
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 13 % GTA_NN.NN_R
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 14 % GTA_NN.NN_Q
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 15 % GTA_NN.NN_E
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 16 % GTA_NN.NN_F
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				case 17 % GTA_NN.NN_G
					check = Format.checkFormat(11, value, GTA_NN.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NN:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NN:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_NN.getPropTag(prop) ' (' GTA_NN.getFormatTag(GTA_NN.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
