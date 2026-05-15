%% ¡header!
Spectrum < ConcreteElement (sp, spectrum) is a spectrum.

%%% ¡description!
Spectrum contains an acquired spectrum including its wavelength and intensity.

%%% ¡seealso!
RamanExperiment

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Spectrum.ID
%%%% ¡title!
Spectrum ID

%%% ¡prop!
%%%% ¡id!
Spectrum.LABEL
%%%% ¡title!
Spectrum NAME

%%% ¡prop!
%%%% ¡id!
Spectrum.CALIBRATION
%%%% ¡title!
Calibration Spectrum

%%% ¡prop!
%%%% ¡id!
Spectrum.RESEARCHER
%%%% ¡title!
Researcher's Name

%%% ¡prop!
%%%% ¡id!
Spectrum.DATE
%%%% ¡title!
Experiment Date (YYYY-MM-DD)

%%% ¡prop!
%%%% ¡id!
Spectrum.PLANT_NAME
%%%% ¡title!
Plant Name

%%% ¡prop!
%%%% ¡id!
Spectrum.PLANT_TYPE
%%%% ¡title!
Plant Type

%%% ¡prop!
%%%% ¡id!
Spectrum.PLANT_TYPE_COMMENT
%%%% ¡title!
Plant Type Comment (mutant type)

%%% ¡prop!
%%%% ¡id!
Spectrum.PLANT_AGE
%%%% ¡title!
Plant Age (days)

%%% ¡prop!
%%%% ¡id!
Spectrum.LEAF_NUMBER
%%%% ¡title!
Leaf Number

%%% ¡prop!
%%%% ¡id!
Spectrum.GROWTH_MEDIUM
%%%% ¡title!
Growth Medium

%%% ¡prop!
%%%% ¡id!
Spectrum.STRESS_TYPE
%%%% ¡title!
Stress Type

%%% ¡prop!
%%%% ¡id!
Spectrum.SETUP
%%%% ¡title!
Setup

%%% ¡prop!
%%%% ¡id!
Spectrum.LASER_WAVELENGTH
%%%% ¡title!
Laser Wavelength

%%% ¡prop!
%%%% ¡id!
Spectrum.LASER_POWER
%%%% ¡title!
Laser Power (mW)

%%% ¡prop!
%%%% ¡id!
Spectrum.ACQUISITION_TIME
%%%% ¡title!
Acquisition Time (s)

%%% ¡prop!
%%%% ¡id!
Spectrum.WAVELENGTH
%%%% ¡title!
Wavelength

%%% ¡prop!
%%%% ¡id!
Spectrum.INTENSITIES
%%%% ¡title!
Raman Spectra

%%% ¡prop!
%%%% ¡id!
Spectrum.NOTES
%%%% ¡title!
Spectrum NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the spectrum.
%%%% ¡default!
'Spectrum'

%%% ¡prop!
NAME (constant, string) is the name of the spectrum.
%%%% ¡default!
'Spectrum'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the spectrum.
%%%% ¡default!
'Spectrum contains an acquired spectrum including its wavelength and intensity.'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', sp, 'PROP', sp.DESCRIPTION, varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the spectrum.
%%%% ¡settings!
'Spectrum'

%%% ¡prop!
ID (data, string) is a few-letter code for the spectrum.
%%%% ¡default!
'Spectrum ID'
%%%% ¡gui!
pr = DistapPP_ID('EL', sp, 'PROP', Spectrum.ID);

%%% ¡prop!
LABEL (metadata, string) is an extended label of the spectrum.
%%%% ¡default!
'Spectrum label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the spectrum.
%%%% ¡default!
'Spectrum notes'

%% ¡props!

%%% ¡prop!
CALIBRATION (data, logical) determines whether it is a calibration spectrum.

