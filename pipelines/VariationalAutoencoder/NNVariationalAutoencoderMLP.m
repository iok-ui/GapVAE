classdef NNVariationalAutoencoderMLP < NNVariationalAutoencoder
	%NNVariationalAutoencoderMLP is a neural-network variational autoencoder with a multilayer perceptron (MLP) encoder/decoder.
	% It is a subclass of <a href="matlab:help NNVariationalAutoencoder">NNVariationalAutoencoder</a>.
	%
	% A neural-network variational autoencoder with a multilayer perceptron backbone (NNVariationalAutoencoderMLP) comprises an encoder and a decoder and is trained in an unsupervised manner to maximise the evidence lower bound (ELBO).
	%  The encoder outputs the parameters of a Gaussian latent distribution (mean μ and log-variance log σ²); a latent sample z is obtained via the reparameterisation trick and decoded back to the input space.
	%  Training minimises the negative ELBO, i.e., a reconstruction term plus a Kullback–Leibler divergence that regularises the approximate posterior towards a standard normal prior N(0, I).
	%  This subclass uses a multilayer perceptron (MLP) as the encoder/decoder backbone and trains on a neural-network dataset (NNDataset).
	%
	% The list of NNVariationalAutoencoderMLP properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural-network variational autoencoder (MLP).
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural-network variational autoencoder (MLP).
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder (MLP).
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder (MLP).
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the neural-network variational autoencoder (MLP).
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural-network variational autoencoder (MLP).
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder (MLP).
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.
	%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.
	%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
	%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
	%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
	%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
	%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
	%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs and returns the input matrix from dataset D by flattening each input to length SIZE_INPUT and stacking column-wise.
	%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, stringlist) constructs and returns the targets from dataset D (if applicable).
	%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) configures an MLP encoder/decoder and then trains via the superclass to minimise LOSS_FN (negative ELBO) using a mini-batch loop.
	%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
	%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
	%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
	%  <strong>22</strong> <strong>LEARN_RATE</strong> 	LEARN_RATE (parameter, scalar) is the learning rate for optimisation.
	%  <strong>23</strong> <strong>NUM_LATENT_REP</strong> 	NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).
	%  <strong>24</strong> <strong>SIZE_INPUT</strong> 	SIZE_INPUT (parameter, rvector) is the size of the input data once flattened (scalar number of features).
	%  <strong>25</strong> <strong>ITERATION_DIM</strong> 	ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.
	%  <strong>26</strong> <strong>NUM_MBQ_OUTPUT</strong> 	NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).
	%  <strong>27</strong> <strong>MINIBATCH_FORMAT_INPUT</strong> 	MINIBATCH_FORMAT_INPUT (query, string) is a dlarray label string for input mini-batches (e.g., "CB"), used by minibatchqueue (MBQ).
	%  <strong>28</strong> <strong>MINIBATCH_FORMAT_TARGET</strong> 	MINIBATCH_FORMAT_TARGET (query, string) is a dlarray label string for target mini-batches (may be empty), used by minibatchqueue (MBQ).
	%  <strong>29</strong> <strong>ENCODER</strong> 	ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.
	%  <strong>30</strong> <strong>DECODER</strong> 	DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.
	%  <strong>31</strong> <strong>MBQ</strong> 	MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.
	%  <strong>32</strong> <strong>LOSS_FN</strong> 	LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).
	%  <strong>33</strong> <strong>NEURONS_PER_LAYER</strong> 	NEURONS_PER_LAYER (parameter, rvector) are the hidden-layer widths for the MLP encoder/decoder (mirrored in the decoder).
	%
	% NNVariationalAutoencoderMLP methods (constructor):
	%  NNVariationalAutoencoderMLP - constructor
	%
	% NNVariationalAutoencoderMLP methods:
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
	% NNVariationalAutoencoderMLP methods (display):
	%  tostring - string with information about the a neural-network variational autoencoder with a multilayer perceptron backbone
	%  disp - displays information about the a neural-network variational autoencoder with a multilayer perceptron backbone
	%  tree - displays the tree of the a neural-network variational autoencoder with a multilayer perceptron backbone
	%
	% NNVariationalAutoencoderMLP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two a neural-network variational autoencoder with a multilayer perceptron backbone are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the a neural-network variational autoencoder with a multilayer perceptron backbone
	%
	% NNVariationalAutoencoderMLP methods (save/load, Static):
	%  save - saves BRAPH2 a neural-network variational autoencoder with a multilayer perceptron backbone as b2 file
	%  load - loads a BRAPH2 a neural-network variational autoencoder with a multilayer perceptron backbone from a b2 file
	%
	% NNVariationalAutoencoderMLP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the a neural-network variational autoencoder with a multilayer perceptron backbone
	%
	% NNVariationalAutoencoderMLP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the a neural-network variational autoencoder with a multilayer perceptron backbone
	%
	% NNVariationalAutoencoderMLP methods (inspection, Static):
	%  getClass - returns the class of the a neural-network variational autoencoder with a multilayer perceptron backbone
	%  getSubclasses - returns all subclasses of NNVariationalAutoencoderMLP
	%  getProps - returns the property list of the a neural-network variational autoencoder with a multilayer perceptron backbone
	%  getPropNumber - returns the property number of the a neural-network variational autoencoder with a multilayer perceptron backbone
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
	% NNVariationalAutoencoderMLP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNVariationalAutoencoderMLP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNVariationalAutoencoderMLP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNVariationalAutoencoderMLP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNVariationalAutoencoderMLP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNVariationalAutoencoderMLP constants</a>.
	%
	%
	% See also NNDataset, NNDatasetSplit, NNVariationalAutoencoder, NNAutoencoder.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		NEURONS_PER_LAYER = 33; %CET: Computational Efficiency Trick
		NEURONS_PER_LAYER_TAG = 'NEURONS_PER_LAYER';
		NEURONS_PER_LAYER_CATEGORY = 3;
		NEURONS_PER_LAYER_FORMAT = 12;
	end
	methods % constructor
		function nnvae = NNVariationalAutoencoderMLP(varargin)
			%NNVariationalAutoencoderMLP() creates a a neural-network variational autoencoder with a multilayer perceptron backbone.
			%
			% NNVariationalAutoencoderMLP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNVariationalAutoencoderMLP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNVariationalAutoencoderMLP properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the neural-network variational autoencoder (MLP).
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the neural-network variational autoencoder (MLP).
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder (MLP).
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder (MLP).
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the neural-network variational autoencoder (MLP).
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the neural-network variational autoencoder (MLP).
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder (MLP).
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.
			%  <strong>10</strong> <strong>DP_CLASSES</strong> 	DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.
			%  <strong>11</strong> <strong>EPOCHS</strong> 	EPOCHS (parameter, scalar) is the maximum number of epochs.
			%  <strong>12</strong> <strong>BATCH</strong> 	BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.
			%  <strong>13</strong> <strong>SHUFFLE</strong> 	SHUFFLE (parameter, option) is an option for data shuffling.
			%  <strong>14</strong> <strong>SOLVER</strong> 	SOLVER (parameter, option) is an option for the solver.
			%  <strong>15</strong> <strong>MODEL</strong> 	MODEL (result, net) is a trained neural network model with the given dataset.
			%  <strong>16</strong> <strong>INPUTS</strong> 	INPUTS (query, cell) constructs and returns the input matrix from dataset D by flattening each input to length SIZE_INPUT and stacking column-wise.
			%  <strong>17</strong> <strong>TARGETS</strong> 	TARGETS (query, stringlist) constructs and returns the targets from dataset D (if applicable).
			%  <strong>18</strong> <strong>TRAIN</strong> 	TRAIN (query, empty) configures an MLP encoder/decoder and then trains via the superclass to minimise LOSS_FN (negative ELBO) using a mini-batch loop.
			%  <strong>19</strong> <strong>VERBOSE</strong> 	VERBOSE (gui, logical) is an indicator to display training progress information.
			%  <strong>20</strong> <strong>PLOT_TRAINING</strong> 	PLOT_TRAINING (metadata, option) determines whether to plot the training progress.
			%  <strong>21</strong> <strong>PREDICT</strong> 	PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.
			%  <strong>22</strong> <strong>LEARN_RATE</strong> 	LEARN_RATE (parameter, scalar) is the learning rate for optimisation.
			%  <strong>23</strong> <strong>NUM_LATENT_REP</strong> 	NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).
			%  <strong>24</strong> <strong>SIZE_INPUT</strong> 	SIZE_INPUT (parameter, rvector) is the size of the input data once flattened (scalar number of features).
			%  <strong>25</strong> <strong>ITERATION_DIM</strong> 	ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.
			%  <strong>26</strong> <strong>NUM_MBQ_OUTPUT</strong> 	NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).
			%  <strong>27</strong> <strong>MINIBATCH_FORMAT_INPUT</strong> 	MINIBATCH_FORMAT_INPUT (query, string) is a dlarray label string for input mini-batches (e.g., "CB"), used by minibatchqueue (MBQ).
			%  <strong>28</strong> <strong>MINIBATCH_FORMAT_TARGET</strong> 	MINIBATCH_FORMAT_TARGET (query, string) is a dlarray label string for target mini-batches (may be empty), used by minibatchqueue (MBQ).
			%  <strong>29</strong> <strong>ENCODER</strong> 	ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.
			%  <strong>30</strong> <strong>DECODER</strong> 	DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.
			%  <strong>31</strong> <strong>MBQ</strong> 	MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.
			%  <strong>32</strong> <strong>LOSS_FN</strong> 	LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).
			%  <strong>33</strong> <strong>NEURONS_PER_LAYER</strong> 	NEURONS_PER_LAYER (parameter, rvector) are the hidden-layer widths for the MLP encoder/decoder (mirrored in the decoder).
			%
			% See also Category, Format.
			
			nnvae = nnvae@NNVariationalAutoencoder(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the a neural-network variational autoencoder with a multilayer perceptron backbone.
			%
			% BUILD = NNVariationalAutoencoderMLP.GETBUILD() returns the build of 'NNVariationalAutoencoderMLP'.
			%
			% Alternative forms to call this method are:
			%  BUILD = NNVAE.GETBUILD() returns the build of the a neural-network variational autoencoder with a multilayer perceptron backbone NNVAE.
			%  BUILD = Element.GETBUILD(NNVAE) returns the build of 'NNVAE'.
			%  BUILD = Element.GETBUILD('NNVariationalAutoencoderMLP') returns the build of 'NNVariationalAutoencoderMLP'.
			%
			% Note that the Element.GETBUILD(NNVAE) and Element.GETBUILD('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			
			build = 1;
		end
		function nnvae_class = getClass()
			%GETCLASS returns the class of the a neural-network variational autoencoder with a multilayer perceptron backbone.
			%
			% CLASS = NNVariationalAutoencoderMLP.GETCLASS() returns the class 'NNVariationalAutoencoderMLP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNVAE.GETCLASS() returns the class of the a neural-network variational autoencoder with a multilayer perceptron backbone NNVAE.
			%  CLASS = Element.GETCLASS(NNVAE) returns the class of 'NNVAE'.
			%  CLASS = Element.GETCLASS('NNVariationalAutoencoderMLP') returns 'NNVariationalAutoencoderMLP'.
			%
			% Note that the Element.GETCLASS(NNVAE) and Element.GETCLASS('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			
			nnvae_class = 'NNVariationalAutoencoderMLP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the a neural-network variational autoencoder with a multilayer perceptron backbone.
			%
			% LIST = NNVariationalAutoencoderMLP.GETSUBCLASSES() returns all subclasses of 'NNVariationalAutoencoderMLP'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNVAE.GETSUBCLASSES() returns all subclasses of the a neural-network variational autoencoder with a multilayer perceptron backbone NNVAE.
			%  LIST = Element.GETSUBCLASSES(NNVAE) returns all subclasses of 'NNVAE'.
			%  LIST = Element.GETSUBCLASSES('NNVariationalAutoencoderMLP') returns all subclasses of 'NNVariationalAutoencoderMLP'.
			%
			% Note that the Element.GETSUBCLASSES(NNVAE) and Element.GETSUBCLASSES('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNVariationalAutoencoderMLP' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of a neural-network variational autoencoder with a multilayer perceptron backbone.
			%
			% PROPS = NNVariationalAutoencoderMLP.GETPROPS() returns the property list of a neural-network variational autoencoder with a multilayer perceptron backbone
			%  as a row vector.
			%
			% PROPS = NNVariationalAutoencoderMLP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNVAE.GETPROPS([CATEGORY]) returns the property list of the a neural-network variational autoencoder with a multilayer perceptron backbone NNVAE.
			%  PROPS = Element.GETPROPS(NNVAE[, CATEGORY]) returns the property list of 'NNVAE'.
			%  PROPS = Element.GETPROPS('NNVariationalAutoencoderMLP'[, CATEGORY]) returns the property list of 'NNVariationalAutoencoderMLP'.
			%
			% Note that the Element.GETPROPS(NNVAE) and Element.GETPROPS('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 20];
				case 3 % Category.PARAMETER
					prop_list = [4 10 11 12 13 14 22 23 24 25 26 33];
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
			%GETPROPNUMBER returns the property number of a neural-network variational autoencoder with a multilayer perceptron backbone.
			%
			% N = NNVariationalAutoencoderMLP.GETPROPNUMBER() returns the property number of a neural-network variational autoencoder with a multilayer perceptron backbone.
			%
			% N = NNVariationalAutoencoderMLP.GETPROPNUMBER(CATEGORY) returns the property number of a neural-network variational autoencoder with a multilayer perceptron backbone
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNVAE.GETPROPNUMBER([CATEGORY]) returns the property number of the a neural-network variational autoencoder with a multilayer perceptron backbone NNVAE.
			%  N = Element.GETPROPNUMBER(NNVAE) returns the property number of 'NNVAE'.
			%  N = Element.GETPROPNUMBER('NNVariationalAutoencoderMLP') returns the property number of 'NNVariationalAutoencoderMLP'.
			%
			% Note that the Element.GETPROPNUMBER(NNVAE) and Element.GETPROPNUMBER('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 33;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 12;
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
			%EXISTSPROP checks whether property exists in a neural-network variational autoencoder with a multilayer perceptron backbone/error.
			%
			% CHECK = NNVariationalAutoencoderMLP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNVAE.EXISTSPROP(PROP) checks whether PROP exists for NNVAE.
			%  CHECK = Element.EXISTSPROP(NNVAE, PROP) checks whether PROP exists for NNVAE.
			%  CHECK = Element.EXISTSPROP(NNVariationalAutoencoderMLP, PROP) checks whether PROP exists for NNVariationalAutoencoderMLP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNVAE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%  Element.EXISTSPROP(NNVAE, PROP) throws error if PROP does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%  Element.EXISTSPROP(NNVariationalAutoencoderMLP, PROP) throws error if PROP does NOT exist for NNVariationalAutoencoderMLP.
			%   Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNVAE) and Element.EXISTSPROP('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 33 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderMLP:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderMLP:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNVariationalAutoencoderMLP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in a neural-network variational autoencoder with a multilayer perceptron backbone/error.
			%
			% CHECK = NNVariationalAutoencoderMLP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNVAE.EXISTSTAG(TAG) checks whether TAG exists for NNVAE.
			%  CHECK = Element.EXISTSTAG(NNVAE, TAG) checks whether TAG exists for NNVAE.
			%  CHECK = Element.EXISTSTAG(NNVariationalAutoencoderMLP, TAG) checks whether TAG exists for NNVariationalAutoencoderMLP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNVAE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%  Element.EXISTSTAG(NNVAE, TAG) throws error if TAG does NOT exist for NNVAE.
			%   Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%  Element.EXISTSTAG(NNVariationalAutoencoderMLP, TAG) throws error if TAG does NOT exist for NNVariationalAutoencoderMLP.
			%   Error id: [BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNVAE) and Element.EXISTSTAG('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN'  'NEURONS_PER_LAYER' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderMLP:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderMLP:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNVariationalAutoencoderMLP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNVariationalAutoencoderMLP, POINTER) returns property number of POINTER of NNVariationalAutoencoderMLP.
			%  PROPERTY = NNVAE.GETPROPPROP(NNVariationalAutoencoderMLP, POINTER) returns property number of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPPROP(NNVAE) and Element.GETPROPPROP('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN'  'NEURONS_PER_LAYER' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNVariationalAutoencoderMLP, POINTER) returns tag of POINTER of NNVariationalAutoencoderMLP.
			%  TAG = NNVAE.GETPROPTAG(NNVariationalAutoencoderMLP, POINTER) returns tag of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPTAG(NNVAE) and Element.GETPROPTAG('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nnvariationalautoencodermlp_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'DP_CLASSES'  'EPOCHS'  'BATCH'  'SHUFFLE'  'SOLVER'  'MODEL'  'INPUTS'  'TARGETS'  'TRAIN'  'VERBOSE'  'PLOT_TRAINING'  'PREDICT'  'LEARN_RATE'  'NUM_LATENT_REP'  'SIZE_INPUT'  'ITERATION_DIM'  'NUM_MBQ_OUTPUT'  'MINIBATCH_FORMAT_INPUT'  'MINIBATCH_FORMAT_TARGET'  'ENCODER'  'DECODER'  'MBQ'  'LOSS_FN'  'NEURONS_PER_LAYER' };
				tag = nnvariationalautoencodermlp_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNVariationalAutoencoderMLP, POINTER) returns category of POINTER of NNVariationalAutoencoderMLP.
			%  CATEGORY = NNVAE.GETPROPCATEGORY(NNVariationalAutoencoderMLP, POINTER) returns category of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPCATEGORY(NNVAE) and Element.GETPROPCATEGORY('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderMLP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencodermlp_category_list = { 1  1  1  3  4  2  2  6  4  3  3  3  3  3  5  6  6  6  9  2  6  3  3  3  3  3  6  6  4  4  6  6  3 };
			prop_category = nnvariationalautoencodermlp_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNVariationalAutoencoderMLP, POINTER) returns format of POINTER of NNVariationalAutoencoderMLP.
			%  FORMAT = NNVAE.GETPROPFORMAT(NNVariationalAutoencoderMLP, POINTER) returns format of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPFORMAT(NNVAE) and Element.GETPROPFORMAT('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderMLP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencodermlp_format_list = { 2  2  2  8  2  2  2  2  8  7  11  11  5  5  17  16  16  1  4  5  16  11  11  12  11  11  2  2  17  17  1  11  12 };
			prop_format = nnvariationalautoencodermlp_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNVariationalAutoencoderMLP, POINTER) returns description of POINTER of NNVariationalAutoencoderMLP.
			%  DESCRIPTION = NNVAE.GETPROPDESCRIPTION(NNVariationalAutoencoderMLP, POINTER) returns description of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNVAE) and Element.GETPROPDESCRIPTION('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderMLP.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nnvariationalautoencodermlp_description_list = { 'ELCLASS (constant, string) is the class of the neural-network variational autoencoder (MLP).'  'NAME (constant, string) is the name of the neural-network variational autoencoder (MLP).'  'DESCRIPTION (constant, string) is the description of the neural-network variational autoencoder (MLP).'  'TEMPLATE (parameter, item) is the template of the neural-network variational autoencoder (MLP).'  'ID (data, string) is a few-letter code of the neural-network variational autoencoder (MLP).'  'LABEL (metadata, string) is an extended label of the neural-network variational autoencoder (MLP).'  'NOTES (metadata, string) are some specific notes of the neural-network variational autoencoder (MLP).'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (data, item) is the dataset used to train the variational autoencoder. Its data-point class DP_CLASS must belong to the compatible set DP_CLASSES.'  'DP_CLASSES (parameter, classlist) is the list of compatible data-point classes for this variational autoencoder.'  'EPOCHS (parameter, scalar) is the maximum number of epochs.'  'BATCH (parameter, scalar) is the size of the mini-batch used for each training iteration.'  'SHUFFLE (parameter, option) is an option for data shuffling.'  'SOLVER (parameter, option) is an option for the solver.'  'MODEL (result, net) is a trained neural network model with the given dataset.'  'INPUTS (query, cell) constructs and returns the input matrix from dataset D by flattening each input to length SIZE_INPUT and stacking column-wise.'  'TARGETS (query, stringlist) constructs and returns the targets from dataset D (if applicable).'  'TRAIN (query, empty) configures an MLP encoder/decoder and then trains via the superclass to minimise LOSS_FN (negative ELBO) using a mini-batch loop.'  'VERBOSE (gui, logical) is an indicator to display training progress information.'  'PLOT_TRAINING (metadata, option) determines whether to plot the training progress.'  'PREDICT (query, cell) returns the predictions of the trained neural network for a dataset.'  'LEARN_RATE (parameter, scalar) is the learning rate for optimisation.'  'NUM_LATENT_REP (parameter, scalar) is the number of latent representations (latent dimensions).'  'SIZE_INPUT (parameter, rvector) is the size of the input data once flattened (scalar number of features).'  'ITERATION_DIM (parameter, scalar) is used by minibatchqueue (MBQ) to indicate the concatenation/batch dimension.'  'NUM_MBQ_OUTPUT (parameter, scalar) is the number of outputs produced by the minibatchqueue (MBQ).'  'MINIBATCH_FORMAT_INPUT (query, string) is a dlarray label string for input mini-batches (e.g., "CB"), used by minibatchqueue (MBQ).'  'MINIBATCH_FORMAT_TARGET (query, string) is a dlarray label string for target mini-batches (may be empty), used by minibatchqueue (MBQ).'  'ENCODER (data, net) is a learnable encoder network (e.g., a dlnetwork) that outputs μ and log σ² and samples z via reparameterisation.'  'DECODER (data, net) is a learnable decoder network (e.g., a dlnetwork) that maps latent samples z back to the input space.'  'MBQ (query, empty) returns a configured minibatchqueue (MBQ) for training on dataset D.'  'LOSS_FN (query, scalar) returns the scalar training loss (negative ELBO), computed as a reconstruction term plus a Kullback–Leibler divergence that regularises q(z|x) towards N(0, I).'  'NEURONS_PER_LAYER (parameter, rvector) are the hidden-layer widths for the MLP encoder/decoder (mirrored in the decoder).' };
			prop_description = nnvariationalautoencodermlp_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNVariationalAutoencoderMLP, POINTER) returns settings of POINTER of NNVariationalAutoencoderMLP.
			%  SETTINGS = NNVAE.GETPROPSETTINGS(NNVariationalAutoencoderMLP, POINTER) returns settings of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPSETTINGS(NNVAE) and Element.GETPROPSETTINGS('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNVariationalAutoencoderMLP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 33 % NNVariationalAutoencoderMLP.NEURONS_PER_LAYER
					prop_settings = Format.getFormatSettings(12);
				case 4 % NNVariationalAutoencoderMLP.TEMPLATE
					prop_settings = 'NNVariationalAutoencoderMLP';
				case 9 % NNVariationalAutoencoderMLP.D
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@NNVariationalAutoencoder(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoderMLP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoderMLP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNVAE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNVAE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNVariationalAutoencoderMLP, POINTER) returns the default value of POINTER of NNVariationalAutoencoderMLP.
			%  DEFAULT = NNVAE.GETPROPDEFAULT(NNVariationalAutoencoderMLP, POINTER) returns the default value of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPDEFAULT(NNVAE) and Element.GETPROPDEFAULT('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNVariationalAutoencoderMLP.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 33 % NNVariationalAutoencoderMLP.NEURONS_PER_LAYER
					prop_default = [64 64];
				case 1 % NNVariationalAutoencoderMLP.ELCLASS
					prop_default = 'NNVariationalAutoencoderMLP';
				case 2 % NNVariationalAutoencoderMLP.NAME
					prop_default = 'Neural Network Variational Autoencoder (MLP)';
				case 3 % NNVariationalAutoencoderMLP.DESCRIPTION
					prop_default = 'A neural-network variational autoencoder with a multilayer perceptron backbone (NNVariationalAutoencoderMLP) comprises an encoder and a decoder and is trained in an unsupervised manner to maximise the evidence lower bound (ELBO). The encoder outputs the parameters of a Gaussian latent distribution (mean μ and log-variance log σ²); a latent sample z is obtained via the reparameterisation trick and decoded back to the input space. Training minimises the negative ELBO, i.e., a reconstruction term plus a Kullback–Leibler divergence that regularises the approximate posterior towards a standard normal prior N(0, I). This subclass uses a multilayer perceptron (MLP) as the encoder/decoder backbone and trains on a neural-network dataset (NNDataset).';
				case 4 % NNVariationalAutoencoderMLP.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNVariationalAutoencoderMLP.getPropSettings(prop));
				case 5 % NNVariationalAutoencoderMLP.ID
					prop_default = 'NNVariationalAutoencoderMLP ID';
				case 6 % NNVariationalAutoencoderMLP.LABEL
					prop_default = 'NNVariationalAutoencoderMLP label';
				case 7 % NNVariationalAutoencoderMLP.NOTES
					prop_default = 'NNVariationalAutoencoderMLP notes';
				case 9 % NNVariationalAutoencoderMLP.D
					prop_default = NNDataset('DP_CLASS', 'NNDataPoint');
				case 10 % NNVariationalAutoencoderMLP.DP_CLASSES
					prop_default = {'NNDataPoint' 'NNDataPoint_RamanSpectra' 'NNDataPoint_Image'};
				case 24 % NNVariationalAutoencoderMLP.SIZE_INPUT
					prop_default = 784;
				case 25 % NNVariationalAutoencoderMLP.ITERATION_DIM
					prop_default = 2;
				case 27 % NNVariationalAutoencoderMLP.MINIBATCH_FORMAT_INPUT
					prop_default = 'CB';
				case 28 % NNVariationalAutoencoderMLP.MINIBATCH_FORMAT_TARGET
					prop_default = '';
				otherwise
					prop_default = getPropDefault@NNVariationalAutoencoder(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNVariationalAutoencoderMLP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNVariationalAutoencoderMLP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNVAE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNVAE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoderMLP, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoderMLP.
			%  DEFAULT = NNVAE.GETPROPDEFAULTCONDITIONED(NNVariationalAutoencoderMLP, POINTER) returns the conditioned default value of POINTER of NNVariationalAutoencoderMLP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNVAE) and Element.GETPROPDEFAULTCONDITIONED('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNVariationalAutoencoderMLP.getPropProp(pointer);
			
			prop_default = NNVariationalAutoencoderMLP.conditioning(prop, NNVariationalAutoencoderMLP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNVariationalAutoencoderMLP, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoderMLP.
			%  CHECK = NNVAE.CHECKPROP(NNVariationalAutoencoderMLP, PROP, VALUE) checks VALUE format for PROP of NNVariationalAutoencoderMLP.
			% 
			% NNVAE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNVariationalAutoencoderMLP:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNVAE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNVAE.
			%   Error id: BRAPH2:NNVariationalAutoencoderMLP:WrongInput
			%  Element.CHECKPROP(NNVariationalAutoencoderMLP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoderMLP.
			%   Error id: BRAPH2:NNVariationalAutoencoderMLP:WrongInput
			%  NNVAE.CHECKPROP(NNVariationalAutoencoderMLP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNVariationalAutoencoderMLP.
			%   Error id: BRAPH2:NNVariationalAutoencoderMLP:WrongInput]
			% 
			% Note that the Element.CHECKPROP(NNVAE) and Element.CHECKPROP('NNVariationalAutoencoderMLP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNVariationalAutoencoderMLP.getPropProp(pointer);
			
			switch prop
				case 33 % NNVariationalAutoencoderMLP.NEURONS_PER_LAYER
					check = Format.checkFormat(12, value, NNVariationalAutoencoderMLP.getPropSettings(prop));
				case 4 % NNVariationalAutoencoderMLP.TEMPLATE
					check = Format.checkFormat(8, value, NNVariationalAutoencoderMLP.getPropSettings(prop));
				case 9 % NNVariationalAutoencoderMLP.D
					check = Format.checkFormat(8, value, NNVariationalAutoencoderMLP.getPropSettings(prop));
				otherwise
					if prop <= 32
						check = checkProp@NNVariationalAutoencoder(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNVariationalAutoencoderMLP:' 'WrongInput'], ...
					['BRAPH2' ':NNVariationalAutoencoderMLP:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNVariationalAutoencoderMLP.getPropTag(prop) ' (' NNVariationalAutoencoderMLP.getFormatTag(NNVariationalAutoencoderMLP.getPropFormat(prop)) ').'] ...
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
				case 9 % NNVariationalAutoencoderMLP.D
					if ~isequal(nnvae.get('D').get('DP_DICT').get('LENGTH'), 0)
					    input_data = cell2mat(nnvae.get('D').get('DP_DICT').get('IT', 1).get('INPUT'));
					    size_input = size(input_data);
					    nnvae.set('SIZE_INPUT', prod(size_input));
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
				case 16 % NNVariationalAutoencoderMLP.INPUTS
					% inputs = nn.get('INPUTS', D) returns a cell/matrix of inputs for all data points in dataset D.
					if isempty(varargin)
					    value = {};
					    return
					end
					d = varargin{1};
					inputs_group = d.get('INPUTS');
					if isempty(inputs_group)
					    value = {};
					else
					    s1 = nnvae.get('SIZE_INPUT');
					    flat_cells = cellfun(@(c) c{1}, inputs_group, 'UniformOutput', false);
					    value = reshape(cat(1, flat_cells{:}), s1, []);
					end
					
				case 17 % NNVariationalAutoencoderMLP.TARGETS
					% targets = nn.get('TARGETS', D) returns targets for all data points in dataset D (if used).
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
					
				case 18 % NNVariationalAutoencoderMLP.TRAIN
					% --- Set up ENCODER ---
					% Retrieve hyperparameters
					neurons = nnvae.get('NEURONS_PER_LAYER');
					numLatentChannels = nnvae.get('NUM_LATENT_REP');
					inputSize = nnvae.get('SIZE_INPUT');
					numFeature = prod(inputSize);
					
					if nnvae.isLocked('ENCODER')
					    value = {};
					    return
					end
					
					% Define layers
					layersE = [
					    featureInputLayer(numFeature, Normalization="none")
					    ];
					for i = 1:length(neurons)
					    n = neurons(i);
					    layersE = [
					        layersE
					        fullyConnectedLayer(n)
					        reluLayer
					        ];
					end
					layersE = [
					    layersE
					    fullyConnectedLayer(2*numLatentChannels, Name="latentOutput")
					    samplingLayer
					    ];
					nnvae.set('ENCODER', dlnetwork(layersE));
					
					% --- Set up DECODER ---
					% Define layers
					layersD = [
					    featureInputLayer(numLatentChannels, Normalization="none")
					    ];
					for i = length(neurons):-1:1
					    n = neurons(i);
					    layersD = [
					        layersD
					        fullyConnectedLayer(n)
					        reluLayer
					        ];
					end
					layersD = [
					    layersD
					    fullyConnectedLayer(numFeature)
					    leakyReluLayer(1)
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
				case 9 % NNVariationalAutoencoderMLP.D
					check = ismember(value.get('DP_CLASS'), nnvae.get('DP_CLASSES'));
					
				otherwise
					if prop <= 32
						[check, msg] = checkValue@NNVariationalAutoencoder(nnvae, prop, value);
					end
			end
		end
	end
end
