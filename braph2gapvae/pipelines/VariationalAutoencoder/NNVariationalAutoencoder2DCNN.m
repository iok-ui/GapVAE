classdef NNVariationalAutoencoder2DCNN < NNVariationalAutoencoder
	%NNVariationalAutoencoder2DCNN transfroms neural network datasets.
	% It is a subclass of <a href="matlab:help NNVariationalAutoencoder">NNVariationalAutoencoder</a>.
	%
	% A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. 
	% The resulting combined dataset contains all the unique datapoints from the input datasets, 
	% and any overlapping datapoints are excluded to ensure data consistency.
	%
	% The list of NNVariationalAutoencoder2DCNN properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the combiner of neural networks datasets.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the combiner of neural networks datasets.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the combiner of neural networks datasets.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the combiner of neural networks datasets.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the combiner of neural networks datasets.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
	%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
	%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
	%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the cell array of the data.
	%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the cell array of the targets.
	%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
	%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
	%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
	%  <strong>22</strong> <strong>LEARN_RATE</strong> 	LEARN_RATE (parameter, scalar) is the learning rate for optimisation.
	%  <strong>23</strong> <strong>NUM_LATENT_REP</strong> 	NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).
	%  <strong>24</strong> <strong>SIZE_INPUT</strong> 	SIZE_INPUT (parameter, rvector) is the size of the input image.
	%  <strong>25</strong> <strong>ITERATION_DIM</strong> 	ITERATION_DIM (parameter, scalar) is the iteration dimension.
	%  <strong>26</strong> <strong>NUM_MBQ_OUTPUT</strong> 	NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).
	%  <strong>27</strong> <strong>MINIBATCH_FORMAT_INPUT</strong> 	MINIBATCH_FORMAT_INPUT (query, string) returns the elbo loss.
	%  <strong>28</strong> <strong>MINIBATCH_FORMAT_TARGET</strong> 	MINIBATCH_FORMAT_TARGET (query, string) returns the elbo loss.
	%  <strong>29</strong> <strong>ENCODER</strong> 	ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.
	%  <strong>30</strong> <strong>DECODER</strong> 	DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.
	%  <strong>31</strong> <strong>MBQ</strong> 	MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.
	%  <strong>32</strong> <strong>LOSS_FN</strong> 	LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).
	%  <strong>33</strong> <strong>CHANNELS_PER_LAYER</strong> 	CHANNELS_PER_LAYER (parameter, rvector) is the size of the input image.
	%  <strong>34</strong> <strong>SIZE_FILTER</strong> 	SIZE_FILTER (parameter, rvector) is the size of the input image.
	%  <strong>35</strong> <strong>STRIDE_PER_LAYER</strong> 	STRIDE_PER_LAYER (parameter, rvector) is the size of the input image.
	%
	% NNVariationalAutoencoder2DCNN methods (constructor):
	%  NNVariationalAutoencoder2DCNN - constructor
	%
	% NNVariationalAutoencoder2DCNN methods:
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
	% NNVariationalAutoencoder2DCNN methods (display):
	%  tostring - string with information about the normalizer of a neural network data
	%  disp - displays information about the normalizer of a neural network data
	%  tree - displays the tree of the normalizer of a neural network data
	%
	% NNVariationalAutoencoder2DCNN methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two normalizer of a neural network data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the normalizer of a neural network data
	%
	% NNVariationalAutoencoder2DCNN methods (save/load, Static):
	%  save - saves BRAPH2 normalizer of a neural network data as b2 file
	%  load - loads a BRAPH2 normalizer of a neural network data from a b2 file
	%
	% NNVariationalAutoencoder2DCNN method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the normalizer of a neural network data
	%
	% NNVariationalAutoencoder2DCNN method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the normalizer of a neural network data
	%
	% NNVariationalAutoencoder2DCNN methods (inspection, Static):
	%  getClass - returns the class of the normalizer of a neural network data
	%  getSubclasses - returns all subclasses of NNVariationalAutoencoder2DCNN
	%  getProps - returns the property list of the normalizer of a neural network data
	%  getPropNumber - returns the property number of the normalizer of a neural network data
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
	% NNVariationalAutoencoder2DCNN methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNVariationalAutoencoder2DCNN methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNVariationalAutoencoder2DCNN methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNVariationalAutoencoder2DCNN methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNVariationalAutoencoder2DCNN; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNVariationalAutoencoder2DCNN constants</a>.
	%
	%
	% See also NNDataset, NNDatasetSplit.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		CHANNELS_PER_LAYER = 33; %CET: Computational Efficiency Trick
		CHANNELS_PER_LAYER_TAG = 'CHANNELS_PER_LAYER';
		CHANNELS_PER_LAYER_CATEGORY = 3;
		CHANNELS_PER_LAYER_FORMAT = 12;
		
		SIZE_FILTER = 34; %CET: Computational Efficiency Trick
		SIZE_FILTER_TAG = 'SIZE_FILTER';
		SIZE_FILTER_CATEGORY = 3;
		SIZE_FILTER_FORMAT = 12;
		
		STRIDE_PER_LAYER = 35; %CET: Computational Efficiency Trick
		STRIDE_PER_LAYER_TAG = 'STRIDE_PER_LAYER';
		STRIDE_PER_LAYER_CATEGORY = 3;
		STRIDE_PER_LAYER_FORMAT = 12;
	end
	methods % constructor
		function nnvae = NNVariationalAutoencoder2DCNN(varargin)
			%NNVariationalAutoencoder2DCNN() creates a normalizer of a neural network data.
			%
			% NNVariationalAutoencoder2DCNN(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNVariationalAutoencoder2DCNN(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNVariationalAutoencoder2DCNN properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the combiner of neural networks datasets.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the combiner of neural networks datasets.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the combiner of neural networks datasets.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the combiner of neural networks datasets.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the combiner of neural networks datasets.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.
			%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data points.
			%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
			%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs the cell array of the data.
			%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs the cell array of the targets.
			%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the neural network model with the given dataset.
			%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
			%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
			%  <strong>22</strong> <strong>LEARN_RATE</strong> 	LEARN_RATE (parameter, scalar) is the learning rate for optimisation.
			%  <strong>23</strong> <strong>NUM_LATENT_REP</strong> 	NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).
			%  <strong>24</strong> <strong>SIZE_INPUT</strong> 	SIZE_INPUT (parameter, rvector) is the size of the input image.
			%  <strong>25</strong> <strong>ITERATION_DIM</strong> 	ITERATION_DIM (parameter, scalar) is the iteration dimension.
			%  <strong>26</strong> <strong>NUM_MBQ_OUTPUT</strong> 	NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).
			%  <strong>27</strong> <strong>MINIBATCH_FORMAT_INPUT</strong> 	MINIBATCH_FORMAT_INPUT (query, string) returns the elbo loss.
			%  <strong>28</strong> <strong>MINIBATCH_FORMAT_TARGET</strong> 	MINIBATCH_FORMAT_TARGET (query, string) returns the elbo loss.
			%  <strong>29</strong> <strong>ENCODER</strong> 	ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.
			%  <strong>30</strong> <strong>DECODER</strong> 	DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.
			%  <strong>31</strong> <strong>MBQ</strong> 	MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.
			%  <strong>32</strong> <strong>LOSS_FN</strong> 	LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).
			%  <strong>33</strong> <strong>CHANNELS_PER_LAYER</strong> 	CHANNELS_PER_LAYER (parameter, rvector) is the size of the input image.
			%  <strong>34</strong> <strong>SIZE_FILTER</strong> 	SIZE_FILTER (parameter, rvector) is the size of the input image.
			%  <strong>35</strong> <strong>STRIDE_PER_LAYER</strong> 	STRIDE_PER_LAYER (parameter, rvector) is the size of the input image.
			%
			% See also Category, Format.
			
			nnvae = nnvae@NNVariationalAutoencoder(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the normalizer of a neural network data.
			%
			% BUILD = NNVariationalAutoencoder2DCNN.GETBUILD() returns the build of 'NNVariationalAutoencoder2DCNN'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNVAE.GETBUILD() returns the build of the normalizer of a neural network data NNVAE.
			%  BUILD = Element.GETBUILD(NNVAE) returns the build of 'NNVAE'.
			%  BUILD = Element.GETBUILD('NNVariationalAutoencoder2DCNN') returns the build of 'NNVariationalAutoencoder2DCNN'.
			%
			% Note that the Element.GETBUILD(NNVAE) and Element.GETBUILD('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnvae_class = getClass()
			%GETCLASS returns the class of the normalizer of a neural network data.
			%
			% CLASS = NNVariationalAutoencoder2DCNN.GETCLASS() returns the class 'NNVariationalAutoencoder2DCNN'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNVAE.GETCLASS() returns the class of the normalizer of a neural network data NNVAE.
			%  CLASS = Element.GETCLASS(NNVAE) returns the class of 'NNVAE'.
			%  CLASS = Element.GETCLASS('NNVariationalAutoencoder2DCNN') returns 'NNVariationalAutoencoder2DCNN'.
			%
			% Note that the Element.GETCLASS(NNVAE) and Element.GETCLASS('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			
			nnvae_class = 'NNVariationalAutoencoder2DCNN';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the normalizer of a neural network data.
			%
			% LIST = NNVariationalAutoencoder2DCNN.GETSUBCLASSES() returns all subclasses of 'NNVariationalAutoencoder2DCNN'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNVAE.GETSUBCLASSES() returns all subclasses of the normalizer of a neural network data NNVAE.
			%  LIST = Element.GETSUBCLASSES(NNVAE) returns all subclasses of 'NNVAE'.
			%  LIST = Element.GETSUBCLASSES('NNVariationalAutoencoder2DCNN') returns all subclasses of 'NNVariationalAutoencoder2DCNN'.
			%
			% Note that the Element.GETSUBCLASSES(NNVAE) and Element.GETSUBCLASSES('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNVariationalAutoencoder2DCNN' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of normalizer of a neural network data.
			%
			% PROPS = NNVariationalAutoencoder2DCNN.GETPROPS() returns the property list of normalizer of a neural network data
			%  as a row vector.
			%
			% PROPS = NNVariationalAutoencoder2DCNN.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNVAE.GETPROPS([CATEGORY]) returns the property list of the normalizer of a neural network data NNVAE.
			%  PROPS = Element.GETPROPS(NNVAE[, CATEGORY]) returns the property list of 'NNVAE'.
			%  PROPS = Element.GETPROPS('NNVariationalAutoencoder2DCNN'[, CATEGORY]) returns the property list of 'NNVariationalAutoencoder2DCNN'.
			%
			% Note that the Element.GETPROPS(NNVAE) and Element.GETPROPS('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 20];
				case 3 % Category.PARAMETER
					prop_list = [4 10 11 12 13 14 22 23 24 25 26 33 34 35];
				case 4 % Category.DATA
					prop_list = [5 9 29 30];
				case 5 % Category.RESULT
					prop_list = 15;
				case 6 % Category.QUERY
					prop_list = [8 16 17 18 21 27 28 31 32];
				case 9 % Category.GUI
					prop_list = 19;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of normalizer of a neural network data.
			%
			% N = NNVariationalAutoencoder2DCNN.GETPROPNUMBER() returns the property number of normalizer of a neural network data.
			%
			% N = NNVariationalAutoencoder2DCNN.GETPROPNUMBER(CATEGORY) returns the property number of normalizer of a neural network data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNVAE.GETPROPNUMBER([CATEGORY]) returns the property number of the normalizer of a neural network data NNVAE.
			%  N = Element.GETPROPNUMBER(NNVAE) returns the property number of 'NNVAE'.
			%  N = Element.GETPROPNUMBER('NNVariationalAutoencoder2DCNN') returns the property number of 'NNVariationalAutoencoder2DCNN'.
			%
			% Note that the Element.GETPROPNUMBER(NNVAE) and Element.GETPROPNUMBER('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 35;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 14;
				case 4 % Category.DATA
					prop_number = 4;
				case 5 % Category.RESULT
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 9;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in normalizer of a neural network data/error.
			%
			% CHECK = NNVariationalAutoencoder2DCNN.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNVAE.EXISTSPROP(PROP) checks whether PROP exists for NNVAE.
			%  CHECK = Element.EXISTSPROP(NNVAE, PROP) checks whether PROP exists for NNVAE.
			%  CHECK = Element.EXISTSPROP(NNVariationalAutoencoder2DCNN, PROP) checks whether PROP exists for NNVariationalAutoencoder2DCNN.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNVAE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%  Element.EXISTSPROP(NNVAE, PROP) throws error if PROP does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%  Element.EXISTSPROP(NNVariationalAutoencoder2DCNN, PROP) throws error if PROP does NOT exist for NNVariationalAutoencoder2DCNN.
			%   Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNVAE) and Element.EXISTSPROP('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 35 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoder2DCNN:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoder2DCNN:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNVariationalAutoencoder2DCNN.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in normalizer of a neural network data/error.
			%
			% CHECK = NNVariationalAutoencoder2DCNN.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNVAE.EXISTSTAG(TAG) checks whether TAG exists for NNVAE.
			%  CHECK = Element.EXISTSTAG(NNVAE, TAG) checks whether TAG exists for NNVAE.
			%  CHECK = Element.EXISTSTAG(NNVariationalAutoencoder2DCNN, TAG) checks whether TAG exists for NNVariationalAutoencoder2DCNN.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNVAE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%  Element.EXISTSTAG(NNVAE, TAG) throws error if TAG does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%  Element.EXISTSTAG(NNVariationalAutoencoder2DCNN, TAG) throws error if TAG does NOT exist for NNVariationalAutoencoder2DCNN.
			%   Error id: [BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNVAE) and Element.EXISTSTAG('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN'  'CHANNELS_PER_LAYER'  'SIZE_FILTER'  'STRIDE_PER_LAYER' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoder2DCNN:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoder2DCNN:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNVariationalAutoencoder2DCNN.'] ...
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
			%  PROPERTY = NNVAE.GETPROPPROP(POINTER) returns property number of POINTER of NNVAE.
			%  PROPERTY = Element.GETPROPPROP(NNVariationalAutoencoder2DCNN, POINTER) returns property number of POINTER of NNVariationalAutoencoder2DCNN.
			%  PROPERTY = NNVAE.GETPROPPROP(NNVariationalAutoencoder2DCNN, POINTER) returns property number of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPPROP(NNVAE) and Element.GETPROPPROP('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN'  'CHANNELS_PER_LAYER'  'SIZE_FILTER'  'STRIDE_PER_LAYER' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = NNVAE.GETPROPTAG(POINTER) returns tag of POINTER of NNVAE.
			%  TAG = Element.GETPROPTAG(NNVariationalAutoencoder2DCNN, POINTER) returns tag of POINTER of NNVariationalAutoencoder2DCNN.
			%  TAG = NNVAE.GETPROPTAG(NNVariationalAutoencoder2DCNN, POINTER) returns tag of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPTAG(NNVAE) and Element.GETPROPTAG('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnvariationalautoencoder2dcnn_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN'  'CHANNELS_PER_LAYER'  'SIZE_FILTER'  'STRIDE_PER_LAYER' };
				tag = nnvariationalautoencoder2dcnn_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = NNVAE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNVAE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNVariationalAutoencoder2DCNN, POINTER) returns category of POINTER of NNVariationalAutoencoder2DCNN.
			%  CATEGORY = NNVAE.GETPROPCATEGORY(NNVariationalAutoencoder2DCNN, POINTER) returns category of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPCATEGORY(NNVAE) and Element.GETPROPCATEGORY('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder2DCNN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoder2dcnn_category_list = { 1  1  1  3  4  2  2  6  4  3  3  3  3  3  5  6  6  6  9  2  6  3  3  3  3  3  6  6  4  4  6  6  3  3  3 };
			prop_category = nnvariationalautoencoder2dcnn_category_list{prop};
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
			%  FORMAT = NNVAE.GETPROPFORMAT(POINTER) returns format of POINTER of NNVAE.
			%  FORMAT = Element.GETPROPFORMAT(NNVariationalAutoencoder2DCNN, POINTER) returns format of POINTER of NNVariationalAutoencoder2DCNN.
			%  FORMAT = NNVAE.GETPROPFORMAT(NNVariationalAutoencoder2DCNN, POINTER) returns format of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPFORMAT(NNVAE) and Element.GETPROPFORMAT('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder2DCNN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoder2dcnn_format_list = { 2  2  2  8  2  2  2  2  8  7  11  11  5  5  17  16  16  1  4  5  16  11  11  12  11  11  2  2  17  17  1  11  12  12  12 };
			prop_format = nnvariationalautoencoder2dcnn_format_list{prop};
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
			%  DESCRIPTION = NNVAE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNVAE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNVariationalAutoencoder2DCNN, POINTER) returns description of POINTER of NNVariationalAutoencoder2DCNN.
			%  DESCRIPTION = NNVAE.GETPROPDESCRIPTION(NNVariationalAutoencoder2DCNN, POINTER) returns description of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNVAE) and Element.GETPROPDESCRIPTION('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder2DCNN.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoder2dcnn_description_list = { 'ELCLASS (constant, string) is the class of the combiner of neural networks datasets.'  'NAME (constant, string) is the name of the combiner of neural networks datasets.'  'DESCRIPTION (constant, string) is the description of the combiner of neural networks datasets.'  'TEMPLATE (parameter, item) is the template of the combiner of neural networks datasets.'  'ID (data, string) is a few-letter code of the combiner of neural networks datasets.'  'LABEL (metadata, string) is an extended label of the combiner of neural networks datasets.'  'NOTES (metadata, string) are some specific notes of the combiner of neural networks datasets.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the dataset to train the neural network model, and its data point class DP_CLASS defaults to one of the compatible classes within the set of DP_CLASSES.'  'DP_CLASSES (parameter, classlist) is the list of compatible data points.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'MODEL (result, net) is a trained neural network model with the given dataset.'  'INPUTS (query, cell) constructs the cell array of the data.'  'TARGETS (query, cell) constructs the cell array of the targets.'  'TRAIN (query, empty) trains the neural network model with the given dataset.'  'VERBOSE (gui, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.'  'LEARN_RATE (parameter, scalar) is the learning rate for optimisation.'  'NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).'  'SIZE_INPUT (parameter, rvector) is the size of the input image.'  'ITERATION_DIM (parameter, scalar) is the iteration dimension.'  'NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).'  'MINIBATCH_FORMAT_INPUT (query, string) returns the elbo loss.'  'MINIBATCH_FORMAT_TARGET (query, string) returns the elbo loss.'  'ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.'  'DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.'  'MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.'  'LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).'  'CHANNELS_PER_LAYER (parameter, rvector) is the size of the input image.'  'SIZE_FILTER (parameter, rvector) is the size of the input image.'  'STRIDE_PER_LAYER (parameter, rvector) is the size of the input image.' };
			prop_description = nnvariationalautoencoder2dcnn_description_list{prop};
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
			%  SETTINGS = NNVAE.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNVAE.
			%  SETTINGS = Element.GETPROPSETTINGS(NNVariationalAutoencoder2DCNN, POINTER) returns settings of POINTER of NNVariationalAutoencoder2DCNN.
			%  SETTINGS = NNVAE.GETPROPSETTINGS(NNVariationalAutoencoder2DCNN, POINTER) returns settings of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPSETTINGS(NNVAE) and Element.GETPROPSETTINGS('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder2DCNN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 33 % NNVariationalAutoencoder2DCNN.CHANNELS_PER_LAYER
					prop_settings = Format.getFormatSettings(12);
				case 34 % NNVariationalAutoencoder2DCNN.SIZE_FILTER
					prop_settings = Format.getFormatSettings(12);
				case 35 % NNVariationalAutoencoder2DCNN.STRIDE_PER_LAYER
					prop_settings = Format.getFormatSettings(12);
				case 4 % NNVariationalAutoencoder2DCNN.TEMPLATE
					prop_settings = 'NNVariationalAutoencoder2DCNN';
				case 9 % NNVariationalAutoencoder2DCNN.D
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@NNVariationalAutoencoder(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoder2DCNN.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoder2DCNN.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNVAE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNVAE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNVariationalAutoencoder2DCNN, POINTER) returns the default value of POINTER of NNVariationalAutoencoder2DCNN.
			%  DEFAULT = NNVAE.GETPROPDEFAULT(NNVariationalAutoencoder2DCNN, POINTER) returns the default value of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPDEFAULT(NNVAE) and Element.GETPROPDEFAULT('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNVariationalAutoencoder2DCNN.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 33 % NNVariationalAutoencoder2DCNN.CHANNELS_PER_LAYER
					prop_default = [32 64];
				case 34 % NNVariationalAutoencoder2DCNN.SIZE_FILTER
					prop_default = [3 3];
				case 35 % NNVariationalAutoencoder2DCNN.STRIDE_PER_LAYER
					prop_default = [2 2];
				case 1 % NNVariationalAutoencoder2DCNN.ELCLASS
					prop_default = 'NNVariationalAutoencoder2DCNN';
				case 2 % NNVariationalAutoencoder2DCNN.NAME
					prop_default = 'Neural Network Variational Autoencoders with 2D CNN';
				case 3 % NNVariationalAutoencoder2DCNN.DESCRIPTION
					prop_default = 'A dataset combiner (NNDatasetCombine) takes a list of neural network datasets and combines them into a single dataset. The resulting combined dataset contains all the unique datapoints from the input datasets, and any overlapping datapoints are excluded to ensure data consistency.';
				case 4 % NNVariationalAutoencoder2DCNN.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNVariationalAutoencoder2DCNN.getPropSettings(prop));
				case 5 % NNVariationalAutoencoder2DCNN.ID
					prop_default = 'NNDatasetCombine ID';
				case 6 % NNVariationalAutoencoder2DCNN.LABEL
					prop_default = 'NNDatasetCombine label';
				case 7 % NNVariationalAutoencoder2DCNN.NOTES
					prop_default = 'NNDatasetCombine notes';
				case 9 % NNVariationalAutoencoder2DCNN.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint');
				case 10 % NNVariationalAutoencoder2DCNN.DP_CLASSES
					prop_default = {'NNDataPoint' 'NNDataPoint_Image'};
				case 24 % NNVariationalAutoencoder2DCNN.SIZE_INPUT
					prop_default = [28 28 1];
				case 25 % NNVariationalAutoencoder2DCNN.ITERATION_DIM
					prop_default = 4;
				case 27 % NNVariationalAutoencoder2DCNN.MINIBATCH_FORMAT_INPUT
					prop_default = 'SSCB';
				case 28 % NNVariationalAutoencoder2DCNN.MINIBATCH_FORMAT_TARGET
					prop_default = '';
				otherwise
					prop_default = getPropDefault@NNVariationalAutoencoder(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoder2DCNN.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoder2DCNN.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNVAE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNVAE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoder2DCNN, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoder2DCNN.
			%  DEFAULT = NNVAE.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoder2DCNN, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoder2DCNN.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNVAE) and Element.GETPROPDEFAULTCONDITIONED('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNVariationalAutoencoder2DCNN.getPropProp(pointer);
			
			prop_default = NNVariationalAutoencoder2DCNN.conditioning(prop, NNVariationalAutoencoder2DCNN.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNVAE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNVAE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNVAE.
			%  CHECK = Element.CHECKPROP(NNVariationalAutoencoder2DCNN, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoder2DCNN.
			%  CHECK = NNVAE.CHECKPROP(NNVariationalAutoencoder2DCNN, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoder2DCNN.
			% 
			% NNVAE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNVAE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNVAE.
			%   Error id: BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput
			%  Element.CHECKPROP(NNVariationalAutoencoder2DCNN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoder2DCNN.
			%   Error id: BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput
			%  NNVAE.CHECKPROP(NNVariationalAutoencoder2DCNN, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoder2DCNN.
			%   Error id: BRAPH2:NNVariationalAutoencoder2DCNN:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNVAE) and Element.CHECKPROP('NNVariationalAutoencoder2DCNN')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNVariationalAutoencoder2DCNN.getPropProp(pointer);
			
			switch prop
				case 33 % NNVariationalAutoencoder2DCNN.CHANNELS_PER_LAYER
					check = Format.checkFormat(12, value, NNVariationalAutoencoder2DCNN.getPropSettings(prop));
				case 34 % NNVariationalAutoencoder2DCNN.SIZE_FILTER
					check = Format.checkFormat(12, value, NNVariationalAutoencoder2DCNN.getPropSettings(prop));
				case 35 % NNVariationalAutoencoder2DCNN.STRIDE_PER_LAYER
					check = Format.checkFormat(12, value, NNVariationalAutoencoder2DCNN.getPropSettings(prop));
				case 4 % NNVariationalAutoencoder2DCNN.TEMPLATE
					check = Format.checkFormat(8, value, NNVariationalAutoencoder2DCNN.getPropSettings(prop));
				case 9 % NNVariationalAutoencoder2DCNN.D
					check = Format.checkFormat(8, value, NNVariationalAutoencoder2DCNN.getPropSettings(prop));
				otherwise
					if prop <= 32
						check = checkProp@NNVariationalAutoencoder(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoder2DCNN:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoder2DCNN:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNVariationalAutoencoder2DCNN.getPropTag(prop) ' (' NNVariationalAutoencoder2DCNN.getFormatTag(NNVariationalAutoencoder2DCNN.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(nnvae, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 9 % NNVariationalAutoencoder2DCNN.D
					if ~isequal(nnvae.get('D').get('DP_DICT').get('LENGTH'), 0)
					    input_data = cell2mat(nnvae.get('D').get('DP_DICT').get('IT', 1).get('INPUT'));
					    if isequal(length(size(input_data)), 2) % if only 1 channel
					        size_input = [size(input_data) 1]; % force it to be length, width, channel
					    else
					        size_input = size(input_data);
					    end
					    nnvae.set('SIZE_INPUT', size_input);
					end
					
				otherwise
					if prop <= 32
						postset@NNVariationalAutoencoder(nnvae, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(nnvae, prop, varargin)
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
				case 16 % NNVariationalAutoencoder2DCNN.INPUTS
					% inputs = nn.get('inputs', D) returns a cell array with the
					%  inputs for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					inputs_group = d.get('INPUTS');
					if isempty(inputs_group)
					    value = {};
					else
					    [s1, s2] = size(cell2mat(inputs_group{1}));
					    % Extract the h x w arrays from the inner cells
					    flat_cells = cellfun(@(c) c{1}, inputs_group, 'UniformOutput', false);
					    value = reshape(cat(3, flat_cells{:}), s1, s2, 1, []);
					end
					
				case 17 % NNVariationalAutoencoder2DCNN.TARGETS
					% targets = nn.get('PREDICT', D) returns a cell array with the
					%  targets for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					targets_group = d.get('TARGETS');
					if isempty(targets_group)
					    value = {};
					else
					    flat_cells = cellfun(@(c) c{1}, targets_group, 'UniformOutput', false);
					    value = cat(1, flat_cells{:});
					end
					
				case 18 % NNVariationalAutoencoder2DCNN.TRAIN
					% --- Set up ENCODER ---
					% Retrieve hyperparam
					channels = nnvae.get('CHANNELS_PER_LAYER');
					size_filter = nnvae.get('SIZE_FILTER');
					strides = nnvae.get('STRIDE_PER_LAYER');
					numLatentChannels = nnvae.get('NUM_LATENT_REP');
					inputSize = nnvae.get('SIZE_INPUT');
					
					if nnvae.isLocked('ENCODER')
					    value = {};
					    return
					end
					
					% Define layers
					layersE = [
					    imageInputLayer(inputSize, Normalization="none")
					    ];
					for i = 1:length(channels)
					    c = channels(i);
					    s = strides(i);
					    layersE = [
					        layersE
					        convolution2dLayer(size_filter, c, Padding="same", Stride=s)
					        leakyReluLayer(0.2)
					        ];
					end
					layersE = [
					    layersE
					    flattenLayer
					    fullyConnectedLayer(2*numLatentChannels, Name="latentOutput")
					    samplingLayer
					    ];
					nnvae.set('ENCODER', dlnetwork(layersE));
					
					% --- Set up DECODER ---
					% Retrieve decoder hyperparameters (mirroring encoder)
					% Last convolution's output channels = projection depth
					projectChannels = channels(end); 
					s_end = strides(end); % comes from encoder, the last convolutional layer
					num_stride = length(strides);
					projSize = inputSize(1:num_stride);
					for i = 1:num_stride % two strides in 2 layers
					    projSize = ceil(projSize / strides(i));
					end
					projectionSize = [projSize projectChannels];
					numInputChannels = inputSize(3);
					numLatentChannels = nnvae.get('NUM_LATENT_REP');
					
					% Define layers
					layersD = [
					    featureInputLayer(numLatentChannels)
					    fullyConnectedLayer(prod(projectionSize))
					    leakyReluLayer(0.2)
					    projectAndReshapeLayer(projectionSize)
					    ];
					for i = length(channels):-1:1
					    c = channels(i);
					    s = strides(i);
					    layersD = [
					        layersD
					        transposedConv2dLayer(size_filter, c, Cropping="same", Stride=s)
					        leakyReluLayer(0.2)
					        ];
					end
					layersD = [
					    layersD
					    transposedConv2dLayer(size_filter, numInputChannels, Cropping="same")
					    sigmoidLayer
					    ];
					nnvae.set('DECODER', dlnetwork(layersD));
					
					value = calculateValue@NNVariationalAutoencoder(nnvae, prop);
					
				otherwise
					if prop <= 32
						value = calculateValue@NNVariationalAutoencoder(nnvae, prop, varargin{:});
					else
						value = calculateValue@Element(nnvae, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(nnvae, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(nnvae) ' ' nnvae.getPropTag(prop) '.'];
			
			switch prop
				case 9 % NNVariationalAutoencoder2DCNN.D
					check = ismember(value.get('DP_CLASS'), nnvae.get('DP_CLASSES'));
					
				otherwise
					if prop <= 32
						[check, msg] = checkValue@NNVariationalAutoencoder(nnvae, prop, value);
					end
			end
		end
	end
end
