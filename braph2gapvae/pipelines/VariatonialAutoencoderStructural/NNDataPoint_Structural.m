classdef NNDataPoint_Structural < NNDataPoint
	%NNDataPoint_Structural is a data point for structural regional data.
	% It is a subclass of <a href="matlab:help NNDataPoint">NNDataPoint</a>.
	%
	% A data point for structural regional data (NNDataPoint_Structural) contains both input and target for neural network analysis. The input is a feature vector of subject-level structural regional values. The target is obtained from the variables of interest associated with the data point.
	%
	% The list of NNDataPoint_Structural properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data point for structural regional data.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data point for structural regional data.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data point for structural regional data.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data point for structural regional data.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data point for structural regional data.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the data point for structural regional data.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data point for structural regional data.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input feature vector of structural regional values for this data point.
	%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target value for this data point.
	%  <strong>11</strong> <strong>FEATURES</strong> 	FEATURES (parameter, cell) is the feature vector of subject-level structural regional values representing this data point.
	%  <strong>12</strong> <strong>VOI_DICT</strong> 	VOI_DICT (metadata, idict) contains the variables of interest associated with this data point.
	%  <strong>13</strong> <strong>TARGET_NAME</strong> 	TARGET_NAME (metadata, string) is the name of the variable of interest used as the target.
	%
	% NNDataPoint_Structural methods (constructor):
	%  NNDataPoint_Structural - constructor
	%
	% NNDataPoint_Structural methods:
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
	% NNDataPoint_Structural methods (display):
	%  tostring - string with information about the structural data point
	%  disp - displays information about the structural data point
	%  tree - displays the tree of the structural data point
	%
	% NNDataPoint_Structural methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two structural data point are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the structural data point
	%
	% NNDataPoint_Structural methods (save/load, Static):
	%  save - saves BRAPH2 structural data point as b2 file
	%  load - loads a BRAPH2 structural data point from a b2 file
	%
	% NNDataPoint_Structural method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the structural data point
	%
	% NNDataPoint_Structural method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the structural data point
	%
	% NNDataPoint_Structural methods (inspection, Static):
	%  getClass - returns the class of the structural data point
	%  getSubclasses - returns all subclasses of NNDataPoint_Structural
	%  getProps - returns the property list of the structural data point
	%  getPropNumber - returns the property number of the structural data point
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
	% NNDataPoint_Structural methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDataPoint_Structural methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDataPoint_Structural methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDataPoint_Structural methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDataPoint_Structural; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDataPoint_Structural constants</a>.
	%
	%
	% See also NNDataPoint_Image, NNDataPoint_Tabular, NNDataPoint_Graph_REG, NNDataPoint_Measure_REG, NNDataPoint_Measure_CLA, SubjectST.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		FEATURES = 11; %CET: Computational Efficiency Trick
		FEATURES_TAG = 'FEATURES';
		FEATURES_CATEGORY = 3;
		FEATURES_FORMAT = 16;
		
		VOI_DICT = 12; %CET: Computational Efficiency Trick
		VOI_DICT_TAG = 'VOI_DICT';
		VOI_DICT_CATEGORY = 2;
		VOI_DICT_FORMAT = 10;
		
		TARGET_NAME = 13; %CET: Computational Efficiency Trick
		TARGET_NAME_TAG = 'TARGET_NAME';
		TARGET_NAME_CATEGORY = 2;
		TARGET_NAME_FORMAT = 2;
	end
	methods % constructor
		function dp = NNDataPoint_Structural(varargin)
			%NNDataPoint_Structural() creates a structural data point.
			%
			% NNDataPoint_Structural(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDataPoint_Structural(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDataPoint_Structural properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the data point for structural regional data.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the data point for structural regional data.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the data point for structural regional data.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the data point for structural regional data.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the data point for structural regional data.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the data point for structural regional data.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the data point for structural regional data.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>INPUT</strong> 	INPUT (result, cell) is the input feature vector of structural regional values for this data point.
			%  <strong>10</strong> <strong>TARGET</strong> 	TARGET (result, cell) is the target value for this data point.
			%  <strong>11</strong> <strong>FEATURES</strong> 	FEATURES (parameter, cell) is the feature vector of subject-level structural regional values representing this data point.
			%  <strong>12</strong> <strong>VOI_DICT</strong> 	VOI_DICT (metadata, idict) contains the variables of interest associated with this data point.
			%  <strong>13</strong> <strong>TARGET_NAME</strong> 	TARGET_NAME (metadata, string) is the name of the variable of interest used as the target.
			%
			% See also Category, Format.
			
			dp = dp@NNDataPoint(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the structural data point.
			%
			% BUILD = NNDataPoint_Structural.GETBUILD() returns the build of 'NNDataPoint_Structural'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DP.GETBUILD() returns the build of the structural data point DP.
			%  BUILD = Element.GETBUILD(DP) returns the build of 'DP'.
			%  BUILD = Element.GETBUILD('NNDataPoint_Structural') returns the build of 'NNDataPoint_Structural'.
			%
			% Note that the Element.GETBUILD(DP) and Element.GETBUILD('NNDataPoint_Structural')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dp_class = getClass()
			%GETCLASS returns the class of the structural data point.
			%
			% CLASS = NNDataPoint_Structural.GETCLASS() returns the class 'NNDataPoint_Structural'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DP.GETCLASS() returns the class of the structural data point DP.
			%  CLASS = Element.GETCLASS(DP) returns the class of 'DP'.
			%  CLASS = Element.GETCLASS('NNDataPoint_Structural') returns 'NNDataPoint_Structural'.
			%
			% Note that the Element.GETCLASS(DP) and Element.GETCLASS('NNDataPoint_Structural')
			%  are less computationally efficient.
			
			dp_class = 'NNDataPoint_Structural';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the structural data point.
			%
			% LIST = NNDataPoint_Structural.GETSUBCLASSES() returns all subclasses of 'NNDataPoint_Structural'.
			%
			% Alternative forms to call this method are:
			%  LIST = DP.GETSUBCLASSES() returns all subclasses of the structural data point DP.
			%  LIST = Element.GETSUBCLASSES(DP) returns all subclasses of 'DP'.
			%  LIST = Element.GETSUBCLASSES('NNDataPoint_Structural') returns all subclasses of 'NNDataPoint_Structural'.
			%
			% Note that the Element.GETSUBCLASSES(DP) and Element.GETSUBCLASSES('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDataPoint_Structural' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of structural data point.
			%
			% PROPS = NNDataPoint_Structural.GETPROPS() returns the property list of structural data point
			%  as a row vector.
			%
			% PROPS = NNDataPoint_Structural.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DP.GETPROPS([CATEGORY]) returns the property list of the structural data point DP.
			%  PROPS = Element.GETPROPS(DP[, CATEGORY]) returns the property list of 'DP'.
			%  PROPS = Element.GETPROPS('NNDataPoint_Structural'[, CATEGORY]) returns the property list of 'NNDataPoint_Structural'.
			%
			% Note that the Element.GETPROPS(DP) and Element.GETPROPS('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 12 13];
				case 3 % Category.PARAMETER
					prop_list = [4 11];
				case 4 % Category.DATA
					prop_list = 5;
				case 5 % Category.RESULT
					prop_list = [9 10];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of structural data point.
			%
			% N = NNDataPoint_Structural.GETPROPNUMBER() returns the property number of structural data point.
			%
			% N = NNDataPoint_Structural.GETPROPNUMBER(CATEGORY) returns the property number of structural data point
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DP.GETPROPNUMBER([CATEGORY]) returns the property number of the structural data point DP.
			%  N = Element.GETPROPNUMBER(DP) returns the property number of 'DP'.
			%  N = Element.GETPROPNUMBER('NNDataPoint_Structural') returns the property number of 'NNDataPoint_Structural'.
			%
			% Note that the Element.GETPROPNUMBER(DP) and Element.GETPROPNUMBER('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 4;
				case 3 % Category.PARAMETER
					prop_number = 2;
				case 4 % Category.DATA
					prop_number = 1;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in structural data point/error.
			%
			% CHECK = NNDataPoint_Structural.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSPROP(PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(DP, PROP) checks whether PROP exists for DP.
			%  CHECK = Element.EXISTSPROP(NNDataPoint_Structural, PROP) checks whether PROP exists for NNDataPoint_Structural.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSPROP(PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%  Element.EXISTSPROP(DP, PROP) throws error if PROP does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%  Element.EXISTSPROP(NNDataPoint_Structural, PROP) throws error if PROP does NOT exist for NNDataPoint_Structural.
			%   Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DP) and Element.EXISTSPROP('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_Structural:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDataPoint_Structural.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in structural data point/error.
			%
			% CHECK = NNDataPoint_Structural.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DP.EXISTSTAG(TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(DP, TAG) checks whether TAG exists for DP.
			%  CHECK = Element.EXISTSTAG(NNDataPoint_Structural, TAG) checks whether TAG exists for NNDataPoint_Structural.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DP.EXISTSTAG(TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%  Element.EXISTSTAG(DP, TAG) throws error if TAG does NOT exist for DP.
			%   Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%  Element.EXISTSTAG(NNDataPoint_Structural, TAG) throws error if TAG does NOT exist for NNDataPoint_Structural.
			%   Error id: [BRAPH2:NNDataPoint_Structural:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DP) and Element.EXISTSTAG('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'FEATURES'  'VOI_DICT'  'TARGET_NAME' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_Structural:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDataPoint_Structural.'] ...
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
			%  PROPERTY = DP.GETPROPPROP(POINTER) returns property number of POINTER of DP.
			%  PROPERTY = Element.GETPROPPROP(NNDataPoint_Structural, POINTER) returns property number of POINTER of NNDataPoint_Structural.
			%  PROPERTY = DP.GETPROPPROP(NNDataPoint_Structural, POINTER) returns property number of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPPROP(DP) and Element.GETPROPPROP('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'FEATURES'  'VOI_DICT'  'TARGET_NAME' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = DP.GETPROPTAG(POINTER) returns tag of POINTER of DP.
			%  TAG = Element.GETPROPTAG(NNDataPoint_Structural, POINTER) returns tag of POINTER of NNDataPoint_Structural.
			%  TAG = DP.GETPROPTAG(NNDataPoint_Structural, POINTER) returns tag of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPTAG(DP) and Element.GETPROPTAG('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatapoint_structural_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'INPUT'  'TARGET'  'FEATURES'  'VOI_DICT'  'TARGET_NAME' };
				tag = nndatapoint_structural_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = DP.GETPROPCATEGORY(POINTER) returns category of POINTER of DP.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDataPoint_Structural, POINTER) returns category of POINTER of NNDataPoint_Structural.
			%  CATEGORY = DP.GETPROPCATEGORY(NNDataPoint_Structural, POINTER) returns category of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPCATEGORY(DP) and Element.GETPROPCATEGORY('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_structural_category_list = { 1  1  1  3  4  2  2  6  5  5  3  2  2 };
			prop_category = nndatapoint_structural_category_list{prop};
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
			%  FORMAT = DP.GETPROPFORMAT(POINTER) returns format of POINTER of DP.
			%  FORMAT = Element.GETPROPFORMAT(NNDataPoint_Structural, POINTER) returns format of POINTER of NNDataPoint_Structural.
			%  FORMAT = DP.GETPROPFORMAT(NNDataPoint_Structural, POINTER) returns format of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPFORMAT(DP) and Element.GETPROPFORMAT('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_structural_format_list = { 2  2  2  8  2  2  2  2  16  16  16  10  2 };
			prop_format = nndatapoint_structural_format_list{prop};
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
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDataPoint_Structural, POINTER) returns description of POINTER of NNDataPoint_Structural.
			%  DESCRIPTION = DP.GETPROPDESCRIPTION(NNDataPoint_Structural, POINTER) returns description of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPDESCRIPTION(DP) and Element.GETPROPDESCRIPTION('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDataPoint_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatapoint_structural_description_list = { 'ELCLASS (constant, string) is the class of the data point for structural regional data.'  'NAME (constant, string) is the name of the data point for structural regional data.'  'DESCRIPTION (constant, string) is the description of the data point for structural regional data.'  'TEMPLATE (parameter, item) is the template of the data point for structural regional data.'  'ID (data, string) is a few-letter code for the data point for structural regional data.'  'LABEL (metadata, string) is an extended label of the data point for structural regional data.'  'NOTES (metadata, string) are some specific notes about the data point for structural regional data.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'INPUT (result, cell) is the input feature vector of structural regional values for this data point.'  'TARGET (result, cell) is the target value for this data point.'  'FEATURES (parameter, cell) is the feature vector of subject-level structural regional values representing this data point.'  'VOI_DICT (metadata, idict) contains the variables of interest associated with this data point.'  'TARGET_NAME (metadata, string) is the name of the variable of interest used as the target.' };
			prop_description = nndatapoint_structural_description_list{prop};
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
			%  SETTINGS = DP.GETPROPSETTINGS(POINTER) returns settings of POINTER of DP.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDataPoint_Structural, POINTER) returns settings of POINTER of NNDataPoint_Structural.
			%  SETTINGS = DP.GETPROPSETTINGS(NNDataPoint_Structural, POINTER) returns settings of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPSETTINGS(DP) and Element.GETPROPSETTINGS('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDataPoint_Structural.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPoint_Structural.FEATURES
					prop_settings = Format.getFormatSettings(16);
				case 12 % NNDataPoint_Structural.VOI_DICT
					prop_settings = Format.getFormatSettings(10);
				case 13 % NNDataPoint_Structural.TARGET_NAME
					prop_settings = Format.getFormatSettings(2);
				case 4 % NNDataPoint_Structural.TEMPLATE
					prop_settings = 'NNDataPoint_Structural';
				otherwise
					prop_settings = getPropSettings@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDataPoint_Structural.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_Structural.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDataPoint_Structural, POINTER) returns the default value of POINTER of NNDataPoint_Structural.
			%  DEFAULT = DP.GETPROPDEFAULT(NNDataPoint_Structural, POINTER) returns the default value of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPDEFAULT(DP) and Element.GETPROPDEFAULT('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDataPoint_Structural.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNDataPoint_Structural.FEATURES
					prop_default = Format.getFormatDefault(16, NNDataPoint_Structural.getPropSettings(prop));
				case 12 % NNDataPoint_Structural.VOI_DICT
					prop_default = IndexedDictionary('IT_CLASS', 'VOI');
				case 13 % NNDataPoint_Structural.TARGET_NAME
					prop_default = 'Age';
				case 1 % NNDataPoint_Structural.ELCLASS
					prop_default = 'NNDataPoint_Structural';
				case 2 % NNDataPoint_Structural.NAME
					prop_default = 'Neural Network Data Point for Structural Regional Data';
				case 3 % NNDataPoint_Structural.DESCRIPTION
					prop_default = 'A data point for structural regional data (NNDataPoint_Structural) contains both input and target for neural network analysis. The input is a feature vector of subject-level structural regional values. The target is obtained from the variables of interest associated with the data point.';
				case 4 % NNDataPoint_Structural.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDataPoint_Structural.getPropSettings(prop));
				case 5 % NNDataPoint_Structural.ID
					prop_default = 'NNDataPoint_Structural ID';
				case 6 % NNDataPoint_Structural.LABEL
					prop_default = 'NNDataPoint_Structural label';
				case 7 % NNDataPoint_Structural.NOTES
					prop_default = 'NNDataPoint_Structural notes';
				otherwise
					prop_default = getPropDefault@NNDataPoint(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDataPoint_Structural.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDataPoint_Structural.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDataPoint_Structural, POINTER) returns the conditioned default value of POINTER of NNDataPoint_Structural.
			%  DEFAULT = DP.GETPROPDEFAULTCONDITIONED(NNDataPoint_Structural, POINTER) returns the conditioned default value of POINTER of NNDataPoint_Structural.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DP) and Element.GETPROPDEFAULTCONDITIONED('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDataPoint_Structural.getPropProp(pointer);
			
			prop_default = NNDataPoint_Structural.conditioning(prop, NNDataPoint_Structural.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DP.
			%  CHECK = Element.CHECKPROP(NNDataPoint_Structural, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_Structural.
			%  CHECK = DP.CHECKPROP(NNDataPoint_Structural, PROP, VALUE) checks VALUE format for PROP of NNDataPoint_Structural.
			% 
			% DP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDataPoint_Structural:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DP.
			%   Error id: BRAPH2:NNDataPoint_Structural:WrongInput
			%  Element.CHECKPROP(NNDataPoint_Structural, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_Structural.
			%   Error id: BRAPH2:NNDataPoint_Structural:WrongInput
			%  DP.CHECKPROP(NNDataPoint_Structural, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDataPoint_Structural.
			%   Error id: BRAPH2:NNDataPoint_Structural:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DP) and Element.CHECKPROP('NNDataPoint_Structural')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDataPoint_Structural.getPropProp(pointer);
			
			switch prop
				case 11 % NNDataPoint_Structural.FEATURES
					check = Format.checkFormat(16, value, NNDataPoint_Structural.getPropSettings(prop));
				case 12 % NNDataPoint_Structural.VOI_DICT
					check = Format.checkFormat(10, value, NNDataPoint_Structural.getPropSettings(prop));
				case 13 % NNDataPoint_Structural.TARGET_NAME
					check = Format.checkFormat(2, value, NNDataPoint_Structural.getPropSettings(prop));
				case 4 % NNDataPoint_Structural.TEMPLATE
					check = Format.checkFormat(8, value, NNDataPoint_Structural.getPropSettings(prop));
				otherwise
					if prop <= 10
						check = checkProp@NNDataPoint(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDataPoint_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNDataPoint_Structural:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDataPoint_Structural.getPropTag(prop) ' (' NNDataPoint_Structural.getFormatTag(NNDataPoint_Structural.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dp, prop, varargin)
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
				case 9 % NNDataPoint_Structural.INPUT
					rng_settings_ = rng(); rng(dp.getPropSeed(9), 'twister')
					
					value = dp.get('FEATURES');
					
					rng(rng_settings_)
					
				case 10 % NNDataPoint_Structural.TARGET
					rng_settings_ = rng(); rng(dp.getPropSeed(10), 'twister')
					
					if isempty(dp.get('VOI_DICT').get('IT_LIST'))
					    value = {};
					else
					    value = {dp.get('VOI_DICT').get('IT', dp.get('TARGET_NAME')).get('V')};
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 10
						value = calculateValue@NNDataPoint(dp, prop, varargin{:});
					else
						value = calculateValue@Element(dp, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(dp, prop, varargin)
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
				case 12 % NNDataPoint_Structural.VOI_DICT
					pr = SubjectPP_VOIDict('EL', dp, 'PROP', 12, varargin{:});
					
				otherwise
					pr = getPanelProp@NNDataPoint(dp, prop, varargin{:});
					
			end
		end
	end
end
