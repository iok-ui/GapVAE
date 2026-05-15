classdef NNDatasetProcess_MNIST < NNDatasetProcess
	%NNDatasetProcess_MNIST processes raw MNIST data into a neural network datasets.
	% It is a subclass of <a href="matlab:help NNDatasetProcess">NNDatasetProcess</a>.
	%
	% The MNIST processing for a neural network dataset (NNDatasetProcess_MNIST) processes the raw MNIST data into a neural network dataset. 
	%  The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels.
	%
	% The list of NNDatasetProcess_MNIST properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of processing MNIST data for a neural networks datasets.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of processing MNIST data for a neural networks datasets.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of processing data for a neural networks datasets.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (result, item) is the neural network dataset containing the datapoint processed from the raw data.
	%  <strong>10</strong> <strong>MNIST_IMAGE_FILE</strong> 	MNIST_IMAGE_FILE (data, string) contains the file directory of the MNIST data.
	%  <strong>11</strong> <strong>MNIST_LABEL_FILE</strong> 	MNIST_LABEL_FILE (data, string) contains the file directory of the MNIST labels.
	%  <strong>12</strong> <strong>EXTRACT_IMAGES</strong> 	EXTRACT_IMAGES (query, cell) extracts the images from the specified IDX files.
	%  <strong>13</strong> <strong>EXTRACT_LABELS</strong> 	EXTRACT_LABELS (query, stringlist) extracts the labels from the specified IDX files.
	%
	% NNDatasetProcess_MNIST methods (constructor):
	%  NNDatasetProcess_MNIST - constructor
	%
	% NNDatasetProcess_MNIST methods:
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
	% NNDatasetProcess_MNIST methods (display):
	%  tostring - string with information about the processing for a neural network data
	%  disp - displays information about the processing for a neural network data
	%  tree - displays the tree of the processing for a neural network data
	%
	% NNDatasetProcess_MNIST methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two processing for a neural network data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the processing for a neural network data
	%
	% NNDatasetProcess_MNIST methods (save/load, Static):
	%  save - saves BRAPH2 processing for a neural network data as b2 file
	%  load - loads a BRAPH2 processing for a neural network data from a b2 file
	%
	% NNDatasetProcess_MNIST method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the processing for a neural network data
	%
	% NNDatasetProcess_MNIST method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the processing for a neural network data
	%
	% NNDatasetProcess_MNIST methods (inspection, Static):
	%  getClass - returns the class of the processing for a neural network data
	%  getSubclasses - returns all subclasses of NNDatasetProcess_MNIST
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
	% NNDatasetProcess_MNIST methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDatasetProcess_MNIST methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDatasetProcess_MNIST methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDatasetProcess_MNIST methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDatasetProcess_MNIST; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDatasetProcess_MNIST constants</a>.
	%
	%
	% See also NNDatasetProcess, NNDataPoint.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		MNIST_IMAGE_FILE = 10; %CET: Computational Efficiency Trick
		MNIST_IMAGE_FILE_TAG = 'MNIST_IMAGE_FILE';
		MNIST_IMAGE_FILE_CATEGORY = 4;
		MNIST_IMAGE_FILE_FORMAT = 2;
		
		MNIST_LABEL_FILE = 11; %CET: Computational Efficiency Trick
		MNIST_LABEL_FILE_TAG = 'MNIST_LABEL_FILE';
		MNIST_LABEL_FILE_CATEGORY = 4;
		MNIST_LABEL_FILE_FORMAT = 2;
		
		EXTRACT_IMAGES = 12; %CET: Computational Efficiency Trick
		EXTRACT_IMAGES_TAG = 'EXTRACT_IMAGES';
		EXTRACT_IMAGES_CATEGORY = 6;
		EXTRACT_IMAGES_FORMAT = 16;
		
		EXTRACT_LABELS = 13; %CET: Computational Efficiency Trick
		EXTRACT_LABELS_TAG = 'EXTRACT_LABELS';
		EXTRACT_LABELS_CATEGORY = 6;
		EXTRACT_LABELS_FORMAT = 3;
	end
	methods % constructor
		function dproc = NNDatasetProcess_MNIST(varargin)
			%NNDatasetProcess_MNIST() creates a processing for a neural network data.
			%
			% NNDatasetProcess_MNIST(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDatasetProcess_MNIST(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDatasetProcess_MNIST properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of processing MNIST data for a neural networks datasets.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of processing MNIST data for a neural networks datasets.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of processing data for a neural networks datasets.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (result, item) is the neural network dataset containing the datapoint processed from the raw data.
			%  <strong>10</strong> <strong>MNIST_IMAGE_FILE</strong> 	MNIST_IMAGE_FILE (data, string) contains the file directory of the MNIST data.
			%  <strong>11</strong> <strong>MNIST_LABEL_FILE</strong> 	MNIST_LABEL_FILE (data, string) contains the file directory of the MNIST labels.
			%  <strong>12</strong> <strong>EXTRACT_IMAGES</strong> 	EXTRACT_IMAGES (query, cell) extracts the images from the specified IDX files.
			%  <strong>13</strong> <strong>EXTRACT_LABELS</strong> 	EXTRACT_LABELS (query, stringlist) extracts the labels from the specified IDX files.
			%
			% See also Category, Format.
			
			dproc = dproc@NNDatasetProcess(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the processing for a neural network data.
			%
			% BUILD = NNDatasetProcess_MNIST.GETBUILD() returns the build of 'NNDatasetProcess_MNIST'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DPROC.GETBUILD() returns the build of the processing for a neural network data DPROC.
			%  BUILD = Element.GETBUILD(DPROC) returns the build of 'DPROC'.
			%  BUILD = Element.GETBUILD('NNDatasetProcess_MNIST') returns the build of 'NNDatasetProcess_MNIST'.
			%
			% Note that the Element.GETBUILD(DPROC) and Element.GETBUILD('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dproc_class = getClass()
			%GETCLASS returns the class of the processing for a neural network data.
			%
			% CLASS = NNDatasetProcess_MNIST.GETCLASS() returns the class 'NNDatasetProcess_MNIST'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DPROC.GETCLASS() returns the class of the processing for a neural network data DPROC.
			%  CLASS = Element.GETCLASS(DPROC) returns the class of 'DPROC'.
			%  CLASS = Element.GETCLASS('NNDatasetProcess_MNIST') returns 'NNDatasetProcess_MNIST'.
			%
			% Note that the Element.GETCLASS(DPROC) and Element.GETCLASS('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			
			dproc_class = 'NNDatasetProcess_MNIST';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the processing for a neural network data.
			%
			% LIST = NNDatasetProcess_MNIST.GETSUBCLASSES() returns all subclasses of 'NNDatasetProcess_MNIST'.
			%
			% Alternative forms to call this method are:
			%  LIST = DPROC.GETSUBCLASSES() returns all subclasses of the processing for a neural network data DPROC.
			%  LIST = Element.GETSUBCLASSES(DPROC) returns all subclasses of 'DPROC'.
			%  LIST = Element.GETSUBCLASSES('NNDatasetProcess_MNIST') returns all subclasses of 'NNDatasetProcess_MNIST'.
			%
			% Note that the Element.GETSUBCLASSES(DPROC) and Element.GETSUBCLASSES('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDatasetProcess_MNIST' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of processing for a neural network data.
			%
			% PROPS = NNDatasetProcess_MNIST.GETPROPS() returns the property list of processing for a neural network data
			%  as a row vector.
			%
			% PROPS = NNDatasetProcess_MNIST.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DPROC.GETPROPS([CATEGORY]) returns the property list of the processing for a neural network data DPROC.
			%  PROPS = Element.GETPROPS(DPROC[, CATEGORY]) returns the property list of 'DPROC'.
			%  PROPS = Element.GETPROPS('NNDatasetProcess_MNIST'[, CATEGORY]) returns the property list of 'NNDatasetProcess_MNIST'.
			%
			% Note that the Element.GETPROPS(DPROC) and Element.GETPROPS('NNDatasetProcess_MNIST')
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
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 10 11];
				case 5 % Category.RESULT
					prop_list = 9;
				case 6 % Category.QUERY
					prop_list = [8 12 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of processing for a neural network data.
			%
			% N = NNDatasetProcess_MNIST.GETPROPNUMBER() returns the property number of processing for a neural network data.
			%
			% N = NNDatasetProcess_MNIST.GETPROPNUMBER(CATEGORY) returns the property number of processing for a neural network data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DPROC.GETPROPNUMBER([CATEGORY]) returns the property number of the processing for a neural network data DPROC.
			%  N = Element.GETPROPNUMBER(DPROC) returns the property number of 'DPROC'.
			%  N = Element.GETPROPNUMBER('NNDatasetProcess_MNIST') returns the property number of 'NNDatasetProcess_MNIST'.
			%
			% Note that the Element.GETPROPNUMBER(DPROC) and Element.GETPROPNUMBER('NNDatasetProcess_MNIST')
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
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 3;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in processing for a neural network data/error.
			%
			% CHECK = NNDatasetProcess_MNIST.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DPROC.EXISTSPROP(PROP) checks whether PROP exists for DPROC.
			%  CHECK = Element.EXISTSPROP(DPROC, PROP) checks whether PROP exists for DPROC.
			%  CHECK = Element.EXISTSPROP(NNDatasetProcess_MNIST, PROP) checks whether PROP exists for NNDatasetProcess_MNIST.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DPROC.EXISTSPROP(PROP) throws error if PROP does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%  Element.EXISTSPROP(DPROC, PROP) throws error if PROP does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%  Element.EXISTSPROP(NNDatasetProcess_MNIST, PROP) throws error if PROP does NOT exist for NNDatasetProcess_MNIST.
			%   Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DPROC) and Element.EXISTSPROP('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess_MNIST:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess_MNIST:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDatasetProcess_MNIST.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in processing for a neural network data/error.
			%
			% CHECK = NNDatasetProcess_MNIST.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DPROC.EXISTSTAG(TAG) checks whether TAG exists for DPROC.
			%  CHECK = Element.EXISTSTAG(DPROC, TAG) checks whether TAG exists for DPROC.
			%  CHECK = Element.EXISTSTAG(NNDatasetProcess_MNIST, TAG) checks whether TAG exists for NNDatasetProcess_MNIST.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DPROC.EXISTSTAG(TAG) throws error if TAG does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%  Element.EXISTSTAG(DPROC, TAG) throws error if TAG does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%  Element.EXISTSTAG(NNDatasetProcess_MNIST, TAG) throws error if TAG does NOT exist for NNDatasetProcess_MNIST.
			%   Error id: [BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DPROC) and Element.EXISTSTAG('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'MNIST_IMAGE_FILE'  'MNIST_LABEL_FILE'  'EXTRACT_IMAGES'  'EXTRACT_LABELS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess_MNIST:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess_MNIST:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDatasetProcess_MNIST.'] ...
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
			%  PROPERTY = DPROC.GETPROPPROP(POINTER) returns property number of POINTER of DPROC.
			%  PROPERTY = Element.GETPROPPROP(NNDatasetProcess_MNIST, POINTER) returns property number of POINTER of NNDatasetProcess_MNIST.
			%  PROPERTY = DPROC.GETPROPPROP(NNDatasetProcess_MNIST, POINTER) returns property number of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPPROP(DPROC) and Element.GETPROPPROP('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'MNIST_IMAGE_FILE'  'MNIST_LABEL_FILE'  'EXTRACT_IMAGES'  'EXTRACT_LABELS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = DPROC.GETPROPTAG(POINTER) returns tag of POINTER of DPROC.
			%  TAG = Element.GETPROPTAG(NNDatasetProcess_MNIST, POINTER) returns tag of POINTER of NNDatasetProcess_MNIST.
			%  TAG = DPROC.GETPROPTAG(NNDatasetProcess_MNIST, POINTER) returns tag of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPTAG(DPROC) and Element.GETPROPTAG('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatasetprocess_mnist_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'MNIST_IMAGE_FILE'  'MNIST_LABEL_FILE'  'EXTRACT_IMAGES'  'EXTRACT_LABELS' };
				tag = nndatasetprocess_mnist_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = DPROC.GETPROPCATEGORY(POINTER) returns category of POINTER of DPROC.
			%  CATEGORY = Element.GETPROPCATEGORY(NNDatasetProcess_MNIST, POINTER) returns category of POINTER of NNDatasetProcess_MNIST.
			%  CATEGORY = DPROC.GETPROPCATEGORY(NNDatasetProcess_MNIST, POINTER) returns category of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPCATEGORY(DPROC) and Element.GETPROPCATEGORY('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_MNIST.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_mnist_category_list = { 1  1  1  3  4  2  2  6  5  4  4  6  6 };
			prop_category = nndatasetprocess_mnist_category_list{prop};
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
			%  FORMAT = DPROC.GETPROPFORMAT(POINTER) returns format of POINTER of DPROC.
			%  FORMAT = Element.GETPROPFORMAT(NNDatasetProcess_MNIST, POINTER) returns format of POINTER of NNDatasetProcess_MNIST.
			%  FORMAT = DPROC.GETPROPFORMAT(NNDatasetProcess_MNIST, POINTER) returns format of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPFORMAT(DPROC) and Element.GETPROPFORMAT('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_MNIST.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_mnist_format_list = { 2  2  2  8  2  2  2  2  8  2  2  16  3 };
			prop_format = nndatasetprocess_mnist_format_list{prop};
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
			%  DESCRIPTION = DPROC.GETPROPDESCRIPTION(POINTER) returns description of POINTER of DPROC.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDatasetProcess_MNIST, POINTER) returns description of POINTER of NNDatasetProcess_MNIST.
			%  DESCRIPTION = DPROC.GETPROPDESCRIPTION(NNDatasetProcess_MNIST, POINTER) returns description of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPDESCRIPTION(DPROC) and Element.GETPROPDESCRIPTION('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_MNIST.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_mnist_description_list = { 'ELCLASS (constant, string) is the class of processing MNIST data for a neural networks datasets.'  'NAME (constant, string) is the name of processing MNIST data for a neural networks datasets.'  'DESCRIPTION (constant, string) is the description of processing data for a neural networks datasets.'  'TEMPLATE (parameter, item) is the template of processing data for a neural networks datasets.'  'ID (data, string) is a few-letter code of processing data for a neural networks datasets.'  'LABEL (metadata, string) is an extended label of processing data for a neural networks datasets.'  'NOTES (metadata, string) are some specific notes of processing data for a neural networks datasets.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (result, item) is the neural network dataset containing the datapoint processed from the raw data.'  'MNIST_IMAGE_FILE (data, string) contains the file directory of the MNIST data.'  'MNIST_LABEL_FILE (data, string) contains the file directory of the MNIST labels.'  'EXTRACT_IMAGES (query, cell) extracts the images from the specified IDX files.'  'EXTRACT_LABELS (query, stringlist) extracts the labels from the specified IDX files.' };
			prop_description = nndatasetprocess_mnist_description_list{prop};
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
			%  SETTINGS = DPROC.GETPROPSETTINGS(POINTER) returns settings of POINTER of DPROC.
			%  SETTINGS = Element.GETPROPSETTINGS(NNDatasetProcess_MNIST, POINTER) returns settings of POINTER of NNDatasetProcess_MNIST.
			%  SETTINGS = DPROC.GETPROPSETTINGS(NNDatasetProcess_MNIST, POINTER) returns settings of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPSETTINGS(DPROC) and Element.GETPROPSETTINGS('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_MNIST.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % NNDatasetProcess_MNIST.MNIST_IMAGE_FILE
					prop_settings = Format.getFormatSettings(2);
				case 11 % NNDatasetProcess_MNIST.MNIST_LABEL_FILE
					prop_settings = Format.getFormatSettings(2);
				case 12 % NNDatasetProcess_MNIST.EXTRACT_IMAGES
					prop_settings = Format.getFormatSettings(16);
				case 13 % NNDatasetProcess_MNIST.EXTRACT_LABELS
					prop_settings = Format.getFormatSettings(3);
				case 4 % NNDatasetProcess_MNIST.TEMPLATE
					prop_settings = 'NNDatasetProcess_MNIST';
				case 9 % NNDatasetProcess_MNIST.D
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@NNDatasetProcess(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDatasetProcess_MNIST.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetProcess_MNIST.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DPROC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DPROC.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDatasetProcess_MNIST, POINTER) returns the default value of POINTER of NNDatasetProcess_MNIST.
			%  DEFAULT = DPROC.GETPROPDEFAULT(NNDatasetProcess_MNIST, POINTER) returns the default value of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPDEFAULT(DPROC) and Element.GETPROPDEFAULT('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDatasetProcess_MNIST.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % NNDatasetProcess_MNIST.MNIST_IMAGE_FILE
					prop_default = Format.getFormatDefault(2, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 11 % NNDatasetProcess_MNIST.MNIST_LABEL_FILE
					prop_default = Format.getFormatDefault(2, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 12 % NNDatasetProcess_MNIST.EXTRACT_IMAGES
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 13 % NNDatasetProcess_MNIST.EXTRACT_LABELS
					prop_default = Format.getFormatDefault(3, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 1 % NNDatasetProcess_MNIST.ELCLASS
					prop_default = 'NNDatasetProcess_MNIST';
				case 2 % NNDatasetProcess_MNIST.NAME
					prop_default = 'Processing MNIST for a Neural Network Dataset';
				case 3 % NNDatasetProcess_MNIST.DESCRIPTION
					prop_default = 'The MNIST processing for a neural network dataset (NNDatasetProcess_MNIST) processes the raw MNIST data into a neural network dataset. The resulting neural network dataset contains all the datapoints from the raw data, along with its corresponding labels.';
				case 4 % NNDatasetProcess_MNIST.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 5 % NNDatasetProcess_MNIST.ID
					prop_default = 'NNDatasetProcess_MNIST ID';
				case 6 % NNDatasetProcess_MNIST.LABEL
					prop_default = 'NNDatasetProcess_MNIST label';
				case 7 % NNDatasetProcess_MNIST.NOTES
					prop_default = 'NNDatasetProcess_MNIST notes';
				case 9 % NNDatasetProcess_MNIST.D
					prop_default = Format.getFormatDefault(8, NNDatasetProcess_MNIST.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNDatasetProcess(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDatasetProcess_MNIST.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetProcess_MNIST.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DPROC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DPROC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDatasetProcess_MNIST, POINTER) returns the conditioned default value of POINTER of NNDatasetProcess_MNIST.
			%  DEFAULT = DPROC.GETPROPDEFAULTCONDITIONED(NNDatasetProcess_MNIST, POINTER) returns the conditioned default value of POINTER of NNDatasetProcess_MNIST.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DPROC) and Element.GETPROPDEFAULTCONDITIONED('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDatasetProcess_MNIST.getPropProp(pointer);
			
			prop_default = NNDatasetProcess_MNIST.conditioning(prop, NNDatasetProcess_MNIST.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = DPROC.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = DPROC.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of DPROC.
			%  CHECK = Element.CHECKPROP(NNDatasetProcess_MNIST, PROP, VALUE) checks VALUE format for PROP of NNDatasetProcess_MNIST.
			%  CHECK = DPROC.CHECKPROP(NNDatasetProcess_MNIST, PROP, VALUE) checks VALUE format for PROP of NNDatasetProcess_MNIST.
			% 
			% DPROC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDatasetProcess_MNIST:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DPROC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DPROC.
			%   Error id: BRAPH2:NNDatasetProcess_MNIST:WrongInput
			%  Element.CHECKPROP(NNDatasetProcess_MNIST, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetProcess_MNIST.
			%   Error id: BRAPH2:NNDatasetProcess_MNIST:WrongInput
			%  DPROC.CHECKPROP(NNDatasetProcess_MNIST, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetProcess_MNIST.
			%   Error id: BRAPH2:NNDatasetProcess_MNIST:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DPROC) and Element.CHECKPROP('NNDatasetProcess_MNIST')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDatasetProcess_MNIST.getPropProp(pointer);
			
			switch prop
				case 10 % NNDatasetProcess_MNIST.MNIST_IMAGE_FILE
					check = Format.checkFormat(2, value, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 11 % NNDatasetProcess_MNIST.MNIST_LABEL_FILE
					check = Format.checkFormat(2, value, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 12 % NNDatasetProcess_MNIST.EXTRACT_IMAGES
					check = Format.checkFormat(16, value, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 13 % NNDatasetProcess_MNIST.EXTRACT_LABELS
					check = Format.checkFormat(3, value, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 4 % NNDatasetProcess_MNIST.TEMPLATE
					check = Format.checkFormat(8, value, NNDatasetProcess_MNIST.getPropSettings(prop));
				case 9 % NNDatasetProcess_MNIST.D
					check = Format.checkFormat(8, value, NNDatasetProcess_MNIST.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@NNDatasetProcess(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess_MNIST:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess_MNIST:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDatasetProcess_MNIST.getPropTag(prop) ' (' NNDatasetProcess_MNIST.getFormatTag(NNDatasetProcess_MNIST.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(dproc, prop, varargin)
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
				case 12 % NNDatasetProcess_MNIST.EXTRACT_IMAGES
					dataFolder = fullfile(tempdir, 'mnist');
					filename = dproc.get('MNIST_IMAGE_FILE');
					if isempty(filename)
					    %fprintf([newline "There is no MNIST image file."])
					    value = {};
					    return
					end
					gunzip(filename, dataFolder)
					
					[~, name, ~] = fileparts(filename);
					
					[fileID, errmsg] = fopen(fullfile(dataFolder, name), 'r', 'b');
					if fileID < 0
					    error(errmsg);
					end
					
					magicNum = fread(fileID, 1, 'int32', 0, 'b');
					if magicNum == 2051
					    fprintf([newline 'Read MNIST image data...'])
					end
					
					numImages = fread(fileID, 1, 'int32', 0, 'b');
					fprintf([newline 'Number of images in the dataset: %6d ...'], numImages);
					numRows = fread(fileID, 1, 'int32', 0, 'b');
					numCols = fread(fileID, 1, 'int32', 0, 'b');
					
					X = fread(fileID, inf, 'unsigned char');
					
					X = reshape(X, numCols, numRows, numImages);
					X = permute(X,[2 1 3]);
					X = X ./ 255;
					X = reshape(X, [28, 28, 1, size(X, 3)]);
					
					fclose(fileID);
					
					for i = 1:size(X, 4)
					    value{i} =  X(:, :, :, i);
					end
					
				case 13 % NNDatasetProcess_MNIST.EXTRACT_LABELS
					dataFolder = fullfile(tempdir, 'mnist');
					filename = dproc.get('MNIST_LABEL_FILE');
					if isempty(filename)
					    %fprintf([newline "There is no MNIST label file."])
					    value = {};
					    return
					end
					gunzip(filename, dataFolder)
					[~, name, ~] = fileparts(filename);
					
					[fileID, errmsg] = fopen(fullfile(dataFolder, name), 'r', 'b');
					
					if fileID < 0
					    error(errmsg);
					end
					
					magicNum = fread(fileID, 1, 'int32', 0, 'b');
					if magicNum == 2049
					    fprintf([newline 'Read MNIST label data...'])
					end
					
					numItems = fread(fileID, 1, 'int32', 0, 'b');
					fprintf([newline 'Number of labels in the dataset: %6d ...'], numItems);
					
					Y = fread(fileID, inf, 'unsigned char');
					
					Y = categorical(Y);
					
					fclose(fileID);
					
					for i = 1:size(Y, 1)
					    value{i} = char(Y(i));
					end
					
				case 9 % NNDatasetProcess_MNIST.D
					rng_settings_ = rng(); rng(dproc.getPropSeed(9), 'twister')
					
					raw_image_its = dproc.get('EXTRACT_IMAGES');
					raw_label_its = dproc.get('EXTRACT_LABELS');
					
					it_list = cellfun(@(data, label) NNDataPoint_Image( ...
					    'IMAGE', {data}, ...
					    'TARGET_CLASS', {label}), ...
					    raw_image_its, raw_label_its,...
					    'UniformOutput', false);
					
					dp_list = IndexedDictionary(...
					        'IT_CLASS', 'NNDataPoint_Image', ...
					        'IT_LIST', it_list ...
					        );
					
					value = NNDataset( ...
					    'DP_CLASS', 'NNDataPoint_Image', ...
					    'DP_DICT', dp_list ...
					    );
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 9
						value = calculateValue@NNDatasetProcess(dproc, prop, varargin{:});
					else
						value = calculateValue@Element(dproc, prop, varargin{:});
					end
			end
			
		end
	end
end
