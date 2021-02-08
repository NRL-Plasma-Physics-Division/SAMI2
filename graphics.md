  
# SAMI2 Graphics

  IDL graphics procedures

We use IDL for graphical output of SAMI2 data. See `IDL Issues'
at the end of ths file for some information about IDL.
The following IDL procedures can be used for SAMI2 graphics. 
Read the comments at the beginning of each procedure for needed 
inputs at the idl prompt. 

    read-f.pro

        This procedure reads in formatted data files.

    read-u.pro

        This procedure reads in unformatted data files.

    contour2d.pro

        This procedure makes a color contour plot of the function f 
        (defined by the user at the idl prompt) 
        as a function of geographic latitude and 
        altitude at a given local time. It 
        plots to the screen and to a postscript file
        contour.ps.

    zalt1d.pro

        This procedure makes a line plot of the function f 
        (defined by the user at the idl prompt) 
        as a function of altitude at
        a given local time and geographic latitude.
        It plots to the screen and to a postscript file 
        zalt1d.ps.

    glat1d.pro

        This procedure makes a line plot of the function f 
        (defined by the user at the idl prompt) 
        as a function of latitude at
        a given local time and altitude.
        It plots to the screen and to a postscript file 
        glat1d.ps.

## Test cases

The various IDL generated plots are on the SAMI2 web site.

### Example 2

This is an example of graphical output for the data
generated from Example 2 in the Tutorial
Section. This is essentially a single field line
case so the procedures contour.pro,
zalt1d.pro, glat1d.pro are not useful.

1. Edit the file read-f.pro so that nf = 3 and nt = 95.
    (Note: The value of nt can be found from the file
    time.dat; it is the first number on the last line.)
2. Start IDL - enter the commands that are after the IDL.

    IDL> .run read-f
    IDL> ntm=75
    IDL> plot,dene(50:100,1,ntm),zalt(50:100,1),yrange=[0,2000],/xlog,charsize=1.6,xr=[1.e4,1.e7]
        (This is a graph of the electron density 
        as a function of altitude along
        a geomagnetic field that passes over Millstone Hill at
        an altitude 300 km at 1900 UT.)
    IDL> ntm=15
    IDL> plot,dene(50:100,1,ntm),zalt(50:100,1),yrange=[0,2000],/xlog,charsize=1.6,xr=[1.e3,1.e6]
    IDL> oplot,deni(50:100,1,0,ntm),zalt(50:100,1),line=2
    IDL> oplot,deni(50:100,1,1,ntm),zalt(50:100,1),line=3
        (This is a graph of the electron density (solid), 
        O+ density (dash-dot), and H+ density (dash)
        as a function of altitude along
        a geomagnetic field that passes over Millstone Hill at
        an altitude 300 km at about 0400 UT.)

### Example 3

This is an example of graphical output for the data
generated from Example 3 in the Tutorial Section.

1. Edit the file read-f.pro or read-u.pro
        so that nf = 60 depending on whether the data 
        file generated is formatted (denif.dat) or
        unformatted (deniu.dat), and nt = 190.
2. Start IDL - enter the commands that are after the IDL prompt.

    IDL> run read-f or .run read-u
    IDL> f = alog10(dene)
    IDL> ntm = 99
    IDL> .run contour2d
        (This is a color contour plot of the electron density
        as a function of latitude and altitude.)
    IDL> glat0=18.3
    IDL> .run zalt1d
        (This is  a plot of the electron density as a function of
        altitude over Arecibo.)
    IDL> zalt0=350
    IDL> .run glat1d
        (This is a plot of the electron density as a function of
        latitude at a fixed altitude 350 km.)

## Some IDL issues:

IDL is an excellent (and expensive) graphics software package from ITT (http://www.ittvis.com/language/en-US/ProductsServices/IDL.aspx). If you do not have access to a licensed copy, you can download IDL or obtain a trial CD from ITT. This trial version only runs for a limited time (7 minutes) and has several limitations (e.g., you cannot write JPEG or GIF files).

The IDL procedures provided can be edited to obtain plots with titles, axes labels, different scales, etc. Also, the procedure contour2d.pro can be edited to show grid points, magnetic field lines, and contour levels.
