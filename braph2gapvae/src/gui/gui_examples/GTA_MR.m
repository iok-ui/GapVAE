classdef GTA_MR < ConcreteElement
	%GTA_MR tests PanelPropMarker.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_MR tests PanelPropMarker.
	%
	% The list of GTA_MR properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>MR_C</strong> 	MR_C (constant, marker) is a prop constant marker.
	%  <strong>10</strong> <strong>MR_M</strong> 	MR_M (metadata, marker) is a prop metadata marker.
	%  <strong>11</strong> <strong>MR_P</strong> 	MR_P (parameter, marker) is a prop parameter marker.
	%  <strong>12</strong> <strong>MR_D</strong> 	MR_D (data, marker) is a prop data marker.
	%  <strong>13</strong> <strong>MR_R</strong> 	MR_R (result, marker) is a prop result marker.
	%  <strong>14</strong> <strong>MR_Q</strong> 	MR_Q (query, marker) is a prop query marker.
	%  <strong>15</strong> <strong>MR_E</strong> 	MR_E (evanescent, marker) is a prop evanescent marker.
	%  <strong>16</strong> <strong>MR_F</strong> 	MR_F (figure, marker) is a prop figure marker.
	%  <strong>17</strong> <strong>MR_G</strong> 	MR_G (gui, marker) is a prop gui marker.
	%
	% GTA_MR methods (constructor):
	%  GTA_MR - constructor
	%
	% GTA_MR methods:
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
	% GTA_MR methods (display):
	%  tostring - string with information about the test A PanelPropMarker
	%  disp - displays information about the test A PanelPropMarker
	%  tree - displays the tree of the test A PanelPropMarker
	%
	% GTA_MR methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropMarker are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropMarker
	%
	% GTA_MR methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropMarker as b2 file
	%  load - loads a BRAPH2 test A PanelPropMarker from a b2 file
	%
	% GTA_MR method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropMarker
	%
	% GTA_MR method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropMarker
	%
	% GTA_MR methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropMarker
	%  getSubclasses - returns all subclasses of GTA_MR
	%  getProps - returns the property list of the test A PanelPropMarker
	%  getPropNumber - returns the property number of the test A PanelPropMarker
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
	% GTA_MR methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_MR methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_MR methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_MR methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_MR; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_MR constants</a>.
	%
	%
	% See also PanelPropMarker.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		MR_C = 9; %CET: Computational Efficiency Trick
		MR_C_TAG = 'MR_C';
		MR_C_CATEGORY = 1;
		MR_C_FORMAT = 23;
		
		MR_M = 10; %CET: Computational Efficiency Trick
		MR_M_TAG = 'MR_M';
		MR_M_CATEGORY = 2;
		MR_M_FORMAT = 23;
		
		MR_P = 11; %CET: Computational Efficiency Trick
		MR_P_TAG = 'MR_P';
		MR_P_CATEGORY = 3;
		MR_P_FORMAT = 23;
		
		MR_D = 12; %CET: Computational Efficiency Trick
		MR_D_TAG = 'MR_D';
		MR_D_CATEGORY = 4;
		MR_D_FORMAT = 23;
		
		MR_R = 13; %CET: Computational Efficiency Trick
		MR_R_TAG = 'MR_R';
		MR_R_CATEGORY = 5;
		MR_R_FORMAT = 23;
		
		MR_Q = 14; %CET: Computational Efficiency Trick
		MR_Q_TAG = 'MR_Q';
		MR_Q_CATEGORY = 6;
		MR_Q_FORMAT = 23;
		
		MR_E = 15; %CET: Computational Efficiency Trick
		MR_E_TAG = 'MR_E';
		MR_E_CATEGORY = 7;
		MR_E_FORMAT = 23;
		
		MR_F = 16; %CET: Computational Efficiency Trick
		MR_F_TAG = 'MR_F';
		MR_F_CATEGORY = 8;
		MR_F_FORMAT = 23;
		
		MR_G = 17; %CET: Computational Efficiency Trick
		MR_G_TAG = 'MR_G';
		MR_G_CATEGORY = 9;
		MR_G_FORMAT = 23;
	end
	methods % constructor
		function gt = GTA_MR(varargin)
			%GTA_MR() creates a test A PanelPropMarker.
			%
			% GTA_MR(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_MR(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_MR properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>MR_C</strong> 	MR_C (constant, marker) is a prop constant marker.
			%  <strong>10</strong> <strong>MR_M</strong> 	MR_M (metadata, marker) is a prop metadata marker.
			%  <strong>11</strong> <strong>MR_P</strong> 	MR_P (parameter, marker) is a prop parameter marker.
			%  <strong>12</strong> <strong>MR_D</strong> 	MR_D (data, marker) is a prop data marker.
			%  <strong>13</strong> <strong>MR_R</strong> 	MR_R (result, marker) is a prop result marker.
			%  <strong>14</strong> <strong>MR_Q</strong> 	MR_Q (query, marker) is a prop query marker.
			%  <strong>15</strong> <strong>MR_E</strong> 	MR_E (evanescent, marker) is a prop evanescent marker.
			%  <strong>16</strong> <strong>MR_F</strong> 	MR_F (figure, marker) is a prop figure marker.
			%  <strong>17</strong> <strong>MR_G</strong> 	MR_G (gui, marker) is a prop gui marker.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropMarker.
			%
			% BUILD = GTA_MR.GETBUILD() returns the build of 'GTA_MR'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropMarker GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_MR') returns the build of 'GTA_MR'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_MR')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropMarker.
			%
			% CLASS = GTA_MR.GETCLASS() returns the class 'GTA_MR'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropMarker GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_MR') returns 'GTA_MR'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_MR')
			%  are less computationally efficient.
			
			gt_class = 'GTA_MR';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropMarker.
			%
			% LIST = GTA_MR.GETSUBCLASSES() returns all subclasses of 'GTA_MR'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropMarker GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_MR') returns all subclasses of 'GTA_MR'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_MR')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_MR' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropMarker.
			%
			% PROPS = GTA_MR.GETPROPS() returns the property list of test A PanelPropMarker
			%  as a row vector.
			%
			% PROPS = GTA_MR.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropMarker GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_MR'[, CATEGORY]) returns the property list of 'GTA_MR'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_MR')
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
			%GETPROPNUMBER returns the property number of test A PanelPropMarker.
			%
			% N = GTA_MR.GETPROPNUMBER() returns the property number of test A PanelPropMarker.
			%
			% N = GTA_MR.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropMarker
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropMarker GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_MR') returns the property number of 'GTA_MR'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_MR')
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
			%EXISTSPROP checks whether property exists in test A PanelPropMarker/error.
			%
			% CHECK = GTA_MR.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_MR, PROP) checks whether PROP exists for GTA_MR.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSPROP(GTA_MR, PROP) throws error if PROP does NOT exist for GTA_MR.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_MR:' 'WrongInput'], ...
					['BRAPH2' ':GTA_MR:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_MR.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropMarker/error.
			%
			% CHECK = GTA_MR.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_MR, TAG) checks whether TAG exists for GTA_MR.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%  Element.EXISTSTAG(GTA_MR, TAG) throws error if TAG does NOT exist for GTA_MR.
			%   Error id: [BRAPH2:GTA_MR:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MR_C'  'MR_M'  'MR_P'  'MR_D'  'MR_R'  'MR_Q'  'MR_E'  'MR_F'  'MR_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_MR:' 'WrongInput'], ...
					['BRAPH2' ':GTA_MR:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_MR.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_MR, POINTER) returns property number of POINTER of GTA_MR.
			%  PROPERTY = GT.GETPROPPROP(GTA_MR, POINTER) returns property number of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MR_C'  'MR_M'  'MR_P'  'MR_D'  'MR_R'  'MR_Q'  'MR_E'  'MR_F'  'MR_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_MR, POINTER) returns tag of POINTER of GTA_MR.
			%  TAG = GT.GETPROPTAG(GTA_MR, POINTER) returns tag of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_mr_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'MR_C'  'MR_M'  'MR_P'  'MR_D'  'MR_R'  'MR_Q'  'MR_E'  'MR_F'  'MR_G' };
				tag = gta_mr_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_MR, POINTER) returns category of POINTER of GTA_MR.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_MR, POINTER) returns category of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_MR')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_mr_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_mr_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_MR, POINTER) returns format of POINTER of GTA_MR.
			%  FORMAT = GT.GETPROPFORMAT(GTA_MR, POINTER) returns format of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_MR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_mr_format_list = { 2  2  2  8  2  2  2  2  23  23  23  23  23  23  23  23  23 };
			prop_format = gta_mr_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_MR, POINTER) returns description of POINTER of GTA_MR.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_MR, POINTER) returns description of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_mr_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'MR_C (constant, marker) is a prop constant marker.'  'MR_M (metadata, marker) is a prop metadata marker.'  'MR_P (parameter, marker) is a prop parameter marker.'  'MR_D (data, marker) is a prop data marker.'  'MR_R (result, marker) is a prop result marker.'  'MR_Q (query, marker) is a prop query marker.'  'MR_E (evanescent, marker) is a prop evanescent marker.'  'MR_F (figure, marker) is a prop figure marker.'  'MR_G (gui, marker) is a prop gui marker.' };
			prop_description = gta_mr_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_MR, POINTER) returns settings of POINTER of GTA_MR.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_MR, POINTER) returns settings of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_MR.MR_C
					prop_settings = Format.getFormatSettings(23);
				case 10 % GTA_MR.MR_M
					prop_settings = Format.getFormatSettings(23);
				case 11 % GTA_MR.MR_P
					prop_settings = Format.getFormatSettings(23);
				case 12 % GTA_MR.MR_D
					prop_settings = Format.getFormatSettings(23);
				case 13 % GTA_MR.MR_R
					prop_settings = Format.getFormatSettings(23);
				case 14 % GTA_MR.MR_Q
					prop_settings = Format.getFormatSettings(23);
				case 15 % GTA_MR.MR_E
					prop_settings = Format.getFormatSettings(23);
				case 16 % GTA_MR.MR_F
					prop_settings = Format.getFormatSettings(23);
				case 17 % GTA_MR.MR_G
					prop_settings = Format.getFormatSettings(23);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_MR, POINTER) returns the default value of POINTER of GTA_MR.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_MR, POINTER) returns the default value of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_MR')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_MR.MR_C
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 10 % GTA_MR.MR_M
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 11 % GTA_MR.MR_P
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 12 % GTA_MR.MR_D
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 13 % GTA_MR.MR_R
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 14 % GTA_MR.MR_Q
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 15 % GTA_MR.MR_E
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 16 % GTA_MR.MR_F
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				case 17 % GTA_MR.MR_G
					prop_default = Format.getFormatDefault(23, GTA_MR.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_MR.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_MR, POINTER) returns the conditioned default value of POINTER of GTA_MR.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_MR, POINTER) returns the conditioned default value of POINTER of GTA_MR.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_MR')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_MR.getPropProp(pointer);
			
			prop_default = GTA_MR.conditioning(prop, GTA_MR.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_MR, PROP, VALUE) checks VALUE format for PROP of GTA_MR.
			%  CHECK = GT.CHECKPROP(GTA_MR, PROP, VALUE) checks VALUE format for PROP of GTA_MR.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_MR:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_MR:WrongInput
			%  Element.CHECKPROP(GTA_MR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_MR.
			%   Error id: BRAPH2:GTA_MR:WrongInput
			%  GT.CHECKPROP(GTA_MR, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_MR.
			%   Error id: BRAPH2:GTA_MR:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_MR')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_MR.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_MR.MR_C
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 10 % GTA_MR.MR_M
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 11 % GTA_MR.MR_P
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 12 % GTA_MR.MR_D
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 13 % GTA_MR.MR_R
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 14 % GTA_MR.MR_Q
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 15 % GTA_MR.MR_E
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 16 % GTA_MR.MR_F
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				case 17 % GTA_MR.MR_G
					check = Format.checkFormat(23, value, GTA_MR.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_MR:' 'WrongInput'], ...
					['BRAPH2' ':GTA_MR:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_MR.getPropTag(prop) ' (' GTA_MR.getFormatTag(GTA_MR.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
