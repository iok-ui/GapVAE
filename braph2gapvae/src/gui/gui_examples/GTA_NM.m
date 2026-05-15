classdef GTA_NM < ConcreteElement
	%GTA_NM tests PanelPropMatrix.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% GTA_NM tests PanelPropMatrix.
	%
	% The list of GTA_NM properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NM_C</strong> 	NM_C (constant, matrix) is a prop constant matrix.
	%  <strong>10</strong> <strong>NM_M</strong> 	NM_M (metadata, matrix) is a prop metadata matrix.
	%  <strong>11</strong> <strong>NM_P</strong> 	NM_P (parameter, matrix) is a prop parameter matrix.
	%  <strong>12</strong> <strong>NM_D</strong> 	NM_D (data, matrix) is a prop data matrix.
	%  <strong>13</strong> <strong>NM_R</strong> 	NM_R (result, matrix) is a prop result matrix.
	%  <strong>14</strong> <strong>NM_Q</strong> 	NM_Q (query, matrix) is a prop query matrix.
	%  <strong>15</strong> <strong>NM_E</strong> 	NM_E (evanescent, matrix) is a prop evanescent matrix.
	%  <strong>16</strong> <strong>NM_F</strong> 	NM_F (figure, matrix) is a prop figure matrix.
	%  <strong>17</strong> <strong>NM_G</strong> 	NM_G (gui, matrix) is a prop gui matrix.
	%
	% GTA_NM methods (constructor):
	%  GTA_NM - constructor
	%
	% GTA_NM methods:
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
	% GTA_NM methods (display):
	%  tostring - string with information about the test A PanelPropMatrix
	%  disp - displays information about the test A PanelPropMatrix
	%  tree - displays the tree of the test A PanelPropMatrix
	%
	% GTA_NM methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two test A PanelPropMatrix are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the test A PanelPropMatrix
	%
	% GTA_NM methods (save/load, Static):
	%  save - saves BRAPH2 test A PanelPropMatrix as b2 file
	%  load - loads a BRAPH2 test A PanelPropMatrix from a b2 file
	%
	% GTA_NM method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the test A PanelPropMatrix
	%
	% GTA_NM method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the test A PanelPropMatrix
	%
	% GTA_NM methods (inspection, Static):
	%  getClass - returns the class of the test A PanelPropMatrix
	%  getSubclasses - returns all subclasses of GTA_NM
	%  getProps - returns the property list of the test A PanelPropMatrix
	%  getPropNumber - returns the property number of the test A PanelPropMatrix
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
	% GTA_NM methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GTA_NM methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GTA_NM methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GTA_NM methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GTA_NM; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GTA_NM constants</a>.
	%
	%
	% See also PanelPropMatrix.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		NM_C = 9; %CET: Computational Efficiency Trick
		NM_C_TAG = 'NM_C';
		NM_C_CATEGORY = 1;
		NM_C_FORMAT = 14;
		
		NM_M = 10; %CET: Computational Efficiency Trick
		NM_M_TAG = 'NM_M';
		NM_M_CATEGORY = 2;
		NM_M_FORMAT = 14;
		
		NM_P = 11; %CET: Computational Efficiency Trick
		NM_P_TAG = 'NM_P';
		NM_P_CATEGORY = 3;
		NM_P_FORMAT = 14;
		
		NM_D = 12; %CET: Computational Efficiency Trick
		NM_D_TAG = 'NM_D';
		NM_D_CATEGORY = 4;
		NM_D_FORMAT = 14;
		
		NM_R = 13; %CET: Computational Efficiency Trick
		NM_R_TAG = 'NM_R';
		NM_R_CATEGORY = 5;
		NM_R_FORMAT = 14;
		
		NM_Q = 14; %CET: Computational Efficiency Trick
		NM_Q_TAG = 'NM_Q';
		NM_Q_CATEGORY = 6;
		NM_Q_FORMAT = 14;
		
		NM_E = 15; %CET: Computational Efficiency Trick
		NM_E_TAG = 'NM_E';
		NM_E_CATEGORY = 7;
		NM_E_FORMAT = 14;
		
		NM_F = 16; %CET: Computational Efficiency Trick
		NM_F_TAG = 'NM_F';
		NM_F_CATEGORY = 8;
		NM_F_FORMAT = 14;
		
		NM_G = 17; %CET: Computational Efficiency Trick
		NM_G_TAG = 'NM_G';
		NM_G_CATEGORY = 9;
		NM_G_FORMAT = 14;
	end
	methods % constructor
		function gt = GTA_NM(varargin)
			%GTA_NM() creates a test A PanelPropMatrix.
			%
			% GTA_NM(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GTA_NM(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of GTA_NM properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the concrete element.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the concrete element.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the concrete element.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the concrete element.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the concrete element.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the concrete element.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NM_C</strong> 	NM_C (constant, matrix) is a prop constant matrix.
			%  <strong>10</strong> <strong>NM_M</strong> 	NM_M (metadata, matrix) is a prop metadata matrix.
			%  <strong>11</strong> <strong>NM_P</strong> 	NM_P (parameter, matrix) is a prop parameter matrix.
			%  <strong>12</strong> <strong>NM_D</strong> 	NM_D (data, matrix) is a prop data matrix.
			%  <strong>13</strong> <strong>NM_R</strong> 	NM_R (result, matrix) is a prop result matrix.
			%  <strong>14</strong> <strong>NM_Q</strong> 	NM_Q (query, matrix) is a prop query matrix.
			%  <strong>15</strong> <strong>NM_E</strong> 	NM_E (evanescent, matrix) is a prop evanescent matrix.
			%  <strong>16</strong> <strong>NM_F</strong> 	NM_F (figure, matrix) is a prop figure matrix.
			%  <strong>17</strong> <strong>NM_G</strong> 	NM_G (gui, matrix) is a prop gui matrix.
			%
			% See also Category, Format.
			
			gt = gt@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the test A PanelPropMatrix.
			%
			% BUILD = GTA_NM.GETBUILD() returns the build of 'GTA_NM'.
			%
			% Alternative forms to call this method are:
			%  BUILD = GT.GETBUILD() returns the build of the test A PanelPropMatrix GT.
			%  BUILD = Element.GETBUILD(GT) returns the build of 'GT'.
			%  BUILD = Element.GETBUILD('GTA_NM') returns the build of 'GTA_NM'.
			%
			% Note that the Element.GETBUILD(GT) and Element.GETBUILD('GTA_NM')
			%  are less computationally efficient.
			
			build = 1;
		end
		function gt_class = getClass()
			%GETCLASS returns the class of the test A PanelPropMatrix.
			%
			% CLASS = GTA_NM.GETCLASS() returns the class 'GTA_NM'.
			%
			% Alternative forms to call this method are:
			%  CLASS = GT.GETCLASS() returns the class of the test A PanelPropMatrix GT.
			%  CLASS = Element.GETCLASS(GT) returns the class of 'GT'.
			%  CLASS = Element.GETCLASS('GTA_NM') returns 'GTA_NM'.
			%
			% Note that the Element.GETCLASS(GT) and Element.GETCLASS('GTA_NM')
			%  are less computationally efficient.
			
			gt_class = 'GTA_NM';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the test A PanelPropMatrix.
			%
			% LIST = GTA_NM.GETSUBCLASSES() returns all subclasses of 'GTA_NM'.
			%
			% Alternative forms to call this method are:
			%  LIST = GT.GETSUBCLASSES() returns all subclasses of the test A PanelPropMatrix GT.
			%  LIST = Element.GETSUBCLASSES(GT) returns all subclasses of 'GT'.
			%  LIST = Element.GETSUBCLASSES('GTA_NM') returns all subclasses of 'GTA_NM'.
			%
			% Note that the Element.GETSUBCLASSES(GT) and Element.GETSUBCLASSES('GTA_NM')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'GTA_NM' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test A PanelPropMatrix.
			%
			% PROPS = GTA_NM.GETPROPS() returns the property list of test A PanelPropMatrix
			%  as a row vector.
			%
			% PROPS = GTA_NM.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = GT.GETPROPS([CATEGORY]) returns the property list of the test A PanelPropMatrix GT.
			%  PROPS = Element.GETPROPS(GT[, CATEGORY]) returns the property list of 'GT'.
			%  PROPS = Element.GETPROPS('GTA_NM'[, CATEGORY]) returns the property list of 'GTA_NM'.
			%
			% Note that the Element.GETPROPS(GT) and Element.GETPROPS('GTA_NM')
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
			%GETPROPNUMBER returns the property number of test A PanelPropMatrix.
			%
			% N = GTA_NM.GETPROPNUMBER() returns the property number of test A PanelPropMatrix.
			%
			% N = GTA_NM.GETPROPNUMBER(CATEGORY) returns the property number of test A PanelPropMatrix
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = GT.GETPROPNUMBER([CATEGORY]) returns the property number of the test A PanelPropMatrix GT.
			%  N = Element.GETPROPNUMBER(GT) returns the property number of 'GT'.
			%  N = Element.GETPROPNUMBER('GTA_NM') returns the property number of 'GTA_NM'.
			%
			% Note that the Element.GETPROPNUMBER(GT) and Element.GETPROPNUMBER('GTA_NM')
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
			%EXISTSPROP checks whether property exists in test A PanelPropMatrix/error.
			%
			% CHECK = GTA_NM.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSPROP(PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GT, PROP) checks whether PROP exists for GT.
			%  CHECK = Element.EXISTSPROP(GTA_NM, PROP) checks whether PROP exists for GTA_NM.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSPROP(PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSPROP(GT, PROP) throws error if PROP does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSPROP(GTA_NM, PROP) throws error if PROP does NOT exist for GTA_NM.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Note that the Element.EXISTSPROP(GT) and Element.EXISTSPROP('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NM:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NM:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GTA_NM.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test A PanelPropMatrix/error.
			%
			% CHECK = GTA_NM.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = GT.EXISTSTAG(TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GT, TAG) checks whether TAG exists for GT.
			%  CHECK = Element.EXISTSTAG(GTA_NM, TAG) checks whether TAG exists for GTA_NM.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Alternative forms to call this method are:
			%  GT.EXISTSTAG(TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSTAG(GT, TAG) throws error if TAG does NOT exist for GT.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%  Element.EXISTSTAG(GTA_NM, TAG) throws error if TAG does NOT exist for GTA_NM.
			%   Error id: [BRAPH2:GTA_NM:WrongInput]
			%
			% Note that the Element.EXISTSTAG(GT) and Element.EXISTSTAG('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NM_C'  'NM_M'  'NM_P'  'NM_D'  'NM_R'  'NM_Q'  'NM_E'  'NM_F'  'NM_G' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NM:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NM:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for GTA_NM.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GTA_NM, POINTER) returns property number of POINTER of GTA_NM.
			%  PROPERTY = GT.GETPROPPROP(GTA_NM, POINTER) returns property number of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPPROP(GT) and Element.GETPROPPROP('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NM_C'  'NM_M'  'NM_P'  'NM_D'  'NM_R'  'NM_Q'  'NM_E'  'NM_F'  'NM_G' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(GTA_NM, POINTER) returns tag of POINTER of GTA_NM.
			%  TAG = GT.GETPROPTAG(GTA_NM, POINTER) returns tag of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPTAG(GT) and Element.GETPROPTAG('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				gta_nm_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NM_C'  'NM_M'  'NM_P'  'NM_D'  'NM_R'  'NM_Q'  'NM_E'  'NM_F'  'NM_G' };
				tag = gta_nm_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(GTA_NM, POINTER) returns category of POINTER of GTA_NM.
			%  CATEGORY = GT.GETPROPCATEGORY(GTA_NM, POINTER) returns category of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPCATEGORY(GT) and Element.GETPROPCATEGORY('GTA_NM')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nm_category_list = { 1  1  1  3  4  2  2  6  1  2  3  4  5  6  7  8  9 };
			prop_category = gta_nm_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(GTA_NM, POINTER) returns format of POINTER of GTA_NM.
			%  FORMAT = GT.GETPROPFORMAT(GTA_NM, POINTER) returns format of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPFORMAT(GT) and Element.GETPROPFORMAT('GTA_NM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nm_format_list = { 2  2  2  8  2  2  2  2  14  14  14  14  14  14  14  14  14 };
			prop_format = gta_nm_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GTA_NM, POINTER) returns description of POINTER of GTA_NM.
			%  DESCRIPTION = GT.GETPROPDESCRIPTION(GTA_NM, POINTER) returns description of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPDESCRIPTION(GT) and Element.GETPROPDESCRIPTION('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			gta_nm_description_list = { 'ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).'  'NAME (constant, string) is the name of the concrete element.'  'DESCRIPTION (constant, string) is the description of the concrete element.'  'TEMPLATE (parameter, item) is the template of the concrete element.'  'ID (data, string) is a few-letter code for the concrete element.'  'LABEL (metadata, string) is an extended label of the concrete element.'  'NOTES (metadata, string) are some specific notes about the concrete element.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NM_C (constant, matrix) is a prop constant matrix.'  'NM_M (metadata, matrix) is a prop metadata matrix.'  'NM_P (parameter, matrix) is a prop parameter matrix.'  'NM_D (data, matrix) is a prop data matrix.'  'NM_R (result, matrix) is a prop result matrix.'  'NM_Q (query, matrix) is a prop query matrix.'  'NM_E (evanescent, matrix) is a prop evanescent matrix.'  'NM_F (figure, matrix) is a prop figure matrix.'  'NM_G (gui, matrix) is a prop gui matrix.' };
			prop_description = gta_nm_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(GTA_NM, POINTER) returns settings of POINTER of GTA_NM.
			%  SETTINGS = GT.GETPROPSETTINGS(GTA_NM, POINTER) returns settings of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPSETTINGS(GT) and Element.GETPROPSETTINGS('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_NM.NM_C
					prop_settings = Format.getFormatSettings(14);
				case 10 % GTA_NM.NM_M
					prop_settings = Format.getFormatSettings(14);
				case 11 % GTA_NM.NM_P
					prop_settings = Format.getFormatSettings(14);
				case 12 % GTA_NM.NM_D
					prop_settings = Format.getFormatSettings(14);
				case 13 % GTA_NM.NM_R
					prop_settings = Format.getFormatSettings(14);
				case 14 % GTA_NM.NM_Q
					prop_settings = Format.getFormatSettings(14);
				case 15 % GTA_NM.NM_E
					prop_settings = Format.getFormatSettings(14);
				case 16 % GTA_NM.NM_F
					prop_settings = Format.getFormatSettings(14);
				case 17 % GTA_NM.NM_G
					prop_settings = Format.getFormatSettings(14);
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULT(GTA_NM, POINTER) returns the default value of POINTER of GTA_NM.
			%  DEFAULT = GT.GETPROPDEFAULT(GTA_NM, POINTER) returns the default value of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPDEFAULT(GT) and Element.GETPROPDEFAULT('GTA_NM')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % GTA_NM.NM_C
					prop_default = eye(10);
				case 10 % GTA_NM.NM_M
					prop_default = eye(10);
				case 11 % GTA_NM.NM_P
					prop_default = eye(10);
				case 12 % GTA_NM.NM_D
					prop_default = eye(10);
				case 13 % GTA_NM.NM_R
					prop_default = Format.getFormatDefault(14, GTA_NM.getPropSettings(prop));
				case 14 % GTA_NM.NM_Q
					prop_default = Format.getFormatDefault(14, GTA_NM.getPropSettings(prop));
				case 15 % GTA_NM.NM_E
					prop_default = Format.getFormatDefault(14, GTA_NM.getPropSettings(prop));
				case 16 % GTA_NM.NM_F
					prop_default = eye(10);
				case 17 % GTA_NM.NM_G
					prop_default = eye(10);
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GTA_NM.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of GT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GTA_NM, POINTER) returns the conditioned default value of POINTER of GTA_NM.
			%  DEFAULT = GT.GETPROPDEFAULTCONDITIONED(GTA_NM, POINTER) returns the conditioned default value of POINTER of GTA_NM.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(GT) and Element.GETPROPDEFAULTCONDITIONED('GTA_NM')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GTA_NM.getPropProp(pointer);
			
			prop_default = GTA_NM.conditioning(prop, GTA_NM.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GTA_NM, PROP, VALUE) checks VALUE format for PROP of GTA_NM.
			%  CHECK = GT.CHECKPROP(GTA_NM, PROP, VALUE) checks VALUE format for PROP of GTA_NM.
			% 
			% GT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:GTA_NM:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  GT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of GT.
			%   Error id: BRAPH2:GTA_NM:WrongInput
			%  Element.CHECKPROP(GTA_NM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NM.
			%   Error id: BRAPH2:GTA_NM:WrongInput
			%  GT.CHECKPROP(GTA_NM, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GTA_NM.
			%   Error id: BRAPH2:GTA_NM:WrongInput]
			% 
			% Note that the Element.CHECKPROP(GT) and Element.CHECKPROP('GTA_NM')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GTA_NM.getPropProp(pointer);
			
			switch prop
				case 9 % GTA_NM.NM_C
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 10 % GTA_NM.NM_M
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 11 % GTA_NM.NM_P
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 12 % GTA_NM.NM_D
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 13 % GTA_NM.NM_R
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 14 % GTA_NM.NM_Q
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 15 % GTA_NM.NM_E
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 16 % GTA_NM.NM_F
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				case 17 % GTA_NM.NM_G
					check = Format.checkFormat(14, value, GTA_NM.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':GTA_NM:' 'WrongInput'], ...
					['BRAPH2' ':GTA_NM:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GTA_NM.getPropTag(prop) ' (' GTA_NM.getFormatTag(GTA_NM.getPropFormat(prop)) ').'] ...
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
				case 13 % GTA_NM.NM_R
					rng_settings_ = rng(); rng(gt.getPropSeed(13), 'twister')
					
					value = randi(10, 10);
					
					rng(rng_settings_)
					
				case 14 % GTA_NM.NM_Q
					value = randi(10, 10);
					
				case 15 % GTA_NM.NM_E
					value = randi(10, 10);
					
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
