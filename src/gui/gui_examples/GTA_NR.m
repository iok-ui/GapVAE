classdef GTA_NR < ConcreteElement
	%GTA_NR tests PanelPropRVector.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_NR tests PanelPropRVector.
	%
	% The list of GTA_NR properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NR_C</strong> 	NR_C (constant, rvector) is a prop constant rvector.
	%  <strong>10</strong> <strong>NR_M</strong> 	NR_M (metadata, rvector) is a prop metadata rvector.
	%  <strong>11</strong> <strong>NR_P</strong> 	NR_P (parameter, rvector) is a prop parameter rvector.
	%  <strong>12</strong> <strong>NR_D</strong> 	NR_D (data, rvector) is a prop data rvector.
	%  <strong>13</strong> <strong>NR_R</strong> 	NR_R (result, rvector) is a prop result rvector.
	%  <strong>14</strong> <strong>NR_Q</strong> 	NR_Q (query, rvector) is a prop query rvector.
	%  <strong>15</strong> <strong>NR_E</strong> 	NR_E (evanescent, rvector) is a prop evanescent rvector.
	%  <strong>16</strong> <strong>NR_F</strong> 	NR_F (figure, rvector) is a prop figure rvector.
	%  <strong>17</strong> <strong>NR_G</strong> 	NR_G (gui, rvector) is a prop gui rvector.
	%
	% GTA_NR methods (constructor):
	%  GTA_NR - constructor
	%
	% GTA_NR methods:
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
	% GTA_NR methods (display):
	%  tostring - string with information about the test A PanelPropRVector
	%  disp - displays information about the test A PanelPropRVector
	%  tree - displays the tree of the test A PanelPropRVector
	%
	% GTA_NR methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropRVector are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropRVector
	%
	% GTA_NR methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropRVector as b2 file
	%  load - loads a BRAPH2 test A PanelPropRVector from a b2 file
	%
	% GTA_NR method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropRVector
	%
	% GTA_NR method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropRVector
	%
	% GTA_NR methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropRVector
	%  getSubclasses - returns all subclasses of GTA_NR
	%  getProps - returns the property list of the test A PanelPropRVector
	%  getPropNumber - returns the property number of the test A PanelPropRVector
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
	% GTA_NR methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_NR methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_NR methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_NR methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_NR; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_NR constants</a>.
	%
	%
	% See also PanelPropRVector.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		NR_C = 9; %CET: Computational Efficiency Trick
		NR_C_TAG = 'NR_C';
		NR_C_CATEGORY = 1;
		NR_C_FORMAT = 12;
		
		NR_M = 10; %CET: Computational Efficiency Trick
		NR_M_TAG = 'NR_M';
		NR_M_CATEGORY = 2;
		NR_M_FORMAT = 12;
		
		NR_P = 11; %CET: Computational Efficiency Trick
		NR_P_TAG = 'NR_P';
		NR_P_CATEGORY = 3;
		NR_P_FORMAT = 12;
		
		NR_D = 12; %CET: Computational Efficiency Trick
		NR_D_TAG = 'NR_D';
		NR_D_CATEGORY = 4;
		NR_D_FORMAT = 12;
		
		NR_R = 13; %CET: Computational Efficiency Trick
		NR_R_TAG = 'NR_R';
		NR_R_CATEGORY = 5;
		NR_R_FORMAT = 12;
		
		NR_Q = 14; %CET: Computational Efficiency Trick
		NR_Q_TAG = 'NR_Q';
		NR_Q_CATEGORY = 6;
		NR_Q_FORMAT = 12;
		
		NR_E = 15; %CET: Computational Efficiency Trick
		NR_E_TAG = 'NR_E';
		NR_E_CATEGORY = 7;
		NR_E_FORMAT = 12;
		
		NR_F = 16; %CET: Computational Efficiency Trick
		NR_F_TAG = 'NR_F';
		NR_F_CATEGORY = 8;
		NR_F_FORMAT = 12;
		
		NR_G = 17; %CET: Computational Efficiency Trick
		NR_G_TAG = 'NR_G';
		NR_G_CATEGORY = 9;
		NR_G_FORMAT = 12;
	end
	methods % constructor
		function gt = GTA_NR(varargin)
			%GTA_NR() creates a test A PanelPropRVector.
			%
			% GTA_NR(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_NR(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_NR properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NR_C</strong> 	NR_C (constant, rvector) is a prop constant rvector.
			%  <strong>10</strong> <strong>NR_M</strong> 	NR_M (metadata, rvector) is a prop metadata rvector.
			%  <strong>11</strong> <strong>NR_P</strong> 	NR_P (parameter, rvector) is a prop parameter rvector.
			%  <strong>12</strong> <strong>NR_D</strong> 	NR_D (data, rvector) is a prop data rvector.
			%  <strong>13</strong> <strong>NR_R</strong> 	NR_R (result, rvector) is a prop result rvector.
			%  <strong>14</strong> <strong>NR_Q</strong> 	NR_Q (query, rvector) is a prop query rvector.
			%  <strong>15</strong> <strong>NR_E</strong> 	NR_E (evanescent, rvector) is a prop evanescent rvector.
			%  <strong>16</strong> <strong>NR_F</strong> 	NR_F (figure, rvector) is a prop figure rvector.
			%  <strong>17</strong> <strong>NR_G</strong> 	NR_G (gui, rvector) is a prop gui rvector.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropRVector.
			%
			% BUILD = GTA_NR.GETBUILD() returns the build of 'GTA_NR'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropRVector GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_NR') returns the build of 'GTA_NR'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_NR')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropRVector.
			%
			% CLASS = GTA_NR.GETCLASS() returns the class 'GTA_NR'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropRVector GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_NR') returns 'GTA_NR'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_NR')
			%  are less computationally efficient.
			
			gt_class = 'GTA_NR';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropRVector.
			%
			% LIST = GTA_NR.GETSUBCLASSES() returns all subclasses of 'GTA_NR'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropRVector GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_NR') returns all subclasses of 'GTA_NR'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_NR')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_NR' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropRVector.
			%
			% PROPS = GTA_NR.GETPROPS() returns the property list of test A PanelPropRVector
			%  as a row vector.
			%
			% PROPS = GTA_NR.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropRVector GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_NR'[, CATEGORY]) returns the property list of 'GTA_NR'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_NR')
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
			%GETPROPNUMBER returns the property number of test A PanelPropRVector.
			%
			% N = GTA_NR.GETPROPNUMBER() returns the property number of test A PanelPropRVector.
			%
			% N = GTA_NR.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropRVector
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropRVector GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_NR') returns the property number of 'GTA_NR'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_NR')
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
			%EXISTSPROP checks whether property exists in test A PanelPropRVector/error.
			%
			% CHECK = GTA_NR.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_NR, PROP) checks whether PROP exists for GTA_NR.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_NR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NR:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NR:WrongInput]
			%  Element.EXISTSPROP(GTA_NR, PROP) throws error if PROP does NOT exist for GTA_NR.
			%   Error id: [BRAPH2:GTA_NR:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_NR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NR:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NR:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_NR.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropRVector/error.
			%
			% CHECK = GTA_NR.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_NR, TAG) checks whether TAG exists for GTA_NR.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_NR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NR:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NR:WrongInput]
			%  Element.EXISTSTAG(GTA_NR, TAG) throws error if TAG does NOT exist for GTA_NR.
			%   Error id: [BRAPH2:GTA_NR:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_NR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NR_C'  'NR_M'  'NR_P'  'NR_D'  'NR_R'  'NR_Q'  'NR_E'  'NR_F'  'NR_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NR:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NR:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_NR.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_NR, POINTER) returns property number of POINTER of GTA_NR.
			%  PROPERTY = GT.GETPROPPROP(GTA_NR, POINTER) returns property number of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_NR')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NR_C'  'NR_M'  'NR_P'  'NR_D'  'NR_R'  'NR_Q'  'NR_E'  'NR_F'  'NR_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_NR, POINTER) returns tag of POINTER of GTA_NR.
			%  TAG = GT.GETPROPTAG(GTA_NR, POINTER) returns tag of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_NR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_nr_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NR_C'  'NR_M'  'NR_P'  'NR_D'  'NR_R'  'NR_Q'  'NR_E'  'NR_F'  'NR_G' };
				tag = gta_nr_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_NR, POINTER) returns category of POINTER of GTA_NR.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_NR, POINTER) returns category of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_NR')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nr_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_nr_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_NR, POINTER) returns format of POINTER of GTA_NR.
			%  FORMAT = GT.GETPROPFORMAT(GTA_NR, POINTER) returns format of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_NR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nr_format_list = { 2  2  2  8  2  2  2  2  12  12  12  12  12  12  12  12  12 };
			prop_format = gta_nr_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_NR, POINTER) returns description of POINTER of GTA_NR.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_NR, POINTER) returns description of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_NR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nr_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NR_C (constant, rvector) is a prop constant rvector.'  'NR_M (metadata, rvector) is a prop metadata rvector.'  'NR_P (parameter, rvector) is a prop parameter rvector.'  'NR_D (data, rvector) is a prop data rvector.'  'NR_R (result, rvector) is a prop result rvector.'  'NR_Q (query, rvector) is a prop query rvector.'  'NR_E (evanescent, rvector) is a prop evanescent rvector.'  'NR_F (figure, rvector) is a prop figure rvector.'  'NR_G (gui, rvector) is a prop gui rvector.' };
			prop_description = gta_nr_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_NR, POINTER) returns settings of POINTER of GTA_NR.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_NR, POINTER) returns settings of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_NR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NR.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_NR.NR_C
					prop_settings = Format.getFormatSettings(12);
				case 10 % GTA_NR.NR_M
					prop_settings = Format.getFormatSettings(12);
				case 11 % GTA_NR.NR_P
					prop_settings = Format.getFormatSettings(12);
				case 12 % GTA_NR.NR_D
					prop_settings = Format.getFormatSettings(12);
				case 13 % GTA_NR.NR_R
					prop_settings = Format.getFormatSettings(12);
				case 14 % GTA_NR.NR_Q
					prop_settings = Format.getFormatSettings(12);
				case 15 % GTA_NR.NR_E
					prop_settings = Format.getFormatSettings(12);
				case 16 % GTA_NR.NR_F
					prop_settings = Format.getFormatSettings(12);
				case 17 % GTA_NR.NR_G
					prop_settings = Format.getFormatSettings(12);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_NR.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NR.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_NR, POINTER) returns the default value of POINTER of GTA_NR.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_NR, POINTER) returns the default value of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_NR')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_NR.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_NR.NR_C
					prop_default = [1 2 3 4 5];
				case 10 % GTA_NR.NR_M
					prop_default = [1 2 3 4 5];
				case 11 % GTA_NR.NR_P
					prop_default = [1 2 3 4 5];
				case 12 % GTA_NR.NR_D
					prop_default = [1 2 3 4 5];
				case 13 % GTA_NR.NR_R
					prop_default = Format.getFormatDefault(12, GTA_NR.getPropSettings(prop));
				case 14 % GTA_NR.NR_Q
					prop_default = Format.getFormatDefault(12, GTA_NR.getPropSettings(prop));
				case 15 % GTA_NR.NR_E
					prop_default = Format.getFormatDefault(12, GTA_NR.getPropSettings(prop));
				case 16 % GTA_NR.NR_F
					prop_default = [1 2 3 4 5];
				case 17 % GTA_NR.NR_G
					prop_default = [1 2 3 4 5];
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_NR.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NR.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_NR, POINTER) returns the conditioned default value of POINTER of GTA_NR.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_NR, POINTER) returns the conditioned default value of POINTER of GTA_NR.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_NR')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_NR.getPropProp(pointer);
			
			prop_default = GTA_NR.conditioning(prop, GTA_NR.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_NR, PROP, VALUE) checks VALUE format for PROP of GTA_NR.
			%  CHECK = GT.CHECKPROP(GTA_NR, PROP, VALUE) checks VALUE format for PROP of GTA_NR.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_NR:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_NR:WrongInput
			%  Element.CHECKPROP(GTA_NR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NR.
			%   Error id: BRAPH2:GTA_NR:WrongInput
			%  GT.CHECKPROP(GTA_NR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NR.
			%   Error id: BRAPH2:GTA_NR:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_NR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_NR.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_NR.NR_C
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 10 % GTA_NR.NR_M
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 11 % GTA_NR.NR_P
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 12 % GTA_NR.NR_D
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 13 % GTA_NR.NR_R
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 14 % GTA_NR.NR_Q
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 15 % GTA_NR.NR_E
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 16 % GTA_NR.NR_F
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				case 17 % GTA_NR.NR_G
					check = Format.checkFormat(12, value, GTA_NR.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NR:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NR:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_NR.getPropTag(prop) ' (' GTA_NR.getFormatTag(GTA_NR.getPropFormat(prop)) ').'] ...
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
				case 13 % GTA_NR.NR_R
					rng_settings_ = rng(); rng(gt.getPropSeed(13), 'twister')
					
					value = rand(1, 10);
					
					rng(rng_settings_)
					
				case 14 % GTA_NR.NR_Q
					value = rand(1, 10);
					
				case 15 % GTA_NR.NR_E
					value = rand(1, 10);
					
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
