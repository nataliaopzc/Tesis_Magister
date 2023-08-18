modelo={'Lambert','Albani','Takemura','Ohgaito','MIROC-ESM','MRI-CGCM3'};
userdir='/home/natalia/Documentos/DATA/TesisI/cgenie/';
Sol=load(fullfile(userdir,'Solubility','Global',['worjh2.det_Fe_Sol_calculated.' modelo '_LGM_x1.dat']));
Sol2=load(fullfile(userdir,'Solubility',['worjh2.det_Fe_sol.' modelo '_LGM.dat']));
Dust=load(fullfile(userdir,'genie-forcings','Global',['worjh2.Fe' modelo '_LGM_Sol_calculated_Dust_Control_x1/biogem_force_flux_sed_det_SUR.dat']));
Dust2=load(['/home/natalia/Documentos/Tesis/Flujos_de_polvo/Globales_Moles/' modelo '/' modelo '.nc_annualflux_molperyr.36x36_level10.dat']);