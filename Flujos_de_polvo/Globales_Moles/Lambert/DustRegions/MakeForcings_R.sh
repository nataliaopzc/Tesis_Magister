cp -r worjh2.FeLambert2015_SA_level1 worjh2.FeLambert2015_SP_level1
cp -r worjh2.FeLambert2015_SA_level1 worjh2.FeLambert2015_NP_level1
cp -r worjh2.FeLambert2015_SA_level1 worjh2.FeLambert2015_CP_level1

for f in {2..10}; do
cp -r worjh2.FeLambert2015_SA_level1 worjh2.FeLambert2015_SA_level$f
cp -r worjh2.FeLambert2015_SA_level1 worjh2.FeLambert2015_SP_level$f
cp -r worjh2.FeLambert2015_SA_level1 worjh2.FeLambert2015_NP_level$f
cp -r worjh2.FeLambert2015_SA_level1 worjh2.FeLambert2015_CP_level$f
done


 for l in {1..10}; do
cp ./DustRegions/Lambert_SA_Level$l.dat worjh2.FeLambert2015_SA_level$l/biogem_force_flux_sed_det_SUR.dat
#cp ./DustSources/Dust_CAsia_Level$l.dat worjh2.FeLambert2015_CAsia_level$l/biogem_force_flux_sed_det_SUR.dat
#cp ./DustSources/Dust_EAsia_Level$l.dat worjh2.FeLambert2015_EAsia_level$l/biogem_force_flux_sed_det_SUR.dat
#cp ./DustSources/Dust_NAfr_Level$l.dat worjh2.FeLambert2015_NAfr_level$l/biogem_force_flux_sed_det_SUR.dat
#cp ./DustSources/Dust_NAmSW_Level$l.dat worjh2.FeLambert2015_NAmSW_level$l/biogem_force_flux_sed_det_SUR.dat
#cp ./DustSources/Dust_SAfr_Level$l.dat worjh2.FeLambert2015_SAfr_level$l/biogem_force_flux_sed_det_SUR.dat
#cp ./DustSources/Dust_SAmAtac_Level$l.dat worjh2.FeLambert2015_SAmAtac_level$l/biogem_force_flux_sed_det_SUR.dat
#cp ./DustSources/Dust_SAmPat_Level$l.dat worjh2.FeLambert2015_SAmPat_level$l/biogem_force_flux_sed_det_SUR.dat
done
