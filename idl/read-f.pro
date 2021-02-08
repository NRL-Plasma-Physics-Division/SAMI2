; READ-F.PRO

; reads in selected data arrays from sami2-0.95a for formatted data

; default:

;   time.dat
;   denif.dat
;   glatf.dat
;   zaltf.dat

; uncomment other data arrays of interest

; the following parameters should be edited if they have changed

; these are defined in param-0.95a.inc

  nz    = 101  
  nion  = 7    
  nf    = 3   

; this is the first number on the last line of time.dat

  nt    = 96

; define directory of data files
; default is current directory

  dir = '../example2/'

; time data (formatted)

  close,1
  time = fltarr(4,nt)
  openr,1,dir+'time.dat'
  print,' reading time'
  readf,1,time

; ion density data

  close,1
  deni = fltarr(nz,nf,nion,nt)
  openr,1,dir+'denif.dat'
  print,' reading deni '
  readf,1,deni

; calculation of the electron density

  dene = total(deni,3)

; geophysical latitude

  close,1
  glat = fltarr(nz,nf)
  openr,1,dir+'glatf.dat'
  print,' reading glat'
  readf,1,glat

; geophyscial longitude

  close,1
  glon = fltarr(nz,nf)
  openr,1,dir+'glonf.dat'
  print,' reading glon'
  readf,1,glon

; altitude

  close,1
  zalt = fltarr(nz,nf)
  openr,1,dir+'zaltf.dat'
  print,' reading zalt'
  readf,1,zalt

; ion temperature

;  close,1
;  ti   = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'tif.dat'
;  print,' reading ti'
;  readf,1,ti

; electron temperature

;  close,1
;  te   = fltarr(nz,nf,nt)
;  openr,1,dir+'tef.dat'
;  print,' reading te'
;  readf,1,te

; ion velocity along the geomagnetic field

;  close,1
;  vsi  = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'vsif.dat'
;  print,' reading vsi'
;  readf,1,vsi

; neutral density

;  close,1
;  denn  = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'denn.dat'
;  print,' reading denn'
;  readf,1,denn

; assorted diagnostic arrays

;  close,1
;  u1    = fltarr(nz,nf,nt)
;  openr,1,dir+'u1f.dat'
;  print,' reading u1'
;  readf,1,u1

;  close,1
;  u2    = fltarr(nz,nf,nt)
;  openr,1,dir+'u2f.dat'
;  print,' reading u2'
;  readf,1,u2

;  close,1
;  u3  = fltarr(nz,nf,nt)
;  openr,1,dir+'u3f.dat'
;  print,' reading u3'
;  readf,1,u3

;  close,1
;  u4  = fltarr(nz,nf,nt)
;  openr,1,dir+'u4f.dat'
;  print,' reading u4'
;  readf,1,u4

;  close,1
;  u5  = fltarr(nz,nf,nt)
;  openr,1,dir+'u5f.dat'
;  print,' reading u5'
;  readf,1,u5

;  close,1
;  t1  = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'t1f.dat'
;  print,' reading t1'
;  readf,1,t1

;  close,1
;  t2 = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'t2f.dat'
;  print,' reading t2'
;  readf,1,t2

;  close,1
;  t3 = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'t3f.dat'
;  print,' reading t3'
;  readf,1,t3

; set the color table 

  device,true=24
  device,de=0
  loadct,39

  end
