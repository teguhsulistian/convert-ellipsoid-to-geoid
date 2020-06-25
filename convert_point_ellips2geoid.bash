#Script By Teguh Sulistian
#PPKLP - BIG
#Convert Z From Ellipsoid to EGM08 

#Regriding and convert .nc to .tif for EGM2008 Model
gdal_translate -of "NetCDF" egm2008n_indo_1m.nc egm2008.tif

#Geolocation get raster value in target coordinate
cat titik.xyz | gdallocationinfo -geoloc egm2008.tif | grep "  Value: " | sed -e 's/  Value: //g' >> sampling.txt 
	paste titik_z.txt sampling.txt > undulasi.txt

#Calculate EGM Height
awk '{print $3-$4}' undulasi.txt >> elev_geoid.txt
paste undulasi.txt elev_geoid.txt > file_final.txt
sed -i -e '1iLongtitude	Latitude	h_ellips	N	h_geoid \' file_final.txt
rm sampling.txt undulasi.txt elev_geoid.txt
