# Source Code Description

### `sami2-1.00.f`

The main code that calculates the evolution of the low- to mid-latitude ionosphere. SAMI2 treats the dynamic plasma and chemical evolution of seven ion species (H+, He+, N+, O+, N2+, NO+, and O2+) in the altitude range 85 km to 20,000 km. This corresponds to a latitudinal extent of (+/-)62.5 degrees about the magnetic equator. The ion continuity and momentum equations can be solved for all 7 species; the temperature equation is solved for H+, He+, O+, and the electrons. `SAMI2`  models the plasma along the earth's geomagnetic field from hemisphere to hemisphere; an offset, tilted dipole field is used. The code includes a modeled E x B drift of the plasma, as well as ion inertia in the ion momentum equation for motion along the dipole field line. The code uses a fixed, nonorthogonal grid in which one coordinate axis is aligned with the geomagnetic field. The neutral species are specified using the empirical models `NRLMSISE00` and `HWM93`.  


||The primary output variables are the following:|
|-|--|
|	`deni(nz,nf,nion,nt)` |   ion density |
|	`ti(nz,nf,nion,nt)`  | ion temperature |
|	`vsi(nz,nf,nion,nt)`  |   ion velocity (along B) |
|   `te(nz,nf,nt)`   |  electron temperature |
|	`time(4,nt)`  |  time step, local time|
|	`glat(nz,nf)` |  geographic latitude|
|	`glon(nz,nf)`   |   geographic longitude|
|   `zalt(nz,nf)`   |   altitude|


||The array indices denote the following:|
|-|-|
|	`nz`   |    number of mesh points along the geomagnetic field line|
|	`nf`   |    number of mesh points transverse to the geomagnetic field line (i.e., number of magnetic field lines)|
|	`nion`  |   number of ion species (default: 7)|
|	`time(4,nt)`  |`time(1,nt)`: number of time steps|
|		|	   `time(2,nt)`: hour|
|		|	   `time(3,nt)`: minute|
|		|	   `time(4,nt)`: second|


|The indexing of the ion specie number |
|-|
|1: hydrogen (H)
|2: oxygen (O)
|3: nitrous oxide (NO) 
|4: molecular oxygen (O2)
|5: helium (He)
|6: molecular nitrogen (N2)
|7: nitrogen (N)


### `sami2-1.00.namelist`

||The input parameters for SAMI2.|
|-|-|
|	`fmtout`   | True: output formatted data files <br/> False: output unformatted data files|
|	`maxstep`  | The maximum number of time steps allowed.				Typically, this is a large number, e.g., 20000000.				It is set to smaller number, e.g., 10, just for testing purposes.
|	`hrmax`   |  The number of hours for the run (hr). A typical run				is for 48 hrs; the first 24 hrs allows transients				to clear the system.
|	`dt0`  |  The maximum time step allowed (sec). The default				is 30 s. This shouldn't be changed.
|	`dthr`   |   Defines how often the data is output (hr). The				default value is 0.25 (i.e., the data is dumped				every 15 min).
|	`hrpr` |  The time period that elapses before the 			data is output (hr). This should typically be			24 hr. 
|	`grad_in`  | The input altitude (km).
|	`glat_in`  | The input latitude (geographic).
|	`glon_in`  | The input longitude (geographic).
|	`fejer` | True: use the Fejer/Scherliess empirical E x B drift model				False: use the sinusoidal E x B drift model; if this is used then the magnitude of the E x B drift is given by ve01.
|	`rmin` |  Maximum altitude of the lowest field line (km). A typical value is 150 km.
|	`rmax`   |   Maximum altitude of the highest field line (km). This has to be less than 20,000 km. 
|	`altmin`   | Altitude of the base of a field line (km). The default is 85 km. 
|	`fbar` |  Value of F10.7A (3 month average of F10.7).
|	`f10p7`   |  Value of F10.7.     
|	`ap`   |  Value of Ap.
|	`year` |  Year
|	`day`  |  Day
|	`mmass`   |  Average neutral mass density. The default is 48.
|	`nion1`   |  Minimum ion specie index. The default is 1.
|	`nion2`   |  Maximum ion specie index. The default is 7.				However, one can use 4 and consider only the dominant ions in the ionosphere (H, O, NO, O2). This will speed up the run time of the code by about 30%.
|	`hrinit`  |  Local time at the start of the run (hr). The default is 0000 UT.
|	`gams` |  Determines grid spacing along the geomagnetic field.				The default is 3. As this parameter is increased,				the spacing between grid points along the field				line increases at high altitudes. As it is decreased,				the spacing becomes more uniform.
|	`gamp` |  Determines grid spacing orthogonal to the geomagnetic				field. The default is 3. As this parameter is increased,				the spacing between field lines increases at high 				altitudes. As it is decreased, the spacing becomes 				more uniform.
|	`tvn0`   |   Multiplicative factor for the neutral wind speed. The default value is 1. For example, if tvn0 = 0,  the neutral wind is turned off. 
|	`tvexb0`  |  Multiplicative factor for the E x B drift velocity. The default value is 1. For example, if  tvexb0 = 0,  the E x B drift velocity is turned off. 
|	`ve01`   |   Maximum E x B drift velocity for the sinusoidal drift model (m/sec). Typical values are 5 m/s - 30 m/s.
|	`snn` |   Multiplicative factors for the neutral density. The default values are 1. For example, the neutral O density can be decreased by 75% by setting this parameter to 1.,1.,1.,.75,1.,1.,1. where oxygen is the fourth specie.
|	`stn`  |  Multiplicative factor for the neutral temperature. The default value is 1. 
|	`denmin`  |  Miniumum ion density allowed. The default value is 1.e-6.
|	`alt_crit` | The E x B drift is exponentially decreased below this altitude with a scale length 20 km. The default value is 150 km. [This is done to allow rmin to be less than 150 km without using an extremely small time step.]
|	`cqe`  |  Constant used in the subroutine 'etemp' associated with photoelectron heating. The typical range is 3e-14 -- 8e-14. The higher this value, the lower the electron temperature above 300 km.

