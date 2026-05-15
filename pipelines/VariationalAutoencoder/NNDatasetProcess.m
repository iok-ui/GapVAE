classdef NNDatasetProcess < ConcreteElement
	%NNDatasetProcess processes raw data into a neural network datasets.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A dataset process (NNDatasetProcess) processes the raw data into a neural network dataset. 
	%  The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels.
	%  Instances of this class should not be created. Use one of its subclasses instead.
	%
	% The list of NNDatasetProcess properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of processing data for a neural networks datasets.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of processing data for a neural networks datasets.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of processing data for a neural networks datasets.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (result, item) processes the datapoints using preprocessing steps (e.g., normalization or standariaztion) and constructs a neural network dataset item for training a neural network model.
	%
	% NNDatasetProcess methods (constructor):
	%  NNDatasetProcess - constructor
	%
	% NNDatasetProcess methods:
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
	% NNDatasetProcess methods (display):
	%  tostring - string with information about the processing for a neural network data
	%  disp - displays information about the processing for a neural network data
	%  tree - displays the tree of the processing for a neural network data
	%
	% NNDatasetProcess methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two processing for a neural network data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the processing for a neural network data
	%
	% NNDatasetProcess methods (save/load, Static):
	%  save - saves BRAPH2 processing for a neural network data as b2 file
	%  load - loads a BRAPH2 processing for a neural network data from a b2 file
	%
	% NNDatasetProcess method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the processing for a neural network data
	%
	% NNDatasetProcess method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the processing for a neural network data
	%
	% NNDatasetProcess methods (inspection, Static):
	%  getClass - returns the class of the processing for a neural network data
	%  getSubclasses - returns all subclasses of NNDatasetProcess
	%  getProps - returns the property list of the processing for a neural network data
	%  getPropNumber - returns the property number of the processing for a neural network data
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
	% NNDatasetProcess methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDatasetProcess methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDatasetProcess methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDatasetProcess methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDatasetProcess; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDatasetProcess constants</a>.
	%
	%
	% See also NNDataset, NNDataPoint.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		D = 9; %CET: Computational Efficiency Trick
		D_TAG = 'D';
		D_CATEGORY = 5;
		D_FORMAT = 8;
	end
	methods % constructor
		function dtran = NNDatasetProcess(varargin)
			%NNDatasetProcess() creates a processing for a neural network data.
			%
			% NNDatasetProcess(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDatasetProcess(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDatasetProcess properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of processing data for a neural networks datasets.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of processing data for a neural networks datasets.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of processing data for a neural networks datasets.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (result, item) processes the datapoints using preprocessing steps (e.g., normalization or standariaztion) and constructs a neural network dataset item for training a neural network model.
			%
			% See also Category, Format.
			
			dtran = dtran@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the processing for a neural network data.
			%
			% BUILD = NNDatasetProcess.GETBUILD() returns the build of 'NNDatasetProcess'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DTRAN.GETBUILD() returns the build of the processing for a neural network data DTRAN.
			%  BUILD = Element.GETBUILD(DTRAN) returns the build of 'DTRAN'.
			%  BUILD = Element.GETBUILD('NNDatasetProcess') returns the build of 'NNDatasetProcess'.
			%
			% Note that the Element.GETBUILD(DTRAN) and Element.GETBUILD('NNDatasetProcess')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dtran_class = getClass()
			%GETCLASS returns the class of the processing for a neural network data.
			%
			% CLASS = NNDatasetProcess.GETCLASS() returns the class 'NNDatasetProcess'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DTRAN.GETCLASS() returns the class of the processing for a neural network data DTRAN.
			%  CLASS = Element.GETCLASS(DTRAN) returns the class of 'DTRAN'.
			%  CLASS = Element.GETCLASS('NNDatasetProcess') returns 'NNDatasetProcess'.
			%
			% Note that the Element.GETCLASS(DTRAN) and Element.GETCLASS('NNDatasetProcess')
			%  are less computationally efficient.
			
			dtran_class = 'NNDatasetProcess';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the processing for a neural network data.
			%
			% LIST = NNDatasetProcess.GETSUBCLASSES() returns all subclasses of 'NNDatasetProcess'.
			%
			% Alternative forms to call this method are:
			%  LIST = DTRAN.GETSUBCLASSES() returns all subclasses of the processing for a neural network data DTRAN.
			%  LIST = Element.GETSUBCLASSES(DTRAN) returns all subclasses of 'DTRAN'.
			%  LIST = Element.GETSUBCLASSES('NNDatasetProcess') returns all subclasses of 'NNDatasetProcess'.
			%
			% Note that the Element.GETSUBCLASSES(DTRAN) and Element.GETSUBCLASSES('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDatasetProcess'  'NNDatasetProcess_MNIST' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of processing for a neural network data.
			%
			% PROPS = NNDatasetProcess.GETPROPS() returns the property list of processing for a neural network data
			%  as a row vector.
			%
			% PROPS = NNDatasetProcess.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DTRAN.GETPROPS([CATEGORY]) returns the property list of the processing for a neural network data DTRAN.
			%  PROPS = Element.GETPROPS(DTRAN[, CATEGORY]) returns the property list of 'DTRAN'.
			%  PROPS = Element.GETPROPS('NNDatasetProcess'[, CATEGORY]) returns the property list of 'NNDatasetProcess'.
			%
			% Note that the Element.GETPROPS(DTRAN) and Element.GETPROPS('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 5 % Category.RESULT
					prop_list = 9;
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of processing for a neural network data.
			%
			% N = NNDatasetProcess.GETPROPNUMBER() returns the property number of processing for a neural network data.
			%
			% N = NNDatasetProcess.GETPROPNUMBER(CATEGORY) returns the property number of processing for a neural network data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DTRAN.GETPROPNUMBER([CATEGORY]) returns the property number of the processing for a neural network data DTRAN.
			%  N = Element.GETPROPNUMBER(DTRAN) returns the property number of 'DTRAN'.
			%  N = Element.GETPROPNUMBER('NNDatasetProcess') returns the property number of 'NNDatasetProcess'.
			%
			% Note that the Element.GETPROPNUMBER(DTRAN) and Element.GETPROPNUMBER('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 9;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in processing for a neural network data/error.
			%
			% CHECK = NNDatasetProcess.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DTRAN.EXISTSPROP(PROP) checks whether PROP exists for DTRAN.
			%  CHECK = Element.EXISTSPROP(DTRAN, PROP) checks whether PROP exists for DTRAN.
			%  CHECK = Element.EXISTSPROP(NNDatasetProcess, PROP) checks whether PROP exists for NNDatasetProcess.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DTRAN.EXISTSPROP(PROP) throws error if PROP does NOT exist for DTRAN.
			%   Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%  Element.EXISTSPROP(DTRAN, PROP) throws error if PROP does NOT exist for DTRAN.
			%   Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%  Element.EXISTSPROP(NNDatasetProcess, PROP) throws error if PROP does NOT exist for NNDatasetProcess.
			%   Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DTRAN) and Element.EXISTSPROP('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 9 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDatasetProcess.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in processing for a neural network data/error.
			%
			% CHECK = NNDatasetProcess.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DTRAN.EXISTSTAG(TAG) checks whether TAG exists for DTRAN.
			%  CHECK = Element.EXISTSTAG(DTRAN, TAG) checks whether TAG exists for DTRAN.
			%  CHECK = Element.EXISTSTAG(NNDatasetProcess, TAG) checks whether TAG exists for NNDatasetProcess.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DTRAN.EXISTSTAG(TAG) throws error if TAG does NOT exist for DTRAN.
			%   Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%  Element.EXISTSTAG(DTRAN, TAG) throws error if TAG does NOT exist for DTRAN.
			%   Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%  Element.EXISTSTAG(NNDatasetProcess, TAG) throws error if TAG does NOT exist for NNDatasetProcess.
			%   Error id: [BRAPH2:NNDatasetProcess:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DTRAN) and Element.EXISTSTAG('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDatasetProcess.'] ...
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
			%  PROPERTY = DTRAN.GETPROPPROP(POINTER) returns property number of POINTER of DTRAN.
			%  PROPERTY = Element.GETPROPPROP(NNDatasetProcess, POINTER) returns property number of POINTER of NNDatasetProcess.
			%  PROPERTY = DTRAN.GETPROPPROP(NNDatasetProcess, POINTER) returns property number of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPPROP(DTRAN) and Element.GETPROPPROP('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = DTRAN.GETPROPTAG(POINTER) returns tag of POINTER of DTRAN.
			%  TAG = Element.GETPROPTAG(NNDatasetProcess, POINTER) returns tag of POINTER of NNDatasetProcess.
			%  TAG = DTRAN.GETPROPTAG(NNDatasetProcess, POINTER) returns tag of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPTAG(DTRAN) and Element.GETPROPTAG('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatasetprocess_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D' };
				tag = nndatasetprocess_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = DTRAN.GETPROPCATEGORY(POINTER) returns category of POINTER of DTRAN.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDatasetProcess, POINTER) returns category of POINTER of NNDatasetProcess.
			%  CATEGORY = DTRAN.GETPROPCATEGORY(NNDatasetProcess, POINTER) returns category of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPCATEGORY(DTRAN) and Element.GETPROPCATEGORY('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetProcess.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_category_list = { 1  1  1  3  4  2  2  6  5 };
			prop_category = nndatasetprocess_category_list{prop};
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
			%  FORMAT = DTRAN.GETPROPFORMAT(POINTER) returns format of POINTER of DTRAN.
			%  FORMAT = Element.GETPROPFORMAT(NNDatasetProcess, POINTER) returns format of POINTER of NNDatasetProcess.
			%  FORMAT = DTRAN.GETPROPFORMAT(NNDatasetProcess, POINTER) returns format of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPFORMAT(DTRAN) and Element.GETPROPFORMAT('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetProcess.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_format_list = { 2  2  2  8  2  2  2  2  8 };
			prop_format = nndatasetprocess_format_list{prop};
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
			%  DESCRIPTION = DTRAN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DTRAN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDatasetProcess, POINTER) returns description of POINTER of NNDatasetProcess.
			%  DESCRIPTION = DTRAN.GETPROPDESCRIPTION(NNDatasetProcess, POINTER) returns description of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPDESCRIPTION(DTRAN) and Element.GETPROPDESCRIPTION('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetProcess.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_description_list = { 'ELCLASS (constant, string) is the class of processing data for a neural networks datasets.'  'NAME (constant, string) is the name of processing data for a neural networks datasets.'  'DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.'  'TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.'  'ID (data, string) is a few-letter code of processing data for a neural networks datasets.'  'LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.'  'NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (result, item) processes the datapoints using preprocessing steps (e.g., normalization or standariaztion) and constructs a neural network dataset item for training a neural network model.' };
			prop_description = nndatasetprocess_description_list{prop};
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
			%  SETTINGS = DTRAN.GETPROPSETTINGS(POINTER) returns settings of POINTER of DTRAN.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDatasetProcess, POINTER) returns settings of POINTER of NNDatasetProcess.
			%  SETTINGS = DTRAN.GETPROPSETTINGS(NNDatasetProcess, POINTER) returns settings of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPSETTINGS(DTRAN) and Element.GETPROPSETTINGS('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetProcess.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNDatasetProcess.D
					prop_settings = 'NNDataset';
				case 4 % NNDatasetProcess.TEMPLATE
					prop_settings = 'NNDatasetProcess';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDatasetProcess.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetProcess.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DTRAN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DTRAN.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDatasetProcess, POINTER) returns the default value of POINTER of NNDatasetProcess.
			%  DEFAULT = DTRAN.GETPROPDEFAULT(NNDatasetProcess, POINTER) returns the default value of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPDEFAULT(DTRAN) and Element.GETPROPDEFAULT('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDatasetProcess.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % NNDatasetProcess.D
					prop_default = Format.getFormatDefault(8, NNDatasetProcess.getPropSettings(prop));
				case 1 % NNDatasetProcess.ELCLASS
					prop_default = 'NNDatasetProcess';
				case 2 % NNDatasetProcess.NAME
					prop_default = 'Processing for a Neural Network Dataset';
				case 3 % NNDatasetProcess.DESCRIPTION
					prop_default = 'The processing for a neural network dataset (NNDatasetProcess) processes the raw data into a neural network dataset. The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels. Instances of this class should not be created. Use one of its subclasses instead.';
				case 4 % NNDatasetProcess.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDatasetProcess.getPropSettings(prop));
				case 5 % NNDatasetProcess.ID
					prop_default = 'NNDatasetProcess ID';
				case 6 % NNDatasetProcess.LABEL
					prop_default = 'NNDatasetProcess label';
				case 7 % NNDatasetProcess.NOTES
					prop_default = 'NNDatasetProcess notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDatasetProcess.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetProcess.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DTRAN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DTRAN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDatasetProcess, POINTER) returns the conditioned default value of POINTER of NNDatasetProcess.
			%  DEFAULT = DTRAN.GETPROPDEFAULTCONDITIONED(NNDatasetProcess, POINTER) returns the conditioned default value of POINTER of NNDatasetProcess.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DTRAN) and Element.GETPROPDEFAULTCONDITIONED('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDatasetProcess.getPropProp(pointer);
			
			prop_default = NNDatasetProcess.conditioning(prop, NNDatasetProcess.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DTRAN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DTRAN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DTRAN.
			%  CHECK = Element.CHECKPROP(NNDatasetProcess, PROP, VALUE) checks VALUE format for PROP of NNDatasetProcess.
			%  CHECK = DTRAN.CHECKPROP(NNDatasetProcess, PROP, VALUE) checks VALUE format for PROP of NNDatasetProcess.
			% 
			% DTRAN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDatasetProcess:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DTRAN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DTRAN.
			%   Error id: BRAPH2:NNDatasetProcess:WrongInput
			%  Element.CHECKPROP(NNDatasetProcess, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetProcess.
			%   Error id: BRAPH2:NNDatasetProcess:WrongInput
			%  DTRAN.CHECKPROP(NNDatasetProcess, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetProcess.
			%   Error id: BRAPH2:NNDatasetProcess:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DTRAN) and Element.CHECKPROP('NNDatasetProcess')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDatasetProcess.getPropProp(pointer);
			
			switch prop
				case 9 % NNDatasetProcess.D
					check = Format.checkFormat(8, value, NNDatasetProcess.getPropSettings(prop));
				case 4 % NNDatasetProcess.TEMPLATE
					check = Format.checkFormat(8, value, NNDatasetProcess.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDatasetProcess.getPropTag(prop) ' (' NNDatasetProcess.getFormatTag(NNDatasetProcess.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dtran, prop, varargin)
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
				case 9 % NNDatasetProcess.D
					rng_settings_ = rng(); rng(dtran.getPropSeed(9), 'twister')
					
					value = NNDataset();
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(dtran, prop, varargin{:});
					else
						value = calculateValue@Element(dtran, prop, varargin{:});
					end
			end
			
		end
	end
end
