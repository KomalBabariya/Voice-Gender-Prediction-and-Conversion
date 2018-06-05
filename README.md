# Voice-Gender-Prediction-and-Conversion
This project take an audio file, predicts whether a voice is male/female voice based its training on TIMIT data, 
and then converts the voice to opposite gender based on modification of source and filter design (i.e. by defining 
vocal tract differences for male and female)

To run the code is to go to the single_Sc script.

The single_Sc requires your audio file and converted file location.
The prediction and conversion goes as follows: 
-predict.m (predicts the gender)
-single_convert.m (converts the voice and saves it)
-VGC.m does the main scaling function
-istft (the time scaling function)(https://github.com/dpwe/pitchfilter/blob/master/istft.m)
-formant_filter.m (calculates the formant filters)
-my_lpc_S.m (takes a window/input signal and returns its coefficients)
-new_filt_coeff. (scales the formant and calculates the new coefficients)


-featureCal_func was used on TIMIT dataset for claculating thetas for prediction function.