### `grid-1.00.f`
  
 Sets up the nonorthogonal grid.

### `grid-rminrmax.f`

 An auxiliary program that determines the values of rmin and rmax used in sami2-1.00.namelist for a given geographic latitude, longitude, and range of altitudes at this position.

### `param-1.00.inc`

 Parameters used in SAMI2. In general, the only parameters that need to be changed are `nz` (the number of grid points along the geomagnetic field line), and `nf` (the number of field lines).

 If these parameters are changed, the code must be recompiled.

### `com-1.00.inc`

 The SAMI2 variables passed through common statements.

### `README-1.00`
   
 An ASCII file that covers the Source Code Description, Tutorial, and Graphics sections.

### `makesami2-1.00`
 
 A makefile for SAMI2-1.00 that includes the Intel, Absoft, Lahey, and Portland Group fortran compilers.

### `deni-init.inp`

 Input file that provides initial values of the ion densities that are interpolated to the SAMI2 grid.

### `euvflux.inp`
 
 Input file that provides the EUV flux. This is the EUVAC model developed by Phil Richards (Richards et al., *J. Geophys. Res.*, 99, 8981, 1994).

### `ichem.inp`

 Input file that identifies the chemically reacting ion and neutral species.

### `phabsdt.inp`
  
 Input file that provides the photoabsorption cross-sections associated with O, N2, and O2. The data for O are from Bailey and Balan, STEP Handbook of Ionospheric Models, ed. R. Schunk, p. 184, 1996. The data for N2 and O2 are from Richards et al., *J. Geophys. Res.*, 99, 8981, 1994.

### `phiondt.inp`
  
 Input file that provides the daytime photoionization cross-sections associated with He, N, O, N2, and O2. The data for He are from Bailey and Balan, STEP Handbook of Ionospheric Models, ed. R. Schunk, p. 184, 1996. The data for N, O, N2, and O2 are from Richards et al., *J. Geophys. Res.*, 99, 8981, 1994.

### `phionnt.inp`
  
 Input file that provides the nighttime photoionization cross-sections associated with O, N2, NO, and O2. This data is obatained from Oran et al., NRL Memo Report 3984, Naval Research Laboratory, Washington, DC, 1979.

### `thetant.inp`

 Input file that provides angular information regarding nighttime photoionization processes. Based on Strobel et al., The nighttime ionosphere: E region and lower F region, *J. Geophys. Res.*, 79, 3171, 1974.

### `zaltnt.inp`
  
 Input file that provides altitude information regarding nighttime photoionization processes. Based on Strobel et al., The nighttime ionosphere: E region and lower F region, *J. Geophys. Res.*, 79, 3171, 1974.

### `nrlmsise00.f`

 An empirical model that provides the neutral densities and temperature. It has been developed by A. Hedin and M. Picone. It is an improvement over the MSIS-86 model [Hedin, *J. Geophys. Res.*, 92d, 4649, 1987].

### `hwm93.f`

 An empirical model that provides the neutral wind velocity [Hedin et al., <i>J. Geophys. Res., 96</i>, 7657, 1991].