
# SAMI2

[![DOI](https://zenodo.org/badge/336382754.svg)](https://zenodo.org/badge/latestdoi/336382754)

The purpose of this site is to freely distribute the low to mid-latitude ionosphere code SAMI2 (**S**ami2 is **A**nother **M**odel of the **I**onosphere), which was developed at the U.S. Naval Research Laboratory (NRL). It is hoped that the code will be used for research and education, and that the code can be improved through community feedback. The code was originally developed by Drs. J.D. Huba and G. Joyce; Dr. M. Swisdak has made a number of improvements and corrections.

SAMI2 treats the dynamic plasma and chemical evolution of seven ion species (H+, He+, N+, O+, N2+, NO+, and O2+) in the altitude range 85 km to 20,000 km. This corresponds to a latitudinal extent of (+/-)62.5 degrees about the magnetic equator. The ion continuity and momentum equations can be solved for all 7 species; the temperature equation is solved for H+, He+, O+, and the electrons. SAMI2 models the plasma along the earth's geomagnetic field from hemisphere to hemisphere; an offset, tilted dipole field is used. The code includes a modeled E x B drift of the plasma, as well as ion inertia in the ion momentum equation for motion along the dipole field line. The code uses a fixed, nonorthogonal grid in which one coordinate axis is aligned with the geomagnetic field. The neutral species are specified using the empirical models NRLMSISE00 and HWM93.

Additional resources include:
- A more detailed description of [the source code](source_description.md)
- A description of the [IDL graphics routines](graphics.md)
- [A tutorial](tutorial.md) which describes how to compile and run SAMI2, including some examples
- [A presentation](isss10_0.pdf) describing SAMI2 which was given at the 10th International School/Symposium for Space Simulations (ISSS-10)

**Principal Investigator**  
J.D. Huba  
Plasma Physics Division  
Naval Research Laboratory  

# Changelog for SAMI2 version 1.00
J.D. Huba, 3/11

****************************************************************

02/10/2011:

Changes from sami2-0.98 to sami2-1.00:

1. The `vnormal` subroutine has been rewritten
   (i.e., corrected) in `grid-1.00.f`.

2. The factor `ch1` in the subroutine
   `photprod` has been changed from `1.e38`
   to `1.e22` (line 933). The larger value 
   caused problems at low F10.7 (below 75).

3. A subroutine `smoothz` has been added to
   smooth the ion velocity along the geomagnetic
   field (line 780).

4. The factor of `.01*ne(i,nfl)` to limit the
   velocity `vsid` in the `update` subroutine
   has been changed to `.0001*ne(i,nfl)` (line 1398).
   This factor reduces the ion velocity to zero
   for ions that are less than 0.01% of the
   electron density.

5. The upper boundary condition has been
   changed to a constant flux when the E x B
   velocity is downward (i.e., negative)
   (lines 3149 - 3204).

6. The variable `b0` in `grid-1.00.f` and
   `com-1.00.inc` has been changed to `bb0`
   (this variable is not used).
