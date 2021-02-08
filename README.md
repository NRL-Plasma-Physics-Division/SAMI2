
# README-1.00 for SAMI2
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