%%% ¡prop!
RESEARCHER (data, option) is the researcher name.
%%%% ¡settings!
{'--', 'Alice', 'Benny', 'Chung Hao', 'Ekta', 'Gajendra', 'Ganga', 'Javier', 'Mervin', 'Michelle', 'Monika', 'Niha', 'Nivedita', 'Pil Joong', 'Praveen', 'Raju', 'Sally', 'Savita', 'Sayuj', 'Sayyid', 'Shilpi', 'Song Yi', 'Thinh', 'Yangyang', 'Zheng Yong'}

%%% ¡prop!
DATE (data, rvector) is the experiment date.
%%%% ¡default!
[2000 1 1]
%%%% ¡gui!
pr = PanelPropRVectorDate('EL', sp, 'PROP', Spectrum.DATE);

%%% ¡prop!
PLANT_NAME (data, option) is the plant name.
%%%% ¡settings!
{'--', 'Algae', 'Amaranth', 'Arabidopsis', 'Bell Pepper', 'Choy Sum', 'Lettuce', 'Kale', 'Pak Choi', 'Tobacco'}

%%% ¡prop!
PLANT_TYPE (data, option) is the plant type
%%%% ¡settings!
{'--', 'wild type', 'mutant', 'transgenic'} 

%%% ¡prop!
PLANT_TYPE_COMMENT (data, string) is the mutant type (when mutant is selected).

%%% ¡prop!
PLANT_AGE (data, scalar) is the plant age (in weeks).

%%% ¡prop!
LEAF_NUMBER (data, scalar) is the leaf number.

%%% ¡prop!
GROWTH_MEDIUM (data, option) is the growth medium.
%%%% ¡settings!
{'--', 'soil', 'hydroponics'}

%%% ¡prop!
STRESS_TYPE (data, option) is the plant stress type.
%%%% ¡settings!
{'--', 'bacterial', 'drought', 'fungal', 'high light', 'mechanical damage', 'nutrient', 'salt', 'SAS', 'spraying', 'water-logged'}

%%% ¡prop!
SETUP (data, option) is the kind of setup employed.
%%%% ¡settings!
{'--', 'Raman microscope', 'benchtop', 'portable', 'hand-held'}

%%% ¡prop!
LASER_WAVELENGTH (data, option) is the laser wavelength.
%%%% ¡settings!
{'--', '532 nm', '785 nm', '830 nm', '1064 nm'}

%%% ¡prop!
LASER_POWER (data, scalar) is the laser power.

%%% ¡prop!
ACQUISITION_TIME (data, scalar) is the Raman spectral acquisition time.

%%% ¡prop!
WAVELENGTH (data, cvector) is the vector of the wavelengths at which the spectrum is acquired.

%%% ¡prop!
WAVELENGTH_LABELS (query, stringlist) is the labels for the wavelengths.
%%%% ¡calculate!
value = arrayfun(@(wavelength) [num2str(wavelength) ' cm-1'], sp.get('WAVELENGTH')', 'UniformOutput', false);

%%% ¡prop!
INTENSITIES (data, matrix) is the intensities of the spectra (one spectrum per column).
%%%% ¡gui!
pr = PanelPropMatrix('EL', sp, 'PROP', Spectrum.INTENSITIES, ...
    'ROWNAME', sp.getCallback('WAVELENGTH_LABELS'));

%%% ¡prop!
NO_AQUISITIONS (query, scalar) is the number of acquisitions.
%%%% ¡calculate!
value = size(sp.get('INTENSITIES'), 2);

%%% ¡prop!
INTENSITY (query, cvector) is the intesity of the a spectrum.
%%%% ¡calculate!
% INTENSITY = sp.get('INTENSITY', N) returns the intenities of the N-th spectrum.
if isempty(varargin)
    value = [];
    return
end
n = varargin{1};
intensities = sp.get('INTENSITIES');
value = intensities(:, n);

%%% ¡prop!
INTENSITY_MEAN (query, cvector) is the average intesity of the spectra.
%%%% ¡calculate!
value = mean(sp.get('INTENSITIES'), 2);