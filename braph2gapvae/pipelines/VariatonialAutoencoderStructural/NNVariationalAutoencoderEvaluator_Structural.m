classdef NNVariationalAutoencoderEvaluator_Structural < NNVariationalAutoencoderEvaluator
	%NNVariationalAutoencoderEvaluator_Structural evaluates a trained variational autoencoder with structural data.
	% It is a subclass of <a href="matlab:help NNVariationalAutoencoderEvaluator">NNVariationalAutoencoderEvaluator</a>.
	%
	% A structural variational autoencoder evaluator (NNVariationalAutoencoderEvaluator_Structural) evaluates a trained variational autoencoder using a structural neural-network dataset. It extracts encoder latent representations, maps each data point back to a selected variable of interest, and plots a two-dimensional latent-space visualisation.
	%
	% The list of NNVariationalAutoencoderEvaluator_Structural properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the structural variational autoencoder evaluator.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the structural variational autoencoder evaluator.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the structural variational autoencoder evaluator.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the structural variational autoencoder evaluator.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the structural variational autoencoder evaluator.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the structural variational autoencoder evaluator.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the structural variational autoencoder evaluator.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network model.
	%  <strong>10</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
	%  <strong>11</strong> <strong>TARGET_NAME</strong> 	TARGET_NAME (metadata, string) is the name of the variable of interest used to label or colour the latent-space plot.
	%  <strong>12</strong> <strong>LATENT_DIM_X</strong> 	LATENT_DIM_X (parameter, scalar) is the latent dimension shown on the x-axis.
	%  <strong>13</strong> <strong>LATENT_DIM_Y</strong> 	LATENT_DIM_Y (parameter, scalar) is the latent dimension shown on the y-axis.
	%  <strong>14</strong> <strong>SAVE_DIR</strong> 	SAVE_DIR (metadata, string) is the directory where evaluation outputs are saved.
	%  <strong>15</strong> <strong>LATENT_REPRESENTATIONS</strong> 	LATENT_REPRESENTATIONS (query, cell) returns latent representations and target values from the encoder.
	%  <strong>16</strong> <strong>TARGET_LABELS</strong> 	TARGET_LABELS (query, cell) returns display labels for the selected target variable.
	%  <strong>17</strong> <strong>PLOT_LATENT_REPRESENTATIONS</strong> 	PLOT_LATENT_REPRESENTATIONS (query, empty) plots and saves a two-dimensional latent-space representation.
	%
	% NNVariationalAutoencoderEvaluator_Structural methods (constructor):
	%  NNVariationalAutoencoderEvaluator_Structural - constructor
	%
	% NNVariationalAutoencoderEvaluator_Structural methods:
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
	% NNVariationalAutoencoderEvaluator_Structural methods (display):
	%  tostring - string with information about the structural variational autoencoder evaluator
	%  disp - displays information about the structural variational autoencoder evaluator
	%  tree - displays the tree of the structural variational autoencoder evaluator
	%
	% NNVariationalAutoencoderEvaluator_Structural methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two structural variational autoencoder evaluator are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the structural variational autoencoder evaluator
	%
	% NNVariationalAutoencoderEvaluator_Structural methods (save/load, Static):
	%  save - saves BRAPH2 structural variational autoencoder evaluator as b2 file
	%  load - loads a BRAPH2 structural variational autoencoder evaluator from a b2 file
	%
	% NNVariationalAutoencoderEvaluator_Structural method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the structural variational autoencoder evaluator
	%
	% NNVariationalAutoencoderEvaluator_Structural method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the structural variational autoencoder evaluator
	%
	% NNVariationalAutoencoderEvaluator_Structural methods (inspection, Static):
	%  getClass - returns the class of the structural variational autoencoder evaluator
	%  getSubclasses - returns all subclasses of NNVariationalAutoencoderEvaluator_Structural
	%  getProps - returns the property list of the structural variational autoencoder evaluator
	%  getPropNumber - returns the property number of the structural variational autoencoder evaluator
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
	% NNVariationalAutoencoderEvaluator_Structural methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNVariationalAutoencoderEvaluator_Structural methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNVariationalAutoencoderEvaluator_Structural methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNVariationalAutoencoderEvaluator_Structural methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNVariationalAutoencoderEvaluator_Structural; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNVariationalAutoencoderEvaluator_Structural constants</a>.
	%
	%
	% See also NNVariationalAutoencoderEvaluator, NNVariationalAutoencoderMLP, NNDatasetProcess_Structural, NNDataPoint_Structural.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		LATENT_REPRESENTATIONS = 15; %CET: Computational Efficiency Trick
		LATENT_REPRESENTATIONS_TAG = 'LATENT_REPRESENTATIONS';
		LATENT_REPRESENTATIONS_CATEGORY = 6;
		LATENT_REPRESENTATIONS_FORMAT = 16;
		
		TARGET_LABELS = 16; %CET: Computational Efficiency Trick
		TARGET_LABELS_TAG = 'TARGET_LABELS';
		TARGET_LABELS_CATEGORY = 6;
		TARGET_LABELS_FORMAT = 16;
		
		PLOT_LATENT_REPRESENTATIONS = 17; %CET: Computational Efficiency Trick
		PLOT_LATENT_REPRESENTATIONS_TAG = 'PLOT_LATENT_REPRESENTATIONS';
		PLOT_LATENT_REPRESENTATIONS_CATEGORY = 6;
		PLOT_LATENT_REPRESENTATIONS_FORMAT = 1;
	end
	methods % constructor
		function nne = NNVariationalAutoencoderEvaluator_Structural(varargin)
			%NNVariationalAutoencoderEvaluator_Structural() creates a structural variational autoencoder evaluator.
			%
			% NNVariationalAutoencoderEvaluator_Structural(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNVariationalAutoencoderEvaluator_Structural(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNVariationalAutoencoderEvaluator_Structural properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the structural variational autoencoder evaluator.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the structural variational autoencoder evaluator.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the structural variational autoencoder evaluator.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the structural variational autoencoder evaluator.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the structural variational autoencoder evaluator.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the structural variational autoencoder evaluator.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the structural variational autoencoder evaluator.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>NN</strong> 	NN (data, item) contains a trained neural network model.
			%  <strong>10</strong> <strong>D</strong> 	D (data, item) is the dataset to evaluate the neural network model.
			%  <strong>11</strong> <strong>TARGET_NAME</strong> 	TARGET_NAME (metadata, string) is the name of the variable of interest used to label or colour the latent-space plot.
			%  <strong>12</strong> <strong>LATENT_DIM_X</strong> 	LATENT_DIM_X (parameter, scalar) is the latent dimension shown on the x-axis.
			%  <strong>13</strong> <strong>LATENT_DIM_Y</strong> 	LATENT_DIM_Y (parameter, scalar) is the latent dimension shown on the y-axis.
			%  <strong>14</strong> <strong>SAVE_DIR</strong> 	SAVE_DIR (metadata, string) is the directory where evaluation outputs are saved.
			%  <strong>15</strong> <strong>LATENT_REPRESENTATIONS</strong> 	LATENT_REPRESENTATIONS (query, cell) returns latent representations and target values from the encoder.
			%  <strong>16</strong> <strong>TARGET_LABELS</strong> 	TARGET_LABELS (query, cell) returns display labels for the selected target variable.
			%  <strong>17</strong> <strong>PLOT_LATENT_REPRESENTATIONS</strong> 	PLOT_LATENT_REPRESENTATIONS (query, empty) plots and saves a two-dimensional latent-space representation.
			%
			% See also Category, Format.
			
			nne = nne@NNVariationalAutoencoderEvaluator(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the structural variational autoencoder evaluator.
			%
			% BUILD = NNVariationalAutoencoderEvaluator_Structural.GETBUILD() returns the build of 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNE.GETBUILD() returns the build of the structural variational autoencoder evaluator NNE.
			%  BUILD = Element.GETBUILD(NNE) returns the build of 'NNE'.
			%  BUILD = Element.GETBUILD('NNVariationalAutoencoderEvaluator_Structural') returns the build of 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Note that the Element.GETBUILD(NNE) and Element.GETBUILD('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nne_class = getClass()
			%GETCLASS returns the class of the structural variational autoencoder evaluator.
			%
			% CLASS = NNVariationalAutoencoderEvaluator_Structural.GETCLASS() returns the class 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the structural variational autoencoder evaluator NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNVariationalAutoencoderEvaluator_Structural') returns 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			
			nne_class = 'NNVariationalAutoencoderEvaluator_Structural';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the structural variational autoencoder evaluator.
			%
			% LIST = NNVariationalAutoencoderEvaluator_Structural.GETSUBCLASSES() returns all subclasses of 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the structural variational autoencoder evaluator NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNVariationalAutoencoderEvaluator_Structural') returns all subclasses of 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNVariationalAutoencoderEvaluator_Structural' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of structural variational autoencoder evaluator.
			%
			% PROPS = NNVariationalAutoencoderEvaluator_Structural.GETPROPS() returns the property list of structural variational autoencoder evaluator
			%  as a row vector.
			%
			% PROPS = NNVariationalAutoencoderEvaluator_Structural.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the structural variational autoencoder evaluator NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNVariationalAutoencoderEvaluator_Structural'[, CATEGORY]) returns the property list of 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNVariationalAutoencoderEvaluator_Structural')
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
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 11 14];
				case 3 % Category.PARAMETER
					prop_list = [4 12 13];
				case 4 % Category.DATA
					prop_list = [5 9 10];
				case 6 % Category.QUERY
					prop_list = [8 15 16 17];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of structural variational autoencoder evaluator.
			%
			% N = NNVariationalAutoencoderEvaluator_Structural.GETPROPNUMBER() returns the property number of structural variational autoencoder evaluator.
			%
			% N = NNVariationalAutoencoderEvaluator_Structural.GETPROPNUMBER(CATEGORY) returns the property number of structural variational autoencoder evaluator
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the structural variational autoencoder evaluator NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNVariationalAutoencoderEvaluator_Structural') returns the property number of 'NNVariationalAutoencoderEvaluator_Structural'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNVariationalAutoencoderEvaluator_Structural')
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
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 4;
				case 3 % Category.PARAMETER
					prop_number = 3;
				case 4 % Category.DATA
					prop_number = 3;
				case 6 % Category.QUERY
					prop_number = 4;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in structural variational autoencoder evaluator/error.
			%
			% CHECK = NNVariationalAutoencoderEvaluator_Structural.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNVariationalAutoencoderEvaluator_Structural, PROP) checks whether PROP exists for NNVariationalAutoencoderEvaluator_Structural.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%  Element.EXISTSPROP(NNVariationalAutoencoderEvaluator_Structural, PROP) throws error if PROP does NOT exist for NNVariationalAutoencoderEvaluator_Structural.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator_Structural:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNVariationalAutoencoderEvaluator_Structural.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in structural variational autoencoder evaluator/error.
			%
			% CHECK = NNVariationalAutoencoderEvaluator_Structural.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNVariationalAutoencoderEvaluator_Structural, TAG) checks whether TAG exists for NNVariationalAutoencoderEvaluator_Structural.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%  Element.EXISTSTAG(NNVariationalAutoencoderEvaluator_Structural, TAG) throws error if TAG does NOT exist for NNVariationalAutoencoderEvaluator_Structural.
			%   Error id: [BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'TARGET_NAME'  'LATENT_DIM_X'  'LATENT_DIM_Y'  'SAVE_DIR'  'LATENT_REPRESENTATIONS'  'TARGET_LABELS'  'PLOT_LATENT_REPRESENTATIONS' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator_Structural:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNVariationalAutoencoderEvaluator_Structural.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns property number of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  PROPERTY = NNE.GETPROPPROP(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns property number of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'TARGET_NAME'  'LATENT_DIM_X'  'LATENT_DIM_Y'  'SAVE_DIR'  'LATENT_REPRESENTATIONS'  'TARGET_LABELS'  'PLOT_LATENT_REPRESENTATIONS' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns tag of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  TAG = NNE.GETPROPTAG(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns tag of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnvariationalautoencoderevaluator_structural_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'NN'  'D'  'TARGET_NAME'  'LATENT_DIM_X'  'LATENT_DIM_Y'  'SAVE_DIR'  'LATENT_REPRESENTATIONS'  'TARGET_LABELS'  'PLOT_LATENT_REPRESENTATIONS' };
				tag = nnvariationalautoencoderevaluator_structural_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns category of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns category of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoderevaluator_structural_category_list = { 1  1  1  3  4  2  2  6  4  4  2  3  3  2  6  6  6 };
			prop_category = nnvariationalautoencoderevaluator_structural_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns format of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  FORMAT = NNE.GETPROPFORMAT(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns format of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoderevaluator_structural_format_list = { 2  2  2  8  2  2  2  2  8  8  2  11  11  2  16  16  1 };
			prop_format = nnvariationalautoencoderevaluator_structural_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns description of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns description of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoderevaluator_structural_description_list = { 'ELCLASS (constant, string) is the class of the structural variational autoencoder evaluator.'  'NAME (constant, string) is the name of the structural variational autoencoder evaluator.'  'DESCRIPTION (constant, string) is the description of the structural variational autoencoder evaluator.'  'TEMPLATE (parameter, item) is the template of the structural variational autoencoder evaluator.'  'ID (data, string) is a few-letter code for the structural variational autoencoder evaluator.'  'LABEL (metadata, string) is an extended label of the structural variational autoencoder evaluator.'  'NOTES (metadata, string) are some specific notes about the structural variational autoencoder evaluator.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'NN (data, item) contains a trained neural network model.'  'D (data, item) is the dataset to evaluate the neural network model.'  'TARGET_NAME (metadata, string) is the name of the variable of interest used to label or colour the latent-space plot.'  'LATENT_DIM_X (parameter, scalar) is the latent dimension shown on the x-axis.'  'LATENT_DIM_Y (parameter, scalar) is the latent dimension shown on the y-axis.'  'SAVE_DIR (metadata, string) is the directory where evaluation outputs are saved.'  'LATENT_REPRESENTATIONS (query, cell) returns latent representations and target values from the encoder.'  'TARGET_LABELS (query, cell) returns display labels for the selected target variable.'  'PLOT_LATENT_REPRESENTATIONS (query, empty) plots and saves a two-dimensional latent-space representation.' };
			prop_description = nnvariationalautoencoderevaluator_structural_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns settings of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns settings of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator_Structural.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS__
					prop_settings = Format.getFormatSettings(16);
				case NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS % __NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS__
					prop_settings = Format.getFormatSettings(16);
				case NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS__
					prop_settings = Format.getFormatSettings(1);
				case NNVariationalAutoencoderEvaluator_Structural.TEMPLATE % __NNVariationalAutoencoderEvaluator_Structural.TEMPLATE__
					prop_settings = 'NNVariationalAutoencoderEvaluator_Structural';
				otherwise
					prop_settings = getPropSettings@NNVariationalAutoencoderEvaluator(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator_Structural.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator_Structural.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns the default value of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns the default value of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNVariationalAutoencoderEvaluator_Structural.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS__
					prop_default = Format.getFormatDefault(16, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				case NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS % __NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS__
					prop_default = Format.getFormatDefault(16, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				case NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS__
					prop_default = Format.getFormatDefault(1, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				case NNVariationalAutoencoderEvaluator_Structural.ELCLASS % __NNVariationalAutoencoderEvaluator_Structural.ELCLASS__
					prop_default = 'NNVariationalAutoencoderEvaluator_Structural';
				case NNVariationalAutoencoderEvaluator_Structural.NAME % __NNVariationalAutoencoderEvaluator_Structural.NAME__
					prop_default = 'Structural Variational Autoencoder Evaluator';
				case NNVariationalAutoencoderEvaluator_Structural.DESCRIPTION % __NNVariationalAutoencoderEvaluator_Structural.DESCRIPTION__
					prop_default = 'A structural variational autoencoder evaluator (NNVariationalAutoencoderEvaluator_Structural) evaluates a trained variational autoencoder using a structural neural-network dataset. It extracts encoder latent representations, maps each data point back to a selected variable of interest, and plots a two-dimensional latent-space visualisation.';
				case NNVariationalAutoencoderEvaluator_Structural.TEMPLATE % __NNVariationalAutoencoderEvaluator_Structural.TEMPLATE__
					prop_default = Format.getFormatDefault(8, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				case NNVariationalAutoencoderEvaluator_Structural.ID % __NNVariationalAutoencoderEvaluator_Structural.ID__
					prop_default = 'NNVariationalAutoencoderEvaluator_Structural ID';
				case NNVariationalAutoencoderEvaluator_Structural.LABEL % __NNVariationalAutoencoderEvaluator_Structural.LABEL__
					prop_default = 'NNVariationalAutoencoderEvaluator_Structural label';
				case NNVariationalAutoencoderEvaluator_Structural.NOTES % __NNVariationalAutoencoderEvaluator_Structural.NOTES__
					prop_default = 'NNVariationalAutoencoderEvaluator_Structural notes';
				otherwise
					prop_default = getPropDefault@NNVariationalAutoencoderEvaluator(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator_Structural.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoderEvaluator_Structural.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoderEvaluator_Structural, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoderEvaluator_Structural.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNVariationalAutoencoderEvaluator_Structural.getPropProp(pointer);
			
			prop_default = NNVariationalAutoencoderEvaluator_Structural.conditioning(prop, NNVariationalAutoencoderEvaluator_Structural.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNVariationalAutoencoderEvaluator_Structural, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoderEvaluator_Structural.
			%  CHECK = NNE.CHECKPROP(NNVariationalAutoencoderEvaluator_Structural, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoderEvaluator_Structural.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput
			%  Element.CHECKPROP(NNVariationalAutoencoderEvaluator_Structural, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoderEvaluator_Structural.
			%   Error id: BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput
			%  NNE.CHECKPROP(NNVariationalAutoencoderEvaluator_Structural, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoderEvaluator_Structural.
			%   Error id: BRAPH2:NNVariationalAutoencoderEvaluator_Structural:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNVariationalAutoencoderEvaluator_Structural')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNVariationalAutoencoderEvaluator_Structural.getPropProp(pointer);
			
			switch prop
				case NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS__
					check = Format.checkFormat(16, value, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				case NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS % __NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS__
					check = Format.checkFormat(16, value, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				case NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS__
					check = Format.checkFormat(1, value, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				case NNVariationalAutoencoderEvaluator_Structural.TEMPLATE % __NNVariationalAutoencoderEvaluator_Structural.TEMPLATE__
					check = Format.checkFormat(8, value, NNVariationalAutoencoderEvaluator_Structural.getPropSettings(prop));
				otherwise
					if prop <= 14
						check = checkProp@NNVariationalAutoencoderEvaluator(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderEvaluator_Structural:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNVariationalAutoencoderEvaluator_Structural.getPropTag(prop) ' (' NNVariationalAutoencoderEvaluator_Structural.getFormatTag(NNVariationalAutoencoderEvaluator_Structural.getPropFormat(prop)) ').'] ...
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
				case NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.LATENT_REPRESENTATIONS__
					nnvae = nne.get('NN');
					d = nne.get('D');
					target_name = nne.get('TARGET_NAME');
					
					if isa(nnvae, 'NoValue') || isa(d, 'NoValue') || strcmp(class(nnvae), 'NNBase')
					    value = {};
					    return
					end
					
					if d.get('DP_DICT').get('LENGTH') == 0
					    value = {};
					    return
					end
					
					netE = nnvae.get('ENCODER');
					mbq = nnvae.get('MBQ', d, 1);
					
					dp_list = d.get('DP_DICT').get('IT_LIST');
					
					target_values = cell(1, numel(dp_list));
					
					for dp_i = 1:numel(dp_list)
					    dp = dp_list{dp_i};
					    voi_dict = dp.get('VOI_DICT');
					
					    if ~any(strcmp(target_name, voi_dict.get('KEYS')))
					        error('TARGET_NAME "%s" was not found in data point %d.', target_name, dp_i)
					    end
					
					    target_values{dp_i} = voi_dict.get('IT', target_name).get('V');
					end
					
					Z = [];
					Y = [];
                    Y_index = [];
					
					while hasdata(mbq)
					    [X_individual, Y_individual] = next(mbq);
					
					    [~, mu, ~] = predict(netE, X_individual);
					
					    Z = cat(2, Z, extractdata(mu));
					
					    % Y_individual stores data-point indices returned by 31.
					    Y_individual = extractdata(gather(Y_individual));
                        Y_individual
					    Y_number = cell2mat(target_values(Y_individual));
                        Y_number
					
					    Y = cat(2, Y, Y_number);
                        Y_index = cat(2, Y_index, Y_individual);
					end
					
					value = {Z, Y};
					
				case NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS % __NNVariationalAutoencoderEvaluator_Structural.TARGET_LABELS__
					d = nne.get('D');
					target_name = nne.get('TARGET_NAME');
					
					if isa(d, 'NoValue') || d.get('DP_DICT').get('LENGTH') == 0
					    value = {};
					    return
					end
					
					dp = d.get('DP_DICT').get('IT', 1);
					voi_dict = dp.get('VOI_DICT');
					
					if ~any(strcmp(target_name, voi_dict.get('KEYS')))
					    value = {};
					    return
					end
					
					voi = voi_dict.get('IT', target_name);
					
					if isa(voi, 'VOICategoric')
					    labels = voi.get('CATEGORIES');
					    labels = strrep(labels, '_', ' ');
					    value = labels;
					else
					    value = {};
					end
					
				case NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS % __NNVariationalAutoencoderEvaluator_Structural.PLOT_LATENT_REPRESENTATIONS__
					latent_info = nne.get('LATENT_REPRESENTATIONS');
					
					if isempty(latent_info)
					    value = {};
					    return
					end
					
					Z = latent_info{1};
					Y = latent_info{2};
					
					latent_dim_x = nne.get('LATENT_DIM_X');
					latent_dim_y = nne.get('LATENT_DIM_Y');
					target_name = nne.get('TARGET_NAME');
					
					if size(Z, 1) < max(latent_dim_x, latent_dim_y)
					    error('The selected latent dimensions exceed the number of available latent dimensions.')
					end
					
					figure('Position', [100 100 650 650])
					
					target_labels = nne.get('TARGET_LABELS');
					
					if isempty(target_labels)
					    scatter( ...
					        Z(latent_dim_x, :), ...
					        Z(latent_dim_y, :), ...
					        24, ...
					        Y, ...
					        'filled' ...
					        );
					
					    colorbar
					else
					    h = gscatter( ...
					        Z(latent_dim_x, :), ...
					        Z(latent_dim_y, :), ...
					        Y, ...
					        [], ...
					        '.', ...
					        24 ...
					        );
					
					    present_groups = unique(Y, 'stable');
					    present_labels = target_labels(present_groups);
					
					    legend(h, present_labels, 'Location', 'best');
					end
					
					axis square
					box on
					
					xlabel(['Latent dimension ' num2str(latent_dim_x)], 'FontSize', 14)
					ylabel(['Latent dimension ' num2str(latent_dim_y)], 'FontSize', 14)
					title(['Latent-space representation by ' target_name], 'FontSize', 16)
					
					set(gca, 'FontSize', 13)
					
					save_dir = nne.get('SAVE_DIR');
					
					if ~isempty(save_dir)
					    if ~isfolder(save_dir)
					        mkdir(save_dir);
					    end
					
					    file_base = [save_dir filesep 'latent_space_by_' target_name];
					
					    saveas(gcf, [file_base '.fig']);
					    saveas(gcf, [file_base '.png']);
					end
					
					value = {};
					
				otherwise
					if prop <= 14
						value = calculateValue@NNVariationalAutoencoderEvaluator(nne, prop, varargin{:});
					else
						value = calculateValue@Element(nne, prop, varargin{:});
					end
			end
			
		end
	end
end
