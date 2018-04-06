function str  =  saving_to_memory(str,acumulated_factor,incr_load,load_factor)

jobfolder                                   =  (([str.jobfolder '\results']));
cd(jobfolder);
filename                                    =  ['Load_increment_' num2str(str.temp.incr_load)];

new_str                                     =  str;

clear old_str
new_str  =  rmfield(new_str,'assemb_matrix');
new_str  =  rmfield(new_str,'Residual');
new_str  =  rmfield(new_str,'assemb_stiffness');
new_str  =  rmfield(new_str,'assemb_force');


new_str.acumulated_factor  =  acumulated_factor;
new_str.incr_load          =  incr_load;
new_str.load_factor        =  load_factor;

switch new_str.data.formulation_type
    case 'mixed_formulation'
         switch new_str.data.formulation.mixed_type
             case 'displacement_potential_mixed_formulation'
                 new_str  =  rmfield(new_str,'Kuu');
                 new_str  =  rmfield(new_str,'Kuphi');
                 new_str  =  rmfield(new_str,'Kphiu');
                 new_str  =  rmfield(new_str,'Kee');
                 new_str  =  rmfield(new_str,'Tm_element');
                 new_str  =  rmfield(new_str,'Te_element');
             case 'full_mixed_formulation_electroelasticity_F_D0_V'
                 new_str  =  rmfield(new_str,'KuSigma_e');
                 new_str  =  rmfield(new_str,'KSigmau_e');
                 new_str  =  rmfield(new_str,'KuD0_e');
                 new_str  =  rmfield(new_str,'KD0u_e');
                 new_str  =  rmfield(new_str,'KD0phi_e');
                 new_str  =  rmfield(new_str,'KphiD0_e');
                 new_str  =  rmfield(new_str,'KDD_e');
                 new_str  =  rmfield(new_str,'KDSigma_e');
                 new_str  =  rmfield(new_str,'KSigmaD_e');
                 new_str  =  rmfield(new_str,'KD0D_e');
                 new_str  =  rmfield(new_str,'KDD0_e');
                 new_str  =  rmfield(new_str,'KD0Sigma_e');
                 new_str  =  rmfield(new_str,'KSigmaD0_e');
                 new_str  =  rmfield(new_str,'KD0D0_e');
                 new_str  =  rmfield(new_str,'TSigma_e');
                 new_str  =  rmfield(new_str,'TD_e');
                 new_str  =  rmfield(new_str,'TD0_e');
                 new_str  =  rmfield(new_str,'Kuu');
                 new_str  =  rmfield(new_str,'Kuphi');
                 new_str  =  rmfield(new_str,'Kphiu');
                 new_str  =  rmfield(new_str,'Kee');
                 new_str  =  rmfield(new_str,'Tm_element');
                 new_str  =  rmfield(new_str,'Te_element');
                 
                 new_str  =  rmfield(new_str,'KuSigmaF');
                 new_str  =  rmfield(new_str,'KuSigmaH');
                 new_str  =  rmfield(new_str,'KuSigmaJ');
                 new_str  =  rmfield(new_str,'KuSigmaV');
                 new_str  =  rmfield(new_str,'KuV');
                 new_str  =  rmfield(new_str,'KFF');
                 new_str  =  rmfield(new_str,'KFH');
                 new_str  =  rmfield(new_str,'KFJ');
                 new_str  =  rmfield(new_str,'KFV');
                 new_str  =  rmfield(new_str,'KHH');
                 new_str  =  rmfield(new_str,'KHJ');
                 new_str  =  rmfield(new_str,'KHV');
                 new_str  =  rmfield(new_str,'KJJ');
                 new_str  =  rmfield(new_str,'KJV');
                 new_str  =  rmfield(new_str,'KVV');
                 new_str  =  rmfield(new_str,'KFSigmaF');
                 new_str  =  rmfield(new_str,'KHSigmaH');
                 new_str  =  rmfield(new_str,'KJSigmaJ');
                 new_str  =  rmfield(new_str,'KVSigmaV');
                 new_str  =  rmfield(new_str,'KuD0');
                 new_str  =  rmfield(new_str,'KD0phi');
                 new_str  =  rmfield(new_str,'KphiD0');
                 new_str  =  rmfield(new_str,'KFD0');
                 new_str  =  rmfield(new_str,'KHD0');
                 new_str  =  rmfield(new_str,'KJD0');
                 new_str  =  rmfield(new_str,'KVD0');
                 new_str  =  rmfield(new_str,'KD0F');
                 new_str  =  rmfield(new_str,'KD0H');
                 new_str  =  rmfield(new_str,'KD0J');
                 new_str  =  rmfield(new_str,'KD0V');
                 new_str  =  rmfield(new_str,'KD0D0');
                 new_str  =  rmfield(new_str,'KSigmaVD0');
                 new_str  =  rmfield(new_str,'KD0u');
                 new_str  =  rmfield(new_str,'KD0SigmaV');
                 new_str  =  rmfield(new_str,'KuSigma');
                 new_str  =  rmfield(new_str,'KSigmau');
                 new_str  =  rmfield(new_str,'KDSigma');
                 new_str  =  rmfield(new_str,'KSigmaD');
                 new_str  =  rmfield(new_str,'KDD0');
                 new_str  =  rmfield(new_str,'KD0D');
                 new_str  =  rmfield(new_str,'KDD');
                 new_str  =  rmfield(new_str,'KSigmaD0');
                 new_str  =  rmfield(new_str,'KD0Sigma');
                 new_str  =  rmfield(new_str,'TF_element');
                 new_str  =  rmfield(new_str,'TH_element');
                 new_str  =  rmfield(new_str,'TJ_element');
                 new_str  =  rmfield(new_str,'TSigmaF_element');
                 new_str  =  rmfield(new_str,'TSigmaH_element');
                 new_str  =  rmfield(new_str,'TSigmaJ_element');
                 new_str  =  rmfield(new_str,'TD0_element');
                 new_str  =  rmfield(new_str,'TV_element');
                 new_str  =  rmfield(new_str,'TSigmaV_element');
                 new_str  =  rmfield(new_str,'TD0');
                 new_str  =  rmfield(new_str,'TD');
                 
                 
                 
                 
                 
%                 str  =  rmfield(str,'');
%                 str  =  rmfield(str,'');
                 
                  
                 
                 
                 
         end
end

                 
                 
                 
save(filename,'new_str','-v7.3');

