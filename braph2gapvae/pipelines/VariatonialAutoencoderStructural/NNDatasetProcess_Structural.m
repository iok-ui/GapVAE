classdef NNDatasetProcess_Structural < NNDatasetProcess
	%NNDatasetProcess_Structural processes subject-level structural regional values into a neural-network dataset.
	% It is a subclass of <a href="matlab:help NNDatasetProcess">NNDatasetProcess</a>.
	%
	% The structural dataset process (NNDatasetProcess_Structural) converts subject-level structural regional values from one or more SubjectST groups into an NNDataset of NNDataPoint_Structural. It applies optional transformation and normalisation to the regional-value vectors and attaches the variables of interest associated with each subject.
	%
	% The list of NNDatasetProcess_Structural properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the structural dataset process.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the structural dataset process.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the structural dataset process.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the structural dataset process.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the structural dataset process.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the structural dataset process.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are specific notes of the structural dataset process.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>D</strong> 	D (result, item) is the neural-network dataset containing NNDataPoint_Structural data points built from processed structural regional values.
	%  <strong>10</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
	%  <strong>11</strong> <strong>GR_LIST</strong> 	GR_LIST (metadata, itemlist) is the list of SubjectST groups used to build the neural-network dataset.
	%  <strong>12</strong> <strong>TRANSFORMATION_RULE</strong> 	TRANSFORMATION_RULE (parameter, option) is the transformation applied to the structural regional-value matrix before normalisation.
	%  <strong>13</strong> <strong>NORMALIZATION_RULE</strong> 	NORMALIZATION_RULE (parameter, option) is the normalisation applied after transformation.
	%  <strong>14</strong> <strong>SCALE_FACTOR</strong> 	SCALE_FACTOR (parameter, scalar) is the scaling factor used when NORMALIZATION_RULE is Scale.
	%  <strong>15</strong> <strong>TRANSFORM_DATA</strong> 	TRANSFORM_DATA (query, cell) applies TRANSFORMATION_RULE to a regions-by-datapoints matrix and returns the transformed data.
	%  <strong>16</strong> <strong>INV_TRANSFORM_DATA</strong> 	INV_TRANSFORM_DATA (query, cell) applies the inverse of TRANSFORMATION_RULE to recover regional-value vectors from a transformed representation.
	%  <strong>17</strong> <strong>NORMALIZE_DATA</strong> 	NORMALIZE_DATA (query, cell) applies NORMALIZATION_RULE to a regions-by-datapoints matrix and returns the normalised data.
	%  <strong>18</strong> <strong>INV_NORMALIZE_DATA</strong> 	INV_NORMALIZE_DATA (query, cell) applies the inverse of NORMALIZATION_RULE to restore the original data scale.
	%  <strong>19</strong> <strong>RAW_DATA</strong> 	RAW_DATA (result, cell) returns the raw structural regional values as a cell array, with one column vector per subject.
	%  <strong>20</strong> <strong>PROCESS_DATA</strong> 	PROCESS_DATA (query, cell) returns structural regional values processed by TRANSFORM_DATA followed by NORMALIZE_DATA, packaged as a cell array of column vectors.
	%  <strong>21</strong> <strong>REV_PROCESS_DATA</strong> 	REV_PROCESS_DATA (query, cell) returns structural regional values reconstructed by INV_NORMALIZE_DATA and INV_TRANSFORM_DATA, packaged as a cell array of column vectors.
	%  <strong>22</strong> <strong>EXTRACT_DATA</strong> 	EXTRACT_DATA (query, cell) extracts structural regional values from all SubjectST objects in GR_LIST and returns a cell array of region-by-1 vectors.
	%  <strong>23</strong> <strong>VOI_DICT_LIST</strong> 	VOI_DICT_LIST (query, cell) extracts the variables-of-interest dictionaries from all subjects in GR_LIST.
	%  <strong>24</strong> <strong>MEMORIZE_DATA</strong> 	MEMORIZE_DATA (query, empty) memorizes the processed input data and targets for later neural-network training.
	%
	% NNDatasetProcess_Structural methods (constructor):
	%  NNDatasetProcess_Structural - constructor
	%
	% NNDatasetProcess_Structural methods:
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
	% NNDatasetProcess_Structural methods (display):
	%  tostring - string with information about the structural dataset process
	%  disp - displays information about the structural dataset process
	%  tree - displays the tree of the structural dataset process
	%
	% NNDatasetProcess_Structural methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two structural dataset process are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the structural dataset process
	%
	% NNDatasetProcess_Structural methods (save/load, Static):
	%  save - saves BRAPH2 structural dataset process as b2 file
	%  load - loads a BRAPH2 structural dataset process from a b2 file
	%
	% NNDatasetProcess_Structural method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the structural dataset process
	%
	% NNDatasetProcess_Structural method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the structural dataset process
	%
	% NNDatasetProcess_Structural methods (inspection, Static):
	%  getClass - returns the class of the structural dataset process
	%  getSubclasses - returns all subclasses of NNDatasetProcess_Structural
	%  getProps - returns the property list of the structural dataset process
	%  getPropNumber - returns the property number of the structural dataset process
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
	% NNDatasetProcess_Structural methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNDatasetProcess_Structural methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNDatasetProcess_Structural methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNDatasetProcess_Structural methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNDatasetProcess_Structural; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNDatasetProcess_Structural constants</a>.
	%
	%
	% See also NNDatasetProcess, NNDataPoint, NNDataPoint_Structural, NNDataset, Group, SubjectST.
	%
	% BUILD BRAPH2 7 class_name 1
	
	properties (Constant) % properties
		WAITBAR = 10; %CET: Computational Efficiency Trick
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = 9;
		WAITBAR_FORMAT = 4;
		
		GR_LIST = 11; %CET: Computational Efficiency Trick
		GR_LIST_TAG = 'GR_LIST';
		GR_LIST_CATEGORY = 2;
		GR_LIST_FORMAT = 9;
		
		TRANSFORMATION_RULE = 12; %CET: Computational Efficiency Trick
		TRANSFORMATION_RULE_TAG = 'TRANSFORMATION_RULE';
		TRANSFORMATION_RULE_CATEGORY = 3;
		TRANSFORMATION_RULE_FORMAT = 5;
		
		NORMALIZATION_RULE = 13; %CET: Computational Efficiency Trick
		NORMALIZATION_RULE_TAG = 'NORMALIZATION_RULE';
		NORMALIZATION_RULE_CATEGORY = 3;
		NORMALIZATION_RULE_FORMAT = 5;
		
		SCALE_FACTOR = 14; %CET: Computational Efficiency Trick
		SCALE_FACTOR_TAG = 'SCALE_FACTOR';
		SCALE_FACTOR_CATEGORY = 3;
		SCALE_FACTOR_FORMAT = 11;
		
		TRANSFORM_DATA = 15; %CET: Computational Efficiency Trick
		TRANSFORM_DATA_TAG = 'TRANSFORM_DATA';
		TRANSFORM_DATA_CATEGORY = 6;
		TRANSFORM_DATA_FORMAT = 16;
		
		INV_TRANSFORM_DATA = 16; %CET: Computational Efficiency Trick
		INV_TRANSFORM_DATA_TAG = 'INV_TRANSFORM_DATA';
		INV_TRANSFORM_DATA_CATEGORY = 6;
		INV_TRANSFORM_DATA_FORMAT = 16;
		
		NORMALIZE_DATA = 17; %CET: Computational Efficiency Trick
		NORMALIZE_DATA_TAG = 'NORMALIZE_DATA';
		NORMALIZE_DATA_CATEGORY = 6;
		NORMALIZE_DATA_FORMAT = 16;
		
		INV_NORMALIZE_DATA = 18; %CET: Computational Efficiency Trick
		INV_NORMALIZE_DATA_TAG = 'INV_NORMALIZE_DATA';
		INV_NORMALIZE_DATA_CATEGORY = 6;
		INV_NORMALIZE_DATA_FORMAT = 16;
		
		RAW_DATA = 19; %CET: Computational Efficiency Trick
		RAW_DATA_TAG = 'RAW_DATA';
		RAW_DATA_CATEGORY = 5;
		RAW_DATA_FORMAT = 16;
		
		PROCESS_DATA = 20; %CET: Computational Efficiency Trick
		PROCESS_DATA_TAG = 'PROCESS_DATA';
		PROCESS_DATA_CATEGORY = 6;
		PROCESS_DATA_FORMAT = 16;
		
		REV_PROCESS_DATA = 21; %CET: Computational Efficiency Trick
		REV_PROCESS_DATA_TAG = 'REV_PROCESS_DATA';
		REV_PROCESS_DATA_CATEGORY = 6;
		REV_PROCESS_DATA_FORMAT = 16;
		
		EXTRACT_DATA = 22; %CET: Computational Efficiency Trick
		EXTRACT_DATA_TAG = 'EXTRACT_DATA';
		EXTRACT_DATA_CATEGORY = 6;
		EXTRACT_DATA_FORMAT = 16;
		
		VOI_DICT_LIST = 23; %CET: Computational Efficiency Trick
		VOI_DICT_LIST_TAG = 'VOI_DICT_LIST';
		VOI_DICT_LIST_CATEGORY = 6;
		VOI_DICT_LIST_FORMAT = 16;
		
		MEMORIZE_DATA = 24; %CET: Computational Efficiency Trick
		MEMORIZE_DATA_TAG = 'MEMORIZE_DATA';
		MEMORIZE_DATA_CATEGORY = 6;
		MEMORIZE_DATA_FORMAT = 1;
	end
	methods % constructor
		function dproc = NNDatasetProcess_Structural(varargin)
			%NNDatasetProcess_Structural() creates a structural dataset process.
			%
			% NNDatasetProcess_Structural(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNDatasetProcess_Structural(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of NNDatasetProcess_Structural properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the structural dataset process.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the structural dataset process.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the structural dataset process.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the structural dataset process.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code of the structural dataset process.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the structural dataset process.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are specific notes of the structural dataset process.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>D</strong> 	D (result, item) is the neural-network dataset containing NNDataPoint_Structural data points built from processed structural regional values.
			%  <strong>10</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) determines whether to show the waitbar.
			%  <strong>11</strong> <strong>GR_LIST</strong> 	GR_LIST (metadata, itemlist) is the list of SubjectST groups used to build the neural-network dataset.
			%  <strong>12</strong> <strong>TRANSFORMATION_RULE</strong> 	TRANSFORMATION_RULE (parameter, option) is the transformation applied to the structural regional-value matrix before normalisation.
			%  <strong>13</strong> <strong>NORMALIZATION_RULE</strong> 	NORMALIZATION_RULE (parameter, option) is the normalisation applied after transformation.
			%  <strong>14</strong> <strong>SCALE_FACTOR</strong> 	SCALE_FACTOR (parameter, scalar) is the scaling factor used when NORMALIZATION_RULE is Scale.
			%  <strong>15</strong> <strong>TRANSFORM_DATA</strong> 	TRANSFORM_DATA (query, cell) applies TRANSFORMATION_RULE to a regions-by-datapoints matrix and returns the transformed data.
			%  <strong>16</strong> <strong>INV_TRANSFORM_DATA</strong> 	INV_TRANSFORM_DATA (query, cell) applies the inverse of TRANSFORMATION_RULE to recover regional-value vectors from a transformed representation.
			%  <strong>17</strong> <strong>NORMALIZE_DATA</strong> 	NORMALIZE_DATA (query, cell) applies NORMALIZATION_RULE to a regions-by-datapoints matrix and returns the normalised data.
			%  <strong>18</strong> <strong>INV_NORMALIZE_DATA</strong> 	INV_NORMALIZE_DATA (query, cell) applies the inverse of NORMALIZATION_RULE to restore the original data scale.
			%  <strong>19</strong> <strong>RAW_DATA</strong> 	RAW_DATA (result, cell) returns the raw structural regional values as a cell array, with one column vector per subject.
			%  <strong>20</strong> <strong>PROCESS_DATA</strong> 	PROCESS_DATA (query, cell) returns structural regional values processed by TRANSFORM_DATA followed by NORMALIZE_DATA, packaged as a cell array of column vectors.
			%  <strong>21</strong> <strong>REV_PROCESS_DATA</strong> 	REV_PROCESS_DATA (query, cell) returns structural regional values reconstructed by INV_NORMALIZE_DATA and INV_TRANSFORM_DATA, packaged as a cell array of column vectors.
			%  <strong>22</strong> <strong>EXTRACT_DATA</strong> 	EXTRACT_DATA (query, cell) extracts structural regional values from all SubjectST objects in GR_LIST and returns a cell array of region-by-1 vectors.
			%  <strong>23</strong> <strong>VOI_DICT_LIST</strong> 	VOI_DICT_LIST (query, cell) extracts the variables-of-interest dictionaries from all subjects in GR_LIST.
			%  <strong>24</strong> <strong>MEMORIZE_DATA</strong> 	MEMORIZE_DATA (query, empty) memorizes the processed input data and targets for later neural-network training.
			%
			% See also Category, Format.
			
			dproc = dproc@NNDatasetProcess(varargin{:});
		end
	end
	methods (Static) % inspection
		function build = getBuild()
			%GETBUILD returns the build of the structural dataset process.
			%
			% BUILD = NNDatasetProcess_Structural.GETBUILD() returns the build of 'NNDatasetProcess_Structural'.
			%
			% Alternative forms to call this method are:
			%  BUILD = DPROC.GETBUILD() returns the build of the structural dataset process DPROC.
			%  BUILD = Element.GETBUILD(DPROC) returns the build of 'DPROC'.
			%  BUILD = Element.GETBUILD('NNDatasetProcess_Structural') returns the build of 'NNDatasetProcess_Structural'.
			%
			% Note that the Element.GETBUILD(DPROC) and Element.GETBUILD('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			
			build = 1;
		end
		function dproc_class = getClass()
			%GETCLASS returns the class of the structural dataset process.
			%
			% CLASS = NNDatasetProcess_Structural.GETCLASS() returns the class 'NNDatasetProcess_Structural'.
			%
			% Alternative forms to call this method are:
			%  CLASS = DPROC.GETCLASS() returns the class of the structural dataset process DPROC.
			%  CLASS = Element.GETCLASS(DPROC) returns the class of 'DPROC'.
			%  CLASS = Element.GETCLASS('NNDatasetProcess_Structural') returns 'NNDatasetProcess_Structural'.
			%
			% Note that the Element.GETCLASS(DPROC) and Element.GETCLASS('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			
			dproc_class = 'NNDatasetProcess_Structural';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the structural dataset process.
			%
			% LIST = NNDatasetProcess_Structural.GETSUBCLASSES() returns all subclasses of 'NNDatasetProcess_Structural'.
			%
			% Alternative forms to call this method are:
			%  LIST = DPROC.GETSUBCLASSES() returns all subclasses of the structural dataset process DPROC.
			%  LIST = Element.GETSUBCLASSES(DPROC) returns all subclasses of 'DPROC'.
			%  LIST = Element.GETSUBCLASSES('NNDatasetProcess_Structural') returns all subclasses of 'NNDatasetProcess_Structural'.
			%
			% Note that the Element.GETSUBCLASSES(DPROC) and Element.GETSUBCLASSES('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'NNDatasetProcess_Structural' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of structural dataset process.
			%
			% PROPS = NNDatasetProcess_Structural.GETPROPS() returns the property list of structural dataset process
			%  as a row vector.
			%
			% PROPS = NNDatasetProcess_Structural.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = DPROC.GETPROPS([CATEGORY]) returns the property list of the structural dataset process DPROC.
			%  PROPS = Element.GETPROPS(DPROC[, CATEGORY]) returns the property list of 'DPROC'.
			%  PROPS = Element.GETPROPS('NNDatasetProcess_Structural'[, CATEGORY]) returns the property list of 'NNDatasetProcess_Structural'.
			%
			% Note that the Element.GETPROPS(DPROC) and Element.GETPROPS('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 11];
				case 3 % Category.PARAMETER
					prop_list = [4 12 13 14];
				case 4 % Category.DATA
					prop_list = 5;
				case 5 % Category.RESULT
					prop_list = [9 19];
				case 6 % Category.QUERY
					prop_list = [8 15 16 17 18 20 21 22 23 24];
				case 9 % Category.GUI
					prop_list = 10;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of structural dataset process.
			%
			% N = NNDatasetProcess_Structural.GETPROPNUMBER() returns the property number of structural dataset process.
			%
			% N = NNDatasetProcess_Structural.GETPROPNUMBER(CATEGORY) returns the property number of structural dataset process
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = DPROC.GETPROPNUMBER([CATEGORY]) returns the property number of the structural dataset process DPROC.
			%  N = Element.GETPROPNUMBER(DPROC) returns the property number of 'DPROC'.
			%  N = Element.GETPROPNUMBER('NNDatasetProcess_Structural') returns the property number of 'NNDatasetProcess_Structural'.
			%
			% Note that the Element.GETPROPNUMBER(DPROC) and Element.GETPROPNUMBER('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 24;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 4;
				case 4 % Category.DATA
					prop_number = 1;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 10;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in structural dataset process/error.
			%
			% CHECK = NNDatasetProcess_Structural.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DPROC.EXISTSPROP(PROP) checks whether PROP exists for DPROC.
			%  CHECK = Element.EXISTSPROP(DPROC, PROP) checks whether PROP exists for DPROC.
			%  CHECK = Element.EXISTSPROP(NNDatasetProcess_Structural, PROP) checks whether PROP exists for NNDatasetProcess_Structural.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DPROC.EXISTSPROP(PROP) throws error if PROP does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%  Element.EXISTSPROP(DPROC, PROP) throws error if PROP does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%  Element.EXISTSPROP(NNDatasetProcess_Structural, PROP) throws error if PROP does NOT exist for NNDatasetProcess_Structural.
			%   Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%
			% Note that the Element.EXISTSPROP(DPROC) and Element.EXISTSPROP('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 24 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess_Structural:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNDatasetProcess_Structural.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in structural dataset process/error.
			%
			% CHECK = NNDatasetProcess_Structural.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = DPROC.EXISTSTAG(TAG) checks whether TAG exists for DPROC.
			%  CHECK = Element.EXISTSTAG(DPROC, TAG) checks whether TAG exists for DPROC.
			%  CHECK = Element.EXISTSTAG(NNDatasetProcess_Structural, TAG) checks whether TAG exists for NNDatasetProcess_Structural.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%
			% Alternative forms to call this method are:
			%  DPROC.EXISTSTAG(TAG) throws error if TAG does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%  Element.EXISTSTAG(DPROC, TAG) throws error if TAG does NOT exist for DPROC.
			%   Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%  Element.EXISTSTAG(NNDatasetProcess_Structural, TAG) throws error if TAG does NOT exist for NNDatasetProcess_Structural.
			%   Error id: [BRAPH2:NNDatasetProcess_Structural:WrongInput]
			%
			% Note that the Element.EXISTSTAG(DPROC) and Element.EXISTSTAG('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'WAITBAR'  'GR_LIST'  'TRANSFORMATION_RULE'  'NORMALIZATION_RULE'  'SCALE_FACTOR'  'TRANSFORM_DATA'  'INV_TRANSFORM_DATA'  'NORMALIZE_DATA'  'INV_NORMALIZE_DATA'  'RAW_DATA'  'PROCESS_DATA'  'REV_PROCESS_DATA'  'EXTRACT_DATA'  'VOI_DICT_LIST'  'MEMORIZE_DATA' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess_Structural:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for NNDatasetProcess_Structural.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(NNDatasetProcess_Structural, POINTER) returns property number of POINTER of NNDatasetProcess_Structural.
			%  PROPERTY = DPROC.GETPROPPROP(NNDatasetProcess_Structural, POINTER) returns property number of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPPROP(DPROC) and Element.GETPROPPROP('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'WAITBAR'  'GR_LIST'  'TRANSFORMATION_RULE'  'NORMALIZATION_RULE'  'SCALE_FACTOR'  'TRANSFORM_DATA'  'INV_TRANSFORM_DATA'  'NORMALIZE_DATA'  'INV_NORMALIZE_DATA'  'RAW_DATA'  'PROCESS_DATA'  'REV_PROCESS_DATA'  'EXTRACT_DATA'  'VOI_DICT_LIST'  'MEMORIZE_DATA' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(NNDatasetProcess_Structural, POINTER) returns tag of POINTER of NNDatasetProcess_Structural.
			%  TAG = DPROC.GETPROPTAG(NNDatasetProcess_Structural, POINTER) returns tag of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPTAG(DPROC) and Element.GETPROPTAG('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				nndatasetprocess_structural_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'D'  'WAITBAR'  'GR_LIST'  'TRANSFORMATION_RULE'  'NORMALIZATION_RULE'  'SCALE_FACTOR'  'TRANSFORM_DATA'  'INV_TRANSFORM_DATA'  'NORMALIZE_DATA'  'INV_NORMALIZE_DATA'  'RAW_DATA'  'PROCESS_DATA'  'REV_PROCESS_DATA'  'EXTRACT_DATA'  'VOI_DICT_LIST'  'MEMORIZE_DATA' };
				tag = nndatasetprocess_structural_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(NNDatasetProcess_Structural, POINTER) returns category of POINTER of NNDatasetProcess_Structural.
			%  CATEGORY = DPROC.GETPROPCATEGORY(NNDatasetProcess_Structural, POINTER) returns category of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPCATEGORY(DPROC) and Element.GETPROPCATEGORY('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_structural_category_list = { 1  1  1  3  4  2  2  6  5  9  2  3  3  3  6  6  6  6  5  6  6  6  6  6 };
			prop_category = nndatasetprocess_structural_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(NNDatasetProcess_Structural, POINTER) returns format of POINTER of NNDatasetProcess_Structural.
			%  FORMAT = DPROC.GETPROPFORMAT(NNDatasetProcess_Structural, POINTER) returns format of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPFORMAT(DPROC) and Element.GETPROPFORMAT('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_structural_format_list = { 2  2  2  8  2  2  2  2  8  4  9  5  5  11  16  16  16  16  16  16  16  16  16  1 };
			prop_format = nndatasetprocess_structural_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNDatasetProcess_Structural, POINTER) returns description of POINTER of NNDatasetProcess_Structural.
			%  DESCRIPTION = DPROC.GETPROPDESCRIPTION(NNDatasetProcess_Structural, POINTER) returns description of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPDESCRIPTION(DPROC) and Element.GETPROPDESCRIPTION('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_Structural.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			nndatasetprocess_structural_description_list = { 'ELCLASS (constant, string) is the class of the structural dataset process.'  'NAME (constant, string) is the name of the structural dataset process.'  'DESCRIPTION (constant, string) is the description of the structural dataset process.'  'TEMPLATE (parameter, item) is the template of the structural dataset process.'  'ID (data, string) is a few-letter code of the structural dataset process.'  'LABEL (metadata, string) is an extended label of the structural dataset process.'  'NOTES (metadata, string) are specific notes of the structural dataset process.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'D (result, item) is the neural-network dataset containing NNDataPoint_Structural data points built from processed structural regional values.'  'WAITBAR (gui, logical) determines whether to show the waitbar.'  'GR_LIST (metadata, itemlist) is the list of SubjectST groups used to build the neural-network dataset.'  'TRANSFORMATION_RULE (parameter, option) is the transformation applied to the structural regional-value matrix before normalisation.'  'NORMALIZATION_RULE (parameter, option) is the normalisation applied after transformation.'  'SCALE_FACTOR (parameter, scalar) is the scaling factor used when NORMALIZATION_RULE is Scale.'  'TRANSFORM_DATA (query, cell) applies TRANSFORMATION_RULE to a regions-by-datapoints matrix and returns the transformed data.'  'INV_TRANSFORM_DATA (query, cell) applies the inverse of TRANSFORMATION_RULE to recover regional-value vectors from a transformed representation.'  'NORMALIZE_DATA (query, cell) applies NORMALIZATION_RULE to a regions-by-datapoints matrix and returns the normalised data.'  'INV_NORMALIZE_DATA (query, cell) applies the inverse of NORMALIZATION_RULE to restore the original data scale.'  'RAW_DATA (result, cell) returns the raw structural regional values as a cell array, with one column vector per subject.'  'PROCESS_DATA (query, cell) returns structural regional values processed by TRANSFORM_DATA followed by NORMALIZE_DATA, packaged as a cell array of column vectors.'  'REV_PROCESS_DATA (query, cell) returns structural regional values reconstructed by INV_NORMALIZE_DATA and INV_TRANSFORM_DATA, packaged as a cell array of column vectors.'  'EXTRACT_DATA (query, cell) extracts structural regional values from all SubjectST objects in GR_LIST and returns a cell array of region-by-1 vectors.'  'VOI_DICT_LIST (query, cell) extracts the variables-of-interest dictionaries from all subjects in GR_LIST.'  'MEMORIZE_DATA (query, empty) memorizes the processed input data and targets for later neural-network training.' };
			prop_description = nndatasetprocess_structural_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(NNDatasetProcess_Structural, POINTER) returns settings of POINTER of NNDatasetProcess_Structural.
			%  SETTINGS = DPROC.GETPROPSETTINGS(NNDatasetProcess_Structural, POINTER) returns settings of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPSETTINGS(DPROC) and Element.GETPROPSETTINGS('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNDatasetProcess_Structural.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % NNDatasetProcess_Structural.WAITBAR
					prop_settings = Format.getFormatSettings(4);
				case 11 % NNDatasetProcess_Structural.GR_LIST
					prop_settings = 'Group';
				case 12 % NNDatasetProcess_Structural.TRANSFORMATION_RULE
					prop_settings = {'None', 'First derivative'};
				case 13 % NNDatasetProcess_Structural.NORMALIZATION_RULE
					prop_settings = {'None', 'Scale'};
				case 14 % NNDatasetProcess_Structural.SCALE_FACTOR
					prop_settings = Format.getFormatSettings(11);
				case 15 % NNDatasetProcess_Structural.TRANSFORM_DATA
					prop_settings = Format.getFormatSettings(16);
				case 16 % NNDatasetProcess_Structural.INV_TRANSFORM_DATA
					prop_settings = Format.getFormatSettings(16);
				case 17 % NNDatasetProcess_Structural.NORMALIZE_DATA
					prop_settings = Format.getFormatSettings(16);
				case 18 % NNDatasetProcess_Structural.INV_NORMALIZE_DATA
					prop_settings = Format.getFormatSettings(16);
				case 19 % NNDatasetProcess_Structural.RAW_DATA
					prop_settings = Format.getFormatSettings(16);
				case 20 % NNDatasetProcess_Structural.PROCESS_DATA
					prop_settings = Format.getFormatSettings(16);
				case 21 % NNDatasetProcess_Structural.REV_PROCESS_DATA
					prop_settings = Format.getFormatSettings(16);
				case 22 % NNDatasetProcess_Structural.EXTRACT_DATA
					prop_settings = Format.getFormatSettings(16);
				case 23 % NNDatasetProcess_Structural.VOI_DICT_LIST
					prop_settings = Format.getFormatSettings(16);
				case 24 % NNDatasetProcess_Structural.MEMORIZE_DATA
					prop_settings = Format.getFormatSettings(1);
				case 4 % NNDatasetProcess_Structural.TEMPLATE
					prop_settings = 'NNDatasetProcess_Structural';
				case 9 % NNDatasetProcess_Structural.D
					prop_settings = 'NNDataset';
				otherwise
					prop_settings = getPropSettings@NNDatasetProcess(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNDatasetProcess_Structural.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetProcess_Structural.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DPROC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of DPROC.
			%  DEFAULT = Element.GETPROPDEFAULT(NNDatasetProcess_Structural, POINTER) returns the default value of POINTER of NNDatasetProcess_Structural.
			%  DEFAULT = DPROC.GETPROPDEFAULT(NNDatasetProcess_Structural, POINTER) returns the default value of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPDEFAULT(DPROC) and Element.GETPROPDEFAULT('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNDatasetProcess_Structural.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % NNDatasetProcess_Structural.WAITBAR
					prop_default = true;
				case 11 % NNDatasetProcess_Structural.GR_LIST
					prop_default = Format.getFormatDefault(9, NNDatasetProcess_Structural.getPropSettings(prop));
				case 12 % NNDatasetProcess_Structural.TRANSFORMATION_RULE
					prop_default = 'None';
				case 13 % NNDatasetProcess_Structural.NORMALIZATION_RULE
					prop_default = 'None';
				case 14 % NNDatasetProcess_Structural.SCALE_FACTOR
					prop_default = 1;
				case 15 % NNDatasetProcess_Structural.TRANSFORM_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 16 % NNDatasetProcess_Structural.INV_TRANSFORM_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 17 % NNDatasetProcess_Structural.NORMALIZE_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 18 % NNDatasetProcess_Structural.INV_NORMALIZE_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 19 % NNDatasetProcess_Structural.RAW_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 20 % NNDatasetProcess_Structural.PROCESS_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 21 % NNDatasetProcess_Structural.REV_PROCESS_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 22 % NNDatasetProcess_Structural.EXTRACT_DATA
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 23 % NNDatasetProcess_Structural.VOI_DICT_LIST
					prop_default = Format.getFormatDefault(16, NNDatasetProcess_Structural.getPropSettings(prop));
				case 24 % NNDatasetProcess_Structural.MEMORIZE_DATA
					prop_default = Format.getFormatDefault(1, NNDatasetProcess_Structural.getPropSettings(prop));
				case 1 % NNDatasetProcess_Structural.ELCLASS
					prop_default = 'NNDatasetProcess_Structural';
				case 2 % NNDatasetProcess_Structural.NAME
					prop_default = 'Structural Dataset Process';
				case 3 % NNDatasetProcess_Structural.DESCRIPTION
					prop_default = 'The structural dataset process (NNDatasetProcess_Structural) converts subject-level structural regional values from one or more SubjectST groups into an NNDataset of NNDataPoint_Structural. It applies optional transformation and normalisation to the regional-value vectors and attaches the variables of interest associated with each subject.';
				case 4 % NNDatasetProcess_Structural.TEMPLATE
					prop_default = Format.getFormatDefault(8, NNDatasetProcess_Structural.getPropSettings(prop));
				case 5 % NNDatasetProcess_Structural.ID
					prop_default = 'NNDatasetProcess_Structural ID';
				case 6 % NNDatasetProcess_Structural.LABEL
					prop_default = 'NNDatasetProcess_Structural label';
				case 7 % NNDatasetProcess_Structural.NOTES
					prop_default = 'NNDatasetProcess_Structural notes';
				case 9 % NNDatasetProcess_Structural.D
					prop_default = Format.getFormatDefault(8, NNDatasetProcess_Structural.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@NNDatasetProcess(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNDatasetProcess_Structural.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNDatasetProcess_Structural.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = DPROC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of DPROC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNDatasetProcess_Structural, POINTER) returns the conditioned default value of POINTER of NNDatasetProcess_Structural.
			%  DEFAULT = DPROC.GETPROPDEFAULTCONDITIONED(NNDatasetProcess_Structural, POINTER) returns the conditioned default value of POINTER of NNDatasetProcess_Structural.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(DPROC) and Element.GETPROPDEFAULTCONDITIONED('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNDatasetProcess_Structural.getPropProp(pointer);
			
			prop_default = NNDatasetProcess_Structural.conditioning(prop, NNDatasetProcess_Structural.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(NNDatasetProcess_Structural, PROP, VALUE) checks VALUE format for PROP of NNDatasetProcess_Structural.
			%  CHECK = DPROC.CHECKPROP(NNDatasetProcess_Structural, PROP, VALUE) checks VALUE format for PROP of NNDatasetProcess_Structural.
			% 
			% DPROC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:NNDatasetProcess_Structural:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DPROC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of DPROC.
			%   Error id: BRAPH2:NNDatasetProcess_Structural:WrongInput
			%  Element.CHECKPROP(NNDatasetProcess_Structural, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetProcess_Structural.
			%   Error id: BRAPH2:NNDatasetProcess_Structural:WrongInput
			%  DPROC.CHECKPROP(NNDatasetProcess_Structural, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNDatasetProcess_Structural.
			%   Error id: BRAPH2:NNDatasetProcess_Structural:WrongInput]
			% 
			% Note that the Element.CHECKPROP(DPROC) and Element.CHECKPROP('NNDatasetProcess_Structural')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNDatasetProcess_Structural.getPropProp(pointer);
			
			switch prop
				case 10 % NNDatasetProcess_Structural.WAITBAR
					check = Format.checkFormat(4, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 11 % NNDatasetProcess_Structural.GR_LIST
					check = Format.checkFormat(9, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 12 % NNDatasetProcess_Structural.TRANSFORMATION_RULE
					check = Format.checkFormat(5, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 13 % NNDatasetProcess_Structural.NORMALIZATION_RULE
					check = Format.checkFormat(5, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 14 % NNDatasetProcess_Structural.SCALE_FACTOR
					check = Format.checkFormat(11, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 15 % NNDatasetProcess_Structural.TRANSFORM_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 16 % NNDatasetProcess_Structural.INV_TRANSFORM_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 17 % NNDatasetProcess_Structural.NORMALIZE_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 18 % NNDatasetProcess_Structural.INV_NORMALIZE_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 19 % NNDatasetProcess_Structural.RAW_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 20 % NNDatasetProcess_Structural.PROCESS_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 21 % NNDatasetProcess_Structural.REV_PROCESS_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 22 % NNDatasetProcess_Structural.EXTRACT_DATA
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 23 % NNDatasetProcess_Structural.VOI_DICT_LIST
					check = Format.checkFormat(16, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 24 % NNDatasetProcess_Structural.MEMORIZE_DATA
					check = Format.checkFormat(1, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 4 % NNDatasetProcess_Structural.TEMPLATE
					check = Format.checkFormat(8, value, NNDatasetProcess_Structural.getPropSettings(prop));
				case 9 % NNDatasetProcess_Structural.D
					check = Format.checkFormat(8, value, NNDatasetProcess_Structural.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@NNDatasetProcess(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':NNDatasetProcess_Structural:' 'WrongInput'], ...
					['BRAPH2' ':NNDatasetProcess_Structural:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNDatasetProcess_Structural.getPropTag(prop) ' (' NNDatasetProcess_Structural.getFormatTag(NNDatasetProcess_Structural.getPropFormat(prop)) ').'] ...
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
				case 15 % NNDatasetProcess_Structural.TRANSFORM_DATA
					if isempty(varargin)
					    value = {};
					    return
					end
					
					data = varargin{1};
					
					if isempty(data)
					    value = {};
					    return
					end
					
					transformation = dproc.get('TRANSFORMATION_RULE');
					
					switch transformation
					    case 'First derivative'
					        data_tmp = data;
					        data_tmp = data_tmp(2:end, :) - data_tmp(1:end-1, :);
					        data(1:end-1, :) = data_tmp;
					        data(end, :) = 0;
					
					    otherwise
					end
					
					value = data;
					
				case 16 % NNDatasetProcess_Structural.INV_TRANSFORM_DATA
					if isempty(varargin)
					    value = {};
					    return
					end
					
					data = varargin{1};
					
					if isempty(data)
					    value = {};
					    return
					end
					
					transformation = dproc.get('TRANSFORMATION_RULE');
					
					switch transformation
					    case 'First derivative'
					        base_row = varargin{2};
					        recovered_data = base_row + cumsum([zeros(1, size(data, 2)); data(1:end-1, :)], 1);
					
					    otherwise
					        recovered_data = data;
					end
					
					value = recovered_data;
					
				case 17 % NNDatasetProcess_Structural.NORMALIZE_DATA
					if isempty(varargin)
					    value = {};
					    return
					end
					
					data = varargin{1};
					
					if isempty(data)
					    value = {};
					    return
					end
					
					normalization = dproc.get('NORMALIZATION_RULE');
					
					switch normalization
					    case 'Scale'
					        scale_factor = dproc.get('SCALE_FACTOR');
					        data = data ./ scale_factor;
					
					    otherwise
					end
					
					value = data;
					
				case 18 % NNDatasetProcess_Structural.INV_NORMALIZE_DATA
					if isempty(varargin)
					    value = {};
					    return
					end
					
					data = varargin{1};
					
					if isempty(data)
					    value = {};
					    return
					end
					
					normalization = dproc.get('NORMALIZATION_RULE');
					
					switch normalization
					    case 'Scale'
					        scale_factor = dproc.get('SCALE_FACTOR');
					        data = data .* scale_factor;
					
					    otherwise
					end
					
					value = data;
					
				case 19 % NNDatasetProcess_Structural.RAW_DATA
					rng_settings_ = rng(); rng(dproc.getPropSeed(19), 'twister')
					
					value = dproc.get('EXTRACT_DATA');
					
					rng(rng_settings_)
					
				case 20 % NNDatasetProcess_Structural.PROCESS_DATA
					X_raw = dproc.get('RAW_DATA');
					
					if isempty(X_raw)
					    value = {};
					    return
					end
					
					X = cat(2, X_raw{:});
					X_tr = dproc.get('TRANSFORM_DATA', X);
					X_tr_nor = dproc.get('NORMALIZE_DATA', X_tr);
					
					value = cell(1, size(X_tr_nor, 2));
					
					for i = 1:size(X_tr_nor, 2)
					    value{i} = X_tr_nor(:, i);
					end
					
				case 21 % NNDatasetProcess_Structural.REV_PROCESS_DATA
					if isempty(varargin)
					    value = {};
					    return
					end
					
					data = varargin{1};
					base_row = varargin{2};
					
					inv_norm_data = dproc.get('INV_NORMALIZE_DATA', data);
					inv_tran_inv_norm_data = dproc.get('INV_TRANSFORM_DATA', inv_norm_data, base_row);
					
					value = cell(1, size(inv_tran_inv_norm_data, 2));
					
					for i = 1:size(inv_tran_inv_norm_data, 2)
					    value{i} = inv_tran_inv_norm_data(:, i);
					end
					
				case 22 % NNDatasetProcess_Structural.EXTRACT_DATA
					gr_list = dproc.get('GR_LIST');
					
					value = {};
					
					if isempty(gr_list)
					    return
					end
					
					for gr_idx = 1:length(gr_list)
					    gr = gr_list{gr_idx};
					    sub_list = gr.get('SUB_DICT').get('IT_LIST');
					
					    if isempty(sub_list)
					        continue
					    end
					
					    for sub_idx = 1:length(sub_list)
					        sub = sub_list{sub_idx};
					        value{end + 1} = sub.get('ST'); %#ok<AGROW>
					    end
					end
					
				case 23 % NNDatasetProcess_Structural.VOI_DICT_LIST
					gr_list = dproc.get('GR_LIST');
					
					value = {};
					
					if isempty(gr_list)
					    return
					end
					
					gr_list_name = cellfun(@(gr) gr.get('ID'), gr_list, 'UniformOutput', false);
					
					for gr_idx = 1:length(gr_list)
					    gr = gr_list{gr_idx};
					    sub_list = gr.get('SUB_DICT').get('IT_LIST');
					
					    if isempty(sub_list)
					        continue
					    end
					
					    voi_dict_list = cellfun( ...
					        @(sub) sub.get('VOI_DICT'), ...
					        sub_list, ...
					        'UniformOutput', false ...
					        );
					
					    % Add group information only if missing.
					    if ~any(strcmp('group', voi_dict_list{1}.get('KEYS')))
					
					        group_idx = find(strcmp(gr.get('ID'), gr_list_name), 1);
					
					        if isempty(group_idx)
					            error('Group ID "%s" was not found in gr_list_name.', gr.get('ID'))
					        end
					
					        group_voi = VOICategoric( ...
					            'ID', 'group', ...
					            'CATEGORIES', gr_list_name, ...
					            'V', group_idx ...
					            );
					
					        cellfun( ...
					            @(voi_dict) voi_dict.get('ADD', group_voi), ...
					            voi_dict_list, ...
					            'UniformOutput', false ...
					            );
					    end
					
					    value = [value voi_dict_list]; %#ok<AGROW>
					end
					
				case 24 % NNDatasetProcess_Structural.MEMORIZE_DATA
					wb = braph2waitbar(dproc.get('WAITBAR'), 0, 'Memorizing processed structural dataset ...');
					
					start = tic;
					pause(0.5)
					
					d = dproc.memorize('D');
					
					braph2waitbar(wb, 0.25, ...
					    ['Memorizing input data - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
					
					dproc.memorize('RAW_DATA');
					d.memorize('INPUTS');
					
					braph2waitbar(wb, 0.75, ...
					    ['Memorizing targets - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
					
					d.memorize('TARGETS');
					
					braph2waitbar(wb, 'close')
					
					value = {};
					
				case 9 % NNDatasetProcess_Structural.D
					rng_settings_ = rng(); rng(dproc.getPropSeed(9), 'twister')
					
					processed_data_list = dproc.get('PROCESS_DATA');
					voi_dict_list = dproc.get('VOI_DICT_LIST');
					
					it_list = cellfun(@(data, voi_dict) NNDataPoint_Structural( ...
					    'FEATURES', {data}, ...
					    'VOI_DICT', voi_dict), ...
					    processed_data_list, voi_dict_list, ...
					    'UniformOutput', false);
					
					dp_list = IndexedDictionary( ...
					    'IT_CLASS', 'NNDataPoint_Structural', ...
					    'IT_LIST', it_list ...
					    );
					
					value = NNDataset( ...
					    'DP_CLASS', 'NNDataPoint_Structural', ...
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
