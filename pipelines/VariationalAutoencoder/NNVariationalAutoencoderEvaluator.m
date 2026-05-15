classdef NNVariationalAutoencoderEvaluator < NNEvaluator
	%NNVariationalAutoencoderEvaluator evaluates the performance of a trained neural network model with a dataset.
	% It is a subclass of <a href="matlab:help NNEvaluator">NNEvaluator</a>.
	%
	% A neural network evaluator (NNEvalu
	% ator) evaluates the performance of a neural network model with a specific dataset.
	% Instances of this class should not be created. Use one of its subclasses instead.
	% Its subclasses shall be specifically designed to cater to different evaluation cases such as a classification task, a regression task, or a data generation task.
	%
	% The list of NNVariationalAutoencoderEvaluator properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the evaluator of the neural network analysis.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the evaluator for the neural network analysis.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the evaluator for the neural network analysis.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the evaluator for the neural network analysis.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the evaluator for the neural network analysis.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the evaluator for the neural network analysis.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the evaluator for the neural network analysis.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network model.
	%  <strong>10</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
	%  <strong>11</strong> <strong>PLOT_LATENT_REPRESENTATIONS</strong> 	PLOT_LATENT_REPRESENTATIONS (query, empty) is to plot latetn representations.
	%  <strong>12</strong> <strong>PREDICT_ENCODER</strong> 	PREDICT_ENCODER (query, cell) returns the predictions of an encoder.
	%
	% NNVariationalAutoencoderEvaluator methods (constructor):
	%  NNVariationalAutoencoderEvaluator - constructor
	%
	% NNVariationalAutoencoderEvaluator methods:
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
	% NNVariationalAutoencoderEvaluator methods (display):
	%  tostring - string with information about the neural network evaluator
	%  disp - displays information about the neural network evaluator
	%  tree - displays the tree of the neural network evaluator
	%
	% NNVariationalAutoencoderEvaluator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator
	%
	% NNVariationalAutoencoderEvaluator methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator as b2 file
	%  load - loads a BRAPH2 neural network evaluator from a b2 file
	%
	% NNVariationalAutoencoderEvaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator
	%
	% NNVariationalAutoencoderEvaluator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator
	%
	% NNVariationalAutoencoderEvaluator methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator
	%  getSubclasses - returns all subclasses of NNVariationalAutoencoderEvaluator
	%  getProps - returns the property list of the neural network evaluator
	%  getPropNumber - returns the property number of the neural network evaluator
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
	% NNVariationalAutoencoderEvaluator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNVariationalAutoencoderEvaluator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNVariationalAutoencoderEvaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNVariationalAutoencoderEvaluator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNVariationalAutoencoderEvaluator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNVariationalAutoencoderEvaluator constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNBase.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		PLOT_LATENT_REPRESENTATIONS = 11; %CET: Computational Efficiency Trick
		PLOT_LATENT_REPRESENTATIONS_TAG = 'PLOT_LATENT_REPRESENTATIONS';
		PLOT_LATENT_REPRESENTATIONS_CATEGORY = 6;
		PLOT_LATENT_REPRESENTATIONS_FORMAT = 1;
		
		PREDICT_ENCODER = 12; %CET: Computational Efficiency Trick
		PREDICT_ENCODER_TAG = 'PREDICT_ENCODER';
		PREDICT_ENCODER_CATEGORY = 6;
		PREDICT_ENCODER_FORMAT = 16;
	end
	methods % constructor
		function nne = NNVariationalAutoencoderEvaluator(varargin)
			%NNVariationalAutoencoderEvaluator() creates a neural network evaluator.
			%
			% NNVariationalAutoencoderEvaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNVariationalAutoencoderEvaluator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNVariationalAutoencoderEvaluator properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the evaluator of the neural network analysis.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the evaluator for the neural network analysis.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the evaluator for the neural network analysis.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the evaluator for the neural network analysis.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the evaluator for the neural network analysis.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the evaluator for the neural network analysis.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the evaluator for the neural network analysis.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network model.
			%  <strong>10</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
			%  <strong>11</strong> <strong>PLOT_LATENT_REPRESENTATIONS</strong> 	PLOT_LATENT_REPRESENTATIONS (query, empty) is to plot latetn representations.
			%  <strong>12</strong> <strong>PREDICT_ENCODER</strong> 	PREDICT_ENCODER (query, cell) returns the predictions of an encoder.
			%
			% See also Category, Format.
			
			nne = nne@NNEvaluator(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the neural network evaluator.
			%
			% BUILD = NNVariationalAutoencoderEvaluator.GETBUILD() returns the build of 'NNVariationalAutoencoderEvaluator'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNE.GETBUILD() returns the build of the neural network evaluator NNE.
			%  BUILD = Element.GETBUILD(NNE) returns the build of 'NNE'.
			%  BUILD = Element.GETBUILD('NNVariationalAutoencoderEvaluator') returns the build of 'NNVariationalAutoencoderEvaluator'.
			%
			% Note that the Element.GETBUILD(NNE) and Element.GETBUILD('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nne_class = getClass()
			%GETCLASS returns the class of the neural network evaluator.
			%
			% CLASS = NNVariationalAutoencoderEvaluator.GETCLASS() returns the class 'NNVariationalAutoencoderEvaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNVariationalAutoencoderEvaluator') returns 'NNVariationalAutoencoderEvaluator'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			
			nne_class = 'NNVariationalAutoencoderEvaluator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator.
			%
			% LIST = NNVariationalAutoencoderEvaluator.GETSUBCLASSES() returns all subclasses of 'NNVariationalAutoencoderEvaluator'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNVariationalAutoencoderEvaluator') returns all subclasses of 'NNVariationalAutoencoderEvaluator'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNVariationalAutoencoderEvaluator'  'NNVariationalAutoencoderEvaluator_Image' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator.
			%
			% PROPS = NNVariationalAutoencoderEvaluator.GETPROPS() returns the property list of neural network evaluator
			%  as a row vector.
			%
			% PROPS = NNVariationalAutoencoderEvaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNVariationalAutoencoderEvaluator'[, CATEGORY]) returns the property list of 'NNVariationalAutoencoderEvaluator'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12];
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
					prop_list = [5 9 10];
				case 6 % Category.QUERY
					prop_list = [8 11 12];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator.
			%
			% N = NNVariationalAutoencoderEvaluator.GETPROPNUMBER() returns the property number of neural network evaluator.
			%
			% N = NNVariationalAutoencoderEvaluator.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNVariationalAutoencoderEvaluator') returns the property number of 'NNVariationalAutoencoderEvaluator'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 12;
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
				case 6 % Category.QUERY
					prop_number = 3;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator/error.
			%
			% CHECK = NNVariationalAutoencoderEvaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNVariationalAutoencoderEvaluator, PROP) checks whether PROP exists for NNVariationalAutoencoderEvaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNVariationalAutoencoderEvaluator, PROP) throws error if PROP does NOT exist for NNVariationalAutoencoderEvaluator.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNVariationalAutoencoderEvaluator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator/error.
			%
			% CHECK = NNVariationalAutoencoderEvaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNVariationalAutoencoderEvaluator, TAG) checks whether TAG exists for NNVariationalAutoencoderEvaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNVariationalAutoencoderEvaluator, TAG) throws error if TAG does NOT exist for NNVariationalAutoencoderEvaluator.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'PLOT_LATENT_REPRESENTATIONS'  'PREDICT_ENCODER' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNVariationalAutoencoderEvaluator.'] ...
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
			%  PROPERTY = NNE.GETPROPPROP(POINTER) returns property number of POINTER of NNE.
			%  PROPERTY = Element.GETPROPPROP(NNVariationalAutoencoderEvaluator, POINTER) returns property number of POINTER of NNVariationalAutoencoderEvaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNVariationalAutoencoderEvaluator, POINTER) returns property number of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'PLOT_LATENT_REPRESENTATIONS'  'PREDICT_ENCODER' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNE.GETPROPTAG(POINTER) returns tag of POINTER of NNE.
			%  TAG = Element.GETPROPTAG(NNVariationalAutoencoderEvaluator, POINTER) returns tag of POINTER of NNVariationalAutoencoderEvaluator.
			%  TAG = NNE.GETPROPTAG(NNVariationalAutoencoderEvaluator, POINTER) returns tag of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnvariationalautoencoderevaluator_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'PLOT_LATENT_REPRESENTATIONS'  'PREDICT_ENCODER' };
				tag = nnvariationalautoencoderevaluator_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNVariationalAutoencoderEvaluator, POINTER) returns category of POINTER of NNVariationalAutoencoderEvaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNVariationalAutoencoderEvaluator, POINTER) returns category of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoderevaluator_category_list = { 1  1  1  3  4  2  2  6  4  4  6  6 };
			prop_category = nnvariationalautoencoderevaluator_category_list{prop};
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
			%  FORMAT = NNE.GETPROPFORMAT(POINTER) returns format of POINTER of NNE.
			%  FORMAT = Element.GETPROPFORMAT(NNVariationalAutoencoderEvaluator, POINTER) returns format of POINTER of NNVariationalAutoencoderEvaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNVariationalAutoencoderEvaluator, POINTER) returns format of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoderevaluator_format_list = { 2  2  2  8  2  2  2  2  8  8  1  16 };
			prop_format = nnvariationalautoencoderevaluator_format_list{prop};
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
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNVariationalAutoencoderEvaluator, POINTER) returns description of POINTER of NNVariationalAutoencoderEvaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNVariationalAutoencoderEvaluator, POINTER) returns description of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoderevaluator_description_list = { 'ELCLASS (constant, string) is the class of the evaluator of the neural network analysis.'  'NAME (constant, string) is the name of the evaluator for the neural network analysis.'  'DESCRIPTION (constant, string) is the description of the evaluator for the neural network analysis.'  'TEMPLATE (parameter, item) is the template of the evaluator for the neural network analysis.'  'ID (data, string) is a few-letter code for the evaluator for the neural network analysis.'  'LABEL (metadata, string) is an extended label of the evaluator for the neural network analysis.'  'NOTES (metadata, string) are some specific notes about the evaluator for the neural network analysis.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NN (data, item) contains a trained neural network model.'  'D (data, item) is the dataset to evaluate the neural network model.'  'PLOT_LATENT_REPRESENTATIONS (query, empty) is to plot latetn representations.'  'PREDICT_ENCODER (query, cell) returns the predictions of an encoder.' };
			prop_description = nnvariationalautoencoderevaluator_description_list{prop};
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
			%  SETTINGS = NNE.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNE.
			%  SETTINGS = Element.GETPROPSETTINGS(NNVariationalAutoencoderEvaluator, POINTER) returns settings of POINTER of NNVariationalAutoencoderEvaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNVariationalAutoencoderEvaluator, POINTER) returns settings of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNVariationalAutoencoderEvaluator.PLOT_LATENT_REPRESENTATIONS
					prop_settings = Format.getFormatSettings(1);
				case 12 % NNVariationalAutoencoderEvaluator.PREDICT_ENCODER
					prop_settings = Format.getFormatSettings(16);
				case 4 % NNVariationalAutoencoderEvaluator.TEMPLATE
					prop_settings = 'NNVariationalAutoencoderEvaluator';
				otherwise
					prop_settings = getPropSettings@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNVariationalAutoencoderEvaluator, POINTER) returns the default value of POINTER of NNVariationalAutoencoderEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNVariationalAutoencoderEvaluator, POINTER) returns the default value of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 11 % NNVariationalAutoencoderEvaluator.PLOT_LATENT_REPRESENTATIONS
					prop_default = Format.getFormatDefault(1, NNVariationalAutoencoderEvaluator.getPropSettings(prop));
				case 12 % NNVariationalAutoencoderEvaluator.PREDICT_ENCODER
					prop_default = Format.getFormatDefault(16, NNVariationalAutoencoderEvaluator.getPropSettings(prop));
				case 1 % NNVariationalAutoencoderEvaluator.ELCLASS
					prop_default = 'NNVariationalAutoencoderEvaluator';
				case 2 % NNVariationalAutoencoderEvaluator.NAME
					prop_default = 'Neural Network Evaluator';
				case 3 % NNVariationalAutoencoderEvaluator.DESCRIPTION
					prop_default = 'A neural network evaluator (NNEvaluator) evaluates the performance of a neural network model with a specific dataset. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses shall be specifically designed to cater to different evaluation cases such as a classification task, a regression task, or a data generation task.';
				case 4 % NNVariationalAutoencoderEvaluator.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNVariationalAutoencoderEvaluator.getPropSettings(prop));
				case 5 % NNVariationalAutoencoderEvaluator.ID
					prop_default = 'NNEvaluator ID';
				case 6 % NNVariationalAutoencoderEvaluator.LABEL
					prop_default = 'NNEvaluator label';
				case 7 % NNVariationalAutoencoderEvaluator.NOTES
					prop_default = 'NNEvaluator notes';
				otherwise
					prop_default = getPropDefault@NNEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoderEvaluator, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoderEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoderEvaluator, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoderEvaluator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNVariationalAutoencoderEvaluator.getPropProp(pointer);
			
			prop_default = NNVariationalAutoencoderEvaluator.conditioning(prop, NNVariationalAutoencoderEvaluator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNE.
			%  CHECK = Element.CHECKPROP(NNVariationalAutoencoderEvaluator, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoderEvaluator.
			%  CHECK = NNE.CHECKPROP(NNVariationalAutoencoderEvaluator, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoderEvaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput
			%  Element.CHECKPROP(NNVariationalAutoencoderEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoderEvaluator.
			%   Error id: BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput
			%  NNE.CHECKPROP(NNVariationalAutoencoderEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoderEvaluator.
			%   Error id: BRAPH2:NNVariationalAutoencoderEvaluator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNVariationalAutoencoderEvaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNVariationalAutoencoderEvaluator.getPropProp(pointer);
			
			switch prop
				case 11 % NNVariationalAutoencoderEvaluator.PLOT_LATENT_REPRESENTATIONS
					check = Format.checkFormat(1, value, NNVariationalAutoencoderEvaluator.getPropSettings(prop));
				case 12 % NNVariationalAutoencoderEvaluator.PREDICT_ENCODER
					check = Format.checkFormat(16, value, NNVariationalAutoencoderEvaluator.getPropSettings(prop));
				case 4 % NNVariationalAutoencoderEvaluator.TEMPLATE
					check = Format.checkFormat(8, value, NNVariationalAutoencoderEvaluator.getPropSettings(prop));
				otherwise
					if prop <= 10
						check = checkProp@NNEvaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNVariationalAutoencoderEvaluator.getPropTag(prop) ' (' NNVariationalAutoencoderEvaluator.getFormatTag(NNVariationalAutoencoderEvaluator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nne, prop, varargin)
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
				case 11 % NNVariationalAutoencoderEvaluator.PLOT_LATENT_REPRESENTATIONS
					nnvae = nne.get('NN');
					if strcmp(class(nnvae), 'NNBase')
					    value = [];
					    return
					end
					netE = nnvae.get('ENCODER');
					d = nne.get('D');
					mbq = nnvae.get('MBQ', d);
					
					latentInfo = nne.get('PREDICT_ENCODER', netE, mbq);
					ZLatent = latentInfo{1};
					YLatent = latentInfo{2};
					%index_selected = (YLatent == 2) | (YLatent == 1) | (YLatent == 10) | (YLatent == 8) | (YLatent == 3);
					
					%figure;
					%h = scatter(ZLatent(1, index_selected), ZLatent(2, index_selected), 30, YLatent(index_selected), 'filled');
					h = gscatter(ZLatent(1, :), ZLatent(2, :), YLatent, [], '.', 12);
					
					title('Scatter Plot with Color-Coded Categories');
					value = [];
					
				case 12 % NNVariationalAutoencoderEvaluator.PREDICT_ENCODER
					if isempty(varargin)
					    value = {};
					    return
					end
					
					netE = varargin{1};
					mbq = varargin{2};
					
					targets = categorical(nne.get('NN').get('TARGETS', nne.get('D')));
					Z = [];
					Y = [];
					
					% Loop over mini-batches.
					while hasdata(mbq)
					    [X_individual, Y_individual] = next(mbq);
					
					    % Forward through encoder.
					    %Z_individual = predict(netE,X_individual,Outputs='latentOuput');
					    [Z_individual, mu, logSigmaSq] = predict(netE, X_individual);
					    
					    % Extract and concatenate predictions.
					    %Z = cat(2,Z,extractdata(Z_individual));
					    Z = cat(2, Z, extractdata(mu));
					
					    Y_individual = extractdata(gather(Y_individual));
					    Y_number = targets(Y_individual);
					    Y = cat(1, Y, Y_number);
					end
					
					value = [{Z}, {Y}];
					
				otherwise
					if prop <= 10
						value = calculateValue@NNEvaluator(nne, prop, varargin{:});
					else
						value = calculateValue@Element(nne, prop, varargin{:});
					end
			end
			
		end
	end
end
