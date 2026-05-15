classdef NNVariationalAutoencoder < NNBase
	%NNVariationalAutoencoder is a neural-network variational autoencoder.
	% It is a subclass of <a href="matlab:help NNBase">NNBase</a>.
	%
	% A neural-network variational autoencoder (NNVariationalAutoencoder) comprises an encoder and a decoder and is trained in an unsupervised manner 
	%  to maximise the evidence lower bound (ELBO). The encoder outputs the parameters of a Gaussian latent distribution (mean μ and log-variance log σ²);
	%  a latent sample z is obtained via the reparameterisation trick and decoded back to the input space. Training minimises a loss function equal to the 
	%  negative ELBO, i.e., a reconstruction term plus a Kullback–Leibler divergence that regularises the approximate posterior towards a standard normal 
	%  prior N(0, I). This element trains on a neural-network dataset (NNDataset).
	% 
	% Instances of this class are not meant to be created directly—use one of its subclasses.
	%
	% The list of NNVariationalAutoencoder properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural-network variational autoencoder.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural-network variational autoencoder.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the neural-network variational autoencoder.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural-network variational autoencoder.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.
	%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.
	%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
	%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs and returns the cell array of inputs from dataset D (format depends on the specific subclass/data point).
	%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs and returns the cell array of targets from dataset D (if applicable).
	%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the variational autoencoder by updating ENCODER and DECODER to minimise LOSS_FN (negative ELBO) using a mini-batch loop.
	%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
	%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
	%  <strong>22</strong> <strong>LEARN_RATE</strong> 	LEARN_RATE (parameter, scalar) is the learning rate for optimisation.
	%  <strong>23</strong> <strong>NUM_LATENT_REP</strong> 	NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).
	%  <strong>24</strong> <strong>SIZE_INPUT</strong> 	SIZE_INPUT (parameter, rvector) is the size of the input data (e.g., [H W C] for images, or feature vector length).
	%  <strong>25</strong> <strong>ITERATION_DIM</strong> 	ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.
	%  <strong>26</strong> <strong>NUM_MBQ_OUTPUT</strong> 	NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).
	%  <strong>27</strong> <strong>MINIBATCH_FORMAT_INPUT</strong> 	MINIBATCH_FORMAT_INPUT (query, string) is a deep learning array (dlarray) label string for input mini-batches (e.g., "SSCB" or "BC"), used by minibatchqueue (MBQ).
	%  <strong>28</strong> <strong>MINIBATCH_FORMAT_TARGET</strong> 	MINIBATCH_FORMAT_TARGET (query, string) is a deep learning array (dlarray) label string for target mini-batches (if used), for minibatchqueue (MBQ).
	%  <strong>29</strong> <strong>ENCODER</strong> 	ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.
	%  <strong>30</strong> <strong>DECODER</strong> 	DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.
	%  <strong>31</strong> <strong>MBQ</strong> 	MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.
	%  <strong>32</strong> <strong>LOSS_FN</strong> 	LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).
	%
	% NNVariationalAutoencoder methods (constructor):
	%  NNVariationalAutoencoder - constructor
	%
	% NNVariationalAutoencoder methods:
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
	% NNVariationalAutoencoder methods (display):
	%  tostring - string with information about the a neural-network variational autoencoder
	%  disp - displays information about the a neural-network variational autoencoder
	%  tree - displays the tree of the a neural-network variational autoencoder
	%
	% NNVariationalAutoencoder methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two a neural-network variational autoencoder are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the a neural-network variational autoencoder
	%
	% NNVariationalAutoencoder methods (save/load, Static):
	%  save - saves BRAPH2 a neural-network variational autoencoder as b2 file
	%  load - loads a BRAPH2 a neural-network variational autoencoder from a b2 file
	%
	% NNVariationalAutoencoder method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the a neural-network variational autoencoder
	%
	% NNVariationalAutoencoder method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the a neural-network variational autoencoder
	%
	% NNVariationalAutoencoder methods (inspection, Static):
	%  getClass - returns the class of the a neural-network variational autoencoder
	%  getSubclasses - returns all subclasses of NNVariationalAutoencoder
	%  getProps - returns the property list of the a neural-network variational autoencoder
	%  getPropNumber - returns the property number of the a neural-network variational autoencoder
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
	% NNVariationalAutoencoder methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNVariationalAutoencoder methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNVariationalAutoencoder methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNVariationalAutoencoder methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNVariationalAutoencoder; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNVariationalAutoencoder constants</a>.
	%
	%
	% See also NNDataset, NNDatasetSplit, NNAutoencoder.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		LEARN_RATE = 22; %CET: Computational Efficiency Trick
		LEARN_RATE_TAG = 'LEARN_RATE';
		LEARN_RATE_CATEGORY = 3;
		LEARN_RATE_FORMAT = 11;
		
		NUM_LATENT_REP = 23; %CET: Computational Efficiency Trick
		NUM_LATENT_REP_TAG = 'NUM_LATENT_REP';
		NUM_LATENT_REP_CATEGORY = 3;
		NUM_LATENT_REP_FORMAT = 11;
		
		SIZE_INPUT = 24; %CET: Computational Efficiency Trick
		SIZE_INPUT_TAG = 'SIZE_INPUT';
		SIZE_INPUT_CATEGORY = 3;
		SIZE_INPUT_FORMAT = 12;
		
		ITERATION_DIM = 25; %CET: Computational Efficiency Trick
		ITERATION_DIM_TAG = 'ITERATION_DIM';
		ITERATION_DIM_CATEGORY = 3;
		ITERATION_DIM_FORMAT = 11;
		
		NUM_MBQ_OUTPUT = 26; %CET: Computational Efficiency Trick
		NUM_MBQ_OUTPUT_TAG = 'NUM_MBQ_OUTPUT';
		NUM_MBQ_OUTPUT_CATEGORY = 3;
		NUM_MBQ_OUTPUT_FORMAT = 11;
		
		MINIBATCH_FORMAT_INPUT = 27; %CET: Computational Efficiency Trick
		MINIBATCH_FORMAT_INPUT_TAG = 'MINIBATCH_FORMAT_INPUT';
		MINIBATCH_FORMAT_INPUT_CATEGORY = 6;
		MINIBATCH_FORMAT_INPUT_FORMAT = 2;
		
		MINIBATCH_FORMAT_TARGET = 28; %CET: Computational Efficiency Trick
		MINIBATCH_FORMAT_TARGET_TAG = 'MINIBATCH_FORMAT_TARGET';
		MINIBATCH_FORMAT_TARGET_CATEGORY = 6;
		MINIBATCH_FORMAT_TARGET_FORMAT = 2;
		
		ENCODER = 29; %CET: Computational Efficiency Trick
		ENCODER_TAG = 'ENCODER';
		ENCODER_CATEGORY = 4;
		ENCODER_FORMAT = 17;
		
		DECODER = 30; %CET: Computational Efficiency Trick
		DECODER_TAG = 'DECODER';
		DECODER_CATEGORY = 4;
		DECODER_FORMAT = 17;
		
		MBQ = 31; %CET: Computational Efficiency Trick
		MBQ_TAG = 'MBQ';
		MBQ_CATEGORY = 6;
		MBQ_FORMAT = 1;
		
		LOSS_FN = 32; %CET: Computational Efficiency Trick
		LOSS_FN_TAG = 'LOSS_FN';
		LOSS_FN_CATEGORY = 6;
		LOSS_FN_FORMAT = 11;
	end
	methods % constructor
		function nnvae = NNVariationalAutoencoder(varargin)
			%NNVariationalAutoencoder() creates a a neural-network variational autoencoder.
			%
			% NNVariationalAutoencoder(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNVariationalAutoencoder(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNVariationalAutoencoder properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural-network variational autoencoder.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural-network variational autoencoder.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the neural-network variational autoencoder.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural-network variational autoencoder.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.
			%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.
			%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
			%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs and returns the cell array of inputs from dataset D (format depends on the specific subclass/data point).
			%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, cell) constructs and returns the cell array of targets from dataset D (if applicable).
			%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) trains the variational autoencoder by updating ENCODER and DECODER to minimise LOSS_FN (negative ELBO) using a mini-batch loop.
			%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
			%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
			%  <strong>22</strong> <strong>LEARN_RATE</strong> 	LEARN_RATE (parameter, scalar) is the learning rate for optimisation.
			%  <strong>23</strong> <strong>NUM_LATENT_REP</strong> 	NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).
			%  <strong>24</strong> <strong>SIZE_INPUT</strong> 	SIZE_INPUT (parameter, rvector) is the size of the input data (e.g., [H W C] for images, or feature vector length).
			%  <strong>25</strong> <strong>ITERATION_DIM</strong> 	ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.
			%  <strong>26</strong> <strong>NUM_MBQ_OUTPUT</strong> 	NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).
			%  <strong>27</strong> <strong>MINIBATCH_FORMAT_INPUT</strong> 	MINIBATCH_FORMAT_INPUT (query, string) is a deep learning array (dlarray) label string for input mini-batches (e.g., "SSCB" or "BC"), used by minibatchqueue (MBQ).
			%  <strong>28</strong> <strong>MINIBATCH_FORMAT_TARGET</strong> 	MINIBATCH_FORMAT_TARGET (query, string) is a deep learning array (dlarray) label string for target mini-batches (if used), for minibatchqueue (MBQ).
			%  <strong>29</strong> <strong>ENCODER</strong> 	ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.
			%  <strong>30</strong> <strong>DECODER</strong> 	DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.
			%  <strong>31</strong> <strong>MBQ</strong> 	MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.
			%  <strong>32</strong> <strong>LOSS_FN</strong> 	LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).
			%
			% See also Category, Format.
			
			nnvae = nnvae@NNBase(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the a neural-network variational autoencoder.
			%
			% BUILD = NNVariationalAutoencoder.GETBUILD() returns the build of 'NNVariationalAutoencoder'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNVAE.GETBUILD() returns the build of the a neural-network variational autoencoder NNVAE.
			%  BUILD = Element.GETBUILD(NNVAE) returns the build of 'NNVAE'.
			%  BUILD = Element.GETBUILD('NNVariationalAutoencoder') returns the build of 'NNVariationalAutoencoder'.
			%
			% Note that the Element.GETBUILD(NNVAE) and Element.GETBUILD('NNVariationalAutoencoder')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnvae_class = getClass()
			%GETCLASS returns the class of the a neural-network variational autoencoder.
			%
			% CLASS = NNVariationalAutoencoder.GETCLASS() returns the class 'NNVariationalAutoencoder'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNVAE.GETCLASS() returns the class of the a neural-network variational autoencoder NNVAE.
			%  CLASS = Element.GETCLASS(NNVAE) returns the class of 'NNVAE'.
			%  CLASS = Element.GETCLASS('NNVariationalAutoencoder') returns 'NNVariationalAutoencoder'.
			%
			% Note that the Element.GETCLASS(NNVAE) and Element.GETCLASS('NNVariationalAutoencoder')
			%  are less computationally efficient.
			
			nnvae_class = 'NNVariationalAutoencoder';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the a neural-network variational autoencoder.
			%
			% LIST = NNVariationalAutoencoder.GETSUBCLASSES() returns all subclasses of 'NNVariationalAutoencoder'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNVAE.GETSUBCLASSES() returns all subclasses of the a neural-network variational autoencoder NNVAE.
			%  LIST = Element.GETSUBCLASSES(NNVAE) returns all subclasses of 'NNVAE'.
			%  LIST = Element.GETSUBCLASSES('NNVariationalAutoencoder') returns all subclasses of 'NNVariationalAutoencoder'.
			%
			% Note that the Element.GETSUBCLASSES(NNVAE) and Element.GETSUBCLASSES('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNVariationalAutoencoder'  'NNVariationalAutoencoder2DCNN'  'NNVariationalAutoencoderMLP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of a neural-network variational autoencoder.
			%
			% PROPS = NNVariationalAutoencoder.GETPROPS() returns the property list of a neural-network variational autoencoder
			%  as a row vector.
			%
			% PROPS = NNVariationalAutoencoder.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNVAE.GETPROPS([CATEGORY]) returns the property list of the a neural-network variational autoencoder NNVAE.
			%  PROPS = Element.GETPROPS(NNVAE[, CATEGORY]) returns the property list of 'NNVAE'.
			%  PROPS = Element.GETPROPS('NNVariationalAutoencoder'[, CATEGORY]) returns the property list of 'NNVariationalAutoencoder'.
			%
			% Note that the Element.GETPROPS(NNVAE) and Element.GETPROPS('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 20];
				case 3 % Category.PARAMETER
					prop_list = [4 10 11 12 13 14 22 23 24 25 26];
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
			%GETPROPNUMBER returns the property number of a neural-network variational autoencoder.
			%
			% N = NNVariationalAutoencoder.GETPROPNUMBER() returns the property number of a neural-network variational autoencoder.
			%
			% N = NNVariationalAutoencoder.GETPROPNUMBER(CATEGORY) returns the property number of a neural-network variational autoencoder
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNVAE.GETPROPNUMBER([CATEGORY]) returns the property number of the a neural-network variational autoencoder NNVAE.
			%  N = Element.GETPROPNUMBER(NNVAE) returns the property number of 'NNVAE'.
			%  N = Element.GETPROPNUMBER('NNVariationalAutoencoder') returns the property number of 'NNVariationalAutoencoder'.
			%
			% Note that the Element.GETPROPNUMBER(NNVAE) and Element.GETPROPNUMBER('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 32;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 11;
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
			%EXISTSPROP checks whether property exists in a neural-network variational autoencoder/error.
			%
			% CHECK = NNVariationalAutoencoder.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNVAE.EXISTSPROP(PROP) checks whether PROP exists for NNVAE.
			%  CHECK = Element.EXISTSPROP(NNVAE, PROP) checks whether PROP exists for NNVAE.
			%  CHECK = Element.EXISTSPROP(NNVariationalAutoencoder, PROP) checks whether PROP exists for NNVariationalAutoencoder.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNVAE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%  Element.EXISTSPROP(NNVAE, PROP) throws error if PROP does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%  Element.EXISTSPROP(NNVariationalAutoencoder, PROP) throws error if PROP does NOT exist for NNVariationalAutoencoder.
			%   Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNVAE) and Element.EXISTSPROP('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 32 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoder:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoder:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNVariationalAutoencoder.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in a neural-network variational autoencoder/error.
			%
			% CHECK = NNVariationalAutoencoder.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNVAE.EXISTSTAG(TAG) checks whether TAG exists for NNVAE.
			%  CHECK = Element.EXISTSTAG(NNVAE, TAG) checks whether TAG exists for NNVAE.
			%  CHECK = Element.EXISTSTAG(NNVariationalAutoencoder, TAG) checks whether TAG exists for NNVariationalAutoencoder.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNVAE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%  Element.EXISTSTAG(NNVAE, TAG) throws error if TAG does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%  Element.EXISTSTAG(NNVariationalAutoencoder, TAG) throws error if TAG does NOT exist for NNVariationalAutoencoder.
			%   Error id: [BRAPH2:NNVariationalAutoencoder:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNVAE) and Element.EXISTSTAG('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoder:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoder:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNVariationalAutoencoder.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNVariationalAutoencoder, POINTER) returns property number of POINTER of NNVariationalAutoencoder.
			%  PROPERTY = NNVAE.GETPROPPROP(NNVariationalAutoencoder, POINTER) returns property number of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPPROP(NNVAE) and Element.GETPROPPROP('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNVariationalAutoencoder, POINTER) returns tag of POINTER of NNVariationalAutoencoder.
			%  TAG = NNVAE.GETPROPTAG(NNVariationalAutoencoder, POINTER) returns tag of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPTAG(NNVAE) and Element.GETPROPTAG('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnvariationalautoencoder_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN' };
				tag = nnvariationalautoencoder_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNVariationalAutoencoder, POINTER) returns category of POINTER of NNVariationalAutoencoder.
			%  CATEGORY = NNVAE.GETPROPCATEGORY(NNVariationalAutoencoder, POINTER) returns category of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPCATEGORY(NNVAE) and Element.GETPROPCATEGORY('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoder_category_list = { 1  1  1  3  4  2  2  6  4  3  3  3  3  3  5  6  6  6  9  2  6  3  3  3  3  3  6  6  4  4  6  6 };
			prop_category = nnvariationalautoencoder_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNVariationalAutoencoder, POINTER) returns format of POINTER of NNVariationalAutoencoder.
			%  FORMAT = NNVAE.GETPROPFORMAT(NNVariationalAutoencoder, POINTER) returns format of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPFORMAT(NNVAE) and Element.GETPROPFORMAT('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoder_format_list = { 2  2  2  8  2  2  2  2  8  7  11  11  5  5  17  16  16  1  4  5  16  11  11  12  11  11  2  2  17  17  1  11 };
			prop_format = nnvariationalautoencoder_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNVariationalAutoencoder, POINTER) returns description of POINTER of NNVariationalAutoencoder.
			%  DESCRIPTION = NNVAE.GETPROPDESCRIPTION(NNVariationalAutoencoder, POINTER) returns description of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNVAE) and Element.GETPROPDESCRIPTION('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencoder_description_list = { 'ELCLASS (constant, string) is the class of the neural-network variational autoencoder.'  'NAME (constant, string) is the name of the neural-network variational autoencoder.'  'DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder.'  'TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder.'  'ID (data, string) is a few-letter code of the neural-network variational autoencoder.'  'LABEL (metadata, string) is an extended label of the neural-network variational autoencoder.'  'NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.'  'DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'MODEL (result, net) is a trained neural network model with the given dataset.'  'INPUTS (query, cell) constructs and returns the cell array of inputs from dataset D (format depends on the specific subclass/data point).'  'TARGETS (query, cell) constructs and returns the cell array of targets from dataset D (if applicable).'  'TRAIN (query, empty) trains the variational autoencoder by updating ENCODER and DECODER to minimise LOSS_FN (negative ELBO) using a mini-batch loop.'  'VERBOSE (gui, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.'  'LEARN_RATE (parameter, scalar) is the learning rate for optimisation.'  'NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).'  'SIZE_INPUT (parameter, rvector) is the size of the input data (e.g., [H W C] for images, or feature vector length).'  'ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.'  'NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).'  'MINIBATCH_FORMAT_INPUT (query, string) is a deep learning array (dlarray) label string for input mini-batches (e.g., "SSCB" or "BC"), used by minibatchqueue (MBQ).'  'MINIBATCH_FORMAT_TARGET (query, string) is a deep learning array (dlarray) label string for target mini-batches (if used), for minibatchqueue (MBQ).'  'ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.'  'DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.'  'MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.'  'LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).' };
			prop_description = nnvariationalautoencoder_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNVariationalAutoencoder, POINTER) returns settings of POINTER of NNVariationalAutoencoder.
			%  SETTINGS = NNVAE.GETPROPSETTINGS(NNVariationalAutoencoder, POINTER) returns settings of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPSETTINGS(NNVAE) and Element.GETPROPSETTINGS('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoder.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 22 % NNVariationalAutoencoder.LEARN_RATE
					prop_settings = Format.getFormatSettings(11);
				case 23 % NNVariationalAutoencoder.NUM_LATENT_REP
					prop_settings = Format.getFormatSettings(11);
				case 24 % NNVariationalAutoencoder.SIZE_INPUT
					prop_settings = Format.getFormatSettings(12);
				case 25 % NNVariationalAutoencoder.ITERATION_DIM
					prop_settings = Format.getFormatSettings(11);
				case 26 % NNVariationalAutoencoder.NUM_MBQ_OUTPUT
					prop_settings = Format.getFormatSettings(11);
				case 27 % NNVariationalAutoencoder.MINIBATCH_FORMAT_INPUT
					prop_settings = Format.getFormatSettings(2);
				case 28 % NNVariationalAutoencoder.MINIBATCH_FORMAT_TARGET
					prop_settings = Format.getFormatSettings(2);
				case 29 % NNVariationalAutoencoder.ENCODER
					prop_settings = Format.getFormatSettings(17);
				case 30 % NNVariationalAutoencoder.DECODER
					prop_settings = Format.getFormatSettings(17);
				case 31 % NNVariationalAutoencoder.MBQ
					prop_settings = Format.getFormatSettings(1);
				case 32 % NNVariationalAutoencoder.LOSS_FN
					prop_settings = Format.getFormatSettings(11);
				case 4 % NNVariationalAutoencoder.TEMPLATE
					prop_settings = 'NNVariationalAutoencoder';
				case 9 % NNVariationalAutoencoder.D
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@NNBase(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoder.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoder.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNVAE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNVAE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNVariationalAutoencoder, POINTER) returns the default value of POINTER of NNVariationalAutoencoder.
			%  DEFAULT = NNVAE.GETPROPDEFAULT(NNVariationalAutoencoder, POINTER) returns the default value of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPDEFAULT(NNVAE) and Element.GETPROPDEFAULT('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNVariationalAutoencoder.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 22 % NNVariationalAutoencoder.LEARN_RATE
					prop_default = 1e-3;
				case 23 % NNVariationalAutoencoder.NUM_LATENT_REP
					prop_default = 2;
				case 24 % NNVariationalAutoencoder.SIZE_INPUT
					prop_default = Format.getFormatDefault(12, NNVariationalAutoencoder.getPropSettings(prop));
				case 25 % NNVariationalAutoencoder.ITERATION_DIM
					prop_default = Format.getFormatDefault(11, NNVariationalAutoencoder.getPropSettings(prop));
				case 26 % NNVariationalAutoencoder.NUM_MBQ_OUTPUT
					prop_default = 2;
				case 27 % NNVariationalAutoencoder.MINIBATCH_FORMAT_INPUT
					prop_default = Format.getFormatDefault(2, NNVariationalAutoencoder.getPropSettings(prop));
				case 28 % NNVariationalAutoencoder.MINIBATCH_FORMAT_TARGET
					prop_default = Format.getFormatDefault(2, NNVariationalAutoencoder.getPropSettings(prop));
				case 29 % NNVariationalAutoencoder.ENCODER
					prop_default = Format.getFormatDefault(17, NNVariationalAutoencoder.getPropSettings(prop));
				case 30 % NNVariationalAutoencoder.DECODER
					prop_default = Format.getFormatDefault(17, NNVariationalAutoencoder.getPropSettings(prop));
				case 31 % NNVariationalAutoencoder.MBQ
					prop_default = Format.getFormatDefault(1, NNVariationalAutoencoder.getPropSettings(prop));
				case 32 % NNVariationalAutoencoder.LOSS_FN
					prop_default = Format.getFormatDefault(11, NNVariationalAutoencoder.getPropSettings(prop));
				case 1 % NNVariationalAutoencoder.ELCLASS
					prop_default = 'NNVariationalAutoencoder';
				case 2 % NNVariationalAutoencoder.NAME
					prop_default = 'Neural-Network Variational Autoencoder';
				case 3 % NNVariationalAutoencoder.DESCRIPTION
					prop_default = 'A neural-network variational autoencoder (NNVariationalAutoencoder) comprises an encoder and a decoder and is trained in an unsupervised manner to maximise the ELBO. The encoder outputs mean μ and log-variance log σ²; a latent sample is obtained via the reparameterisation trick and decoded back to the input space. The loss is the negative ELBO (reconstruction + KL to N(0, I)). This element trains on a neural-network dataset (NNDataset). Instances of this class are not meant to be created directly—use one of its subclasses.';
				case 4 % NNVariationalAutoencoder.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNVariationalAutoencoder.getPropSettings(prop));
				case 5 % NNVariationalAutoencoder.ID
					prop_default = 'NNVariationalAutoencoder ID';
				case 6 % NNVariationalAutoencoder.LABEL
					prop_default = 'NNVariationalAutoencoder label';
				case 7 % NNVariationalAutoencoder.NOTES
					prop_default = 'NNVariationalAutoencoder notes';
				case 9 % NNVariationalAutoencoder.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint');
				case 10 % NNVariationalAutoencoder.DP_CLASSES
					prop_default = {'NNDataPoint'};
				otherwise
					prop_default = getPropDefault@NNBase(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoder.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoder.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNVAE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNVAE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoder, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoder.
			%  DEFAULT = NNVAE.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoder, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoder.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNVAE) and Element.GETPROPDEFAULTCONDITIONED('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNVariationalAutoencoder.getPropProp(pointer);
			
			prop_default = NNVariationalAutoencoder.conditioning(prop, NNVariationalAutoencoder.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNVariationalAutoencoder, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoder.
			%  CHECK = NNVAE.CHECKPROP(NNVariationalAutoencoder, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoder.
			% 
			% NNVAE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNVariationalAutoencoder:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNVAE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNVAE.
			%   Error id: BRAPH2:NNVariationalAutoencoder:WrongInput
			%  Element.CHECKPROP(NNVariationalAutoencoder, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoder.
			%   Error id: BRAPH2:NNVariationalAutoencoder:WrongInput
			%  NNVAE.CHECKPROP(NNVariationalAutoencoder, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoder.
			%   Error id: BRAPH2:NNVariationalAutoencoder:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNVAE) and Element.CHECKPROP('NNVariationalAutoencoder')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNVariationalAutoencoder.getPropProp(pointer);
			
			switch prop
				case 22 % NNVariationalAutoencoder.LEARN_RATE
					check = Format.checkFormat(11, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 23 % NNVariationalAutoencoder.NUM_LATENT_REP
					check = Format.checkFormat(11, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 24 % NNVariationalAutoencoder.SIZE_INPUT
					check = Format.checkFormat(12, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 25 % NNVariationalAutoencoder.ITERATION_DIM
					check = Format.checkFormat(11, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 26 % NNVariationalAutoencoder.NUM_MBQ_OUTPUT
					check = Format.checkFormat(11, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 27 % NNVariationalAutoencoder.MINIBATCH_FORMAT_INPUT
					check = Format.checkFormat(2, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 28 % NNVariationalAutoencoder.MINIBATCH_FORMAT_TARGET
					check = Format.checkFormat(2, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 29 % NNVariationalAutoencoder.ENCODER
					check = Format.checkFormat(17, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 30 % NNVariationalAutoencoder.DECODER
					check = Format.checkFormat(17, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 31 % NNVariationalAutoencoder.MBQ
					check = Format.checkFormat(1, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 32 % NNVariationalAutoencoder.LOSS_FN
					check = Format.checkFormat(11, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 4 % NNVariationalAutoencoder.TEMPLATE
					check = Format.checkFormat(8, value, NNVariationalAutoencoder.getPropSettings(prop));
				case 9 % NNVariationalAutoencoder.D
					check = Format.checkFormat(8, value, NNVariationalAutoencoder.getPropSettings(prop));
				otherwise
					if prop <= 21
						check = checkProp@NNBase(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoder:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoder:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNVariationalAutoencoder.getPropTag(prop) ' (' NNVariationalAutoencoder.getFormatTag(NNVariationalAutoencoder.getPropFormat(prop)) ').'] ...
					)
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
				case 31 % NNVariationalAutoencoder.MBQ
					% targets = nn.get('PREDICT', D) returns a cell array with the
					%  targets for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					num_dp = d.get('DP_DICT').get('LENGTH');
					
					num_outputs = nnvae.get('NUM_MBQ_OUTPUT');
					itr = nnvae.get('ITERATION_DIM');
					format_input = string(nnvae.get('MINIBATCH_FORMAT_INPUT'));
					format_target = string(nnvae.get('MINIBATCH_FORMAT_TARGET'));
					if length(varargin) > 1
					    miniBatchSize = varargin{2};
					else
					    miniBatchSize = nnvae.get('BATCH');
					end
					
					XTrain = nnvae.get('INPUTS', d);
					%YTrain = categorical(nnvae.get('TARGETS', d));
					YTrain = 1:1:num_dp;
					YTrain = YTrain';
					
					dsXTrain = arrayDatastore(XTrain, IterationDimension=itr);
					dsYTrain = arrayDatastore(YTrain);
					dsTrain = combine(dsXTrain, dsYTrain);
					
					value = minibatchqueue(dsTrain, num_outputs, ...
					    MiniBatchSize = miniBatchSize, ...
					    MiniBatchFcn = @preprocess_minibatch, ...
					    MiniBatchFormat = [format_input, format_target], ...
					    PartialMiniBatch = "discard");
					
				case 32 % NNVariationalAutoencoder.LOSS_FN
					if length(varargin) < 4
					    value = 0;
					    return
					end
					y = varargin{1};
					t = varargin{2};
					mu = varargin{3};
					logSigmaSq = varargin{4};
					
					% Reconstruction loss (e.g., mean-squared error between output y and input t).
					reconstructionLoss = mse(y, t);
					
					% KL divergence KL(q(z|x) || N(0, I)).
					KL = -1/2 * sum(1 + logSigmaSq - mu.^2 - exp(logSigmaSq),1);
					KL = mean(KL);
					
					% Negative ELBO = reconstruction + KL.
					value = reconstructionLoss + KL;
					
				case 18 % NNVariationalAutoencoder.TRAIN
					numEpochs = nnvae.get('EPOCHS');
					miniBatchSize = nnvae.get('BATCH');
					learnRate = nnvae.get('LEARN_RATE');
					
					d = nnvae.get('D');
					if isequal(d.get('DP_DICT').get('LENGTH'), 0)
					    value = [];
					    return
					end
					
					mbq = nnvae.get('MBQ', d);
					netE = nnvae.get('ENCODER');
					netD = nnvae.get('DECODER');
					
					trailingAvgE = [];
					trailingAvgSqE = [];
					trailingAvgD = [];
					trailingAvgSqD = [];
					
					numObservationsTrain = d.get('DP_DICT').get('LENGTH');
					numIterationsPerEpoch = ceil(numObservationsTrain / miniBatchSize);
					numIterations = numEpochs * numIterationsPerEpoch;
					
					monitor = trainingProgressMonitor( ...
					    Metrics = "Loss", ...
					    Info = "Epoch", ...
					    XLabel = "Iteration");
					
					epoch = 0;
					iteration = 0;
					
					% Loop over epochs.
					while epoch < numEpochs && ~monitor.Stop
					    epoch = epoch + 1;
					
					    % Shuffle data.
					    shuffle(mbq);
					
					    % Loop over mini-batches.
					    while hasdata(mbq) && ~monitor.Stop
					        iteration = iteration + 1;
					
					        % Read mini-batch of data.
					        [X, Y] = next(mbq);
					
					        % Evaluate loss and gradients.
					        [loss, gradientsE, gradientsD] = dlfeval(@model_loss, netE, netD, X);
					
					        % Update learnable parameters.
					        [netE, trailingAvgE, trailingAvgSqE] = adamupdate(netE, ...
					            gradientsE, trailingAvgE, trailingAvgSqE, iteration, learnRate);
					
					        [netD, trailingAvgD, trailingAvgSqD] = adamupdate(netD, ...
					            gradientsD, trailingAvgD, trailingAvgSqD, iteration, learnRate);
					
					        % Update the training progress monitor. 
					        recordMetrics(monitor, iteration, Loss=loss);
					        updateInfo(monitor, Epoch=epoch + " of " + numEpochs);
					        monitor.Progress = 100 * iteration/numIterations;
					    end
					end
					
					nnvae.set('ENCODER', netE);
					nnvae.set('DECODER', netD);
					nnvae.get('MODEL'); % to lock this element
					
					value = {};
					
				otherwise
					if prop <= 21
						value = calculateValue@NNBase(nnvae, prop, varargin{:});
					else
						value = calculateValue@Element(nnvae, prop, varargin{:});
					end
			end
			
			function [X, Y] = preprocess_minibatch(XCell, YCell)
			    % Concatenate along the iteration dimension.
			    itr = nnvae.get('ITERATION_DIM');
			    X = cat(itr, XCell{:});
			    
			    % Extract label data from cell and concatenate.
			    Y = cat(2, YCell{:});
			end
			function [loss, gradientsE, gradientsD] = model_loss(netE, netD, X)
			% Computes the negative ELBO and its gradients w.r.t. ENCODER and DECODER (reconstruction + KL).
			    
			    % Forward through encoder: return latent sample and its Gaussian params.
			    [Z, mu, logSigmaSq] = forward(netE, X);
			    
			    % Forward through decoder.
			    Y = forward(netD, Z);
			    
			    % Calculate loss and gradients (negative ELBO).
			    loss = nnvae.get('LOSS_FN', Y, X, mu, logSigmaSq);
			    [gradientsE, gradientsD] = dlgradient(loss, netE.Learnables, netD.Learnables);
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
				case 9 % NNVariationalAutoencoder.D
					check = ismember(value.get('DP_CLASS'), nnvae.get('DP_CLASSES'));
					
				otherwise
					if prop <= 21
						[check, msg] = checkValue@NNBase(nnvae, prop, value);
					end
			end
		end
	end
end
