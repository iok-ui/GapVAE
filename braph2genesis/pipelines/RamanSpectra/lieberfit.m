
% Lieber fit
% S is a matrix of input spectra with each observation in the rows
% order is the order of polynomial fit
% tot_iter is the number of iterations for the code to fit the baseline
function [estimated_baselines, baselined_intensities] = lieberfit(S, order, tot_iter)

warning ('off','all')

num_samp = size(S, 1); 

pix_size = size(S, 2); 

polyspec_iter = []; 
outspectrum = []; 

for j = 1:num_samp; 

    polyspec_iter = S(j,1:pix_size); 
    
  for i = 1:tot_iter;
    
    p_order=polyfit([1:pix_size],polyspec_iter,order);
    polyspec_order=polyval(p_order,[1:pix_size]);
    polyspec_iter = min(polyspec_order, polyspec_iter);
         
  end
  
  outspectrum(j,:) = S(j,:) - polyspec_iter(1,:); 

end

estimated_baselines = polyspec_iter'; 
baselined_intensities = outspectrum'; 

