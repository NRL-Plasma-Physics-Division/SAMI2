; READ-U.PRO

; reads in selected data arrays from sami2-0.95a for unformatted data

; default:

;   time.dat
;   deniu.dat
;   glatu.dat
;   zaltu.dat

; uncomment other data arrays of interest

; the following parameters should be edited if they have changed
; (they are defined in param-0.95a.inc)

  nz    = 101  
  nion  = 7    
  nf    = 60  
  nt    = 96

; define directory of data files
; default is current directory

  dir = '../example3/'

; time data (formatted)

  close,1
  time = fltarr(4,nt)
  openr,1,dir+'time.dat'
  print,' reading time'
  readf,1,time

; ion density data


  close,1
  deni    = fltarr(nz,nf,nion,nt)
  denitmp = fltarr(nz,nf,nion)
  openr,1,dir+'deniu.dat',/f77_unformatted
  print,' reading deni '
  for i = 0,nt-1 do begin
    readu,1,denitmp
    deni(*,*,*,i) = denitmp
  endfor

; calculation of the electron density

  dene = total(deni,3)

; geophysical latitude

  close,1
  glat = fltarr(nz,nf)
  openr,1,dir+'glatu.dat',/f77_unformatted
  print,' reading glat'
  readu,1,glat

; geophyscial longitude

;  close,1
;  glon = fltarr(nz,nf)
;  openr,1,dir+'glonu.dat',/f77_unformatted
;  print,' reading glon'
;  readu,1,glon

; altitude

  close,1
  zalt = fltarr(nz,nf)
  openr,1,dir+'zaltu.dat',/f77_unformatted
  print,' reading zalt'
  readu,1,zalt

; ion temperature

;  close,1
;  ti   = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'tiu.dat',/f77_unformatted
;  print,' reading ti'
;  readu,1,ti

; electron temperature

;  close,1
;  te   = fltarr(nz,nf,nt)
;  openr,1,dir+'teu.dat',/f77_unformatted
;  print,' reading te'
;  readu,1,te

; ion velocity along the geomagnetic field

;  close,1
;  vsi  = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'vsiu.dat',/f77_unformatted
;  print,' reading vsi'
;  readu,1,vsi

; neutral density

;  close,1
;  denn  = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'denn.dat',/f77_unformatted
;  print,' reading denn'
;  readu,1,denn

; assorted diagnostic arrays

;  close,1
;  u1    = fltarr(nz,nf,nt)
;  openr,1,dir+'u1u.dat',/f77_unformatted
;  print,' reading u1'
;  readu,1,u1

;  close,1
;  u2    = fltarr(nz,nf,nt)
;  openr,1,dir+'u2u.dat',/f77_unformatted
;  print,' reading u2'
;  readu,1,u2

;  close,1
;  u3  = fltarr(nz,nf,nt)
;  openr,1,dir+'u3u.dat',/f77_unformatted
;  print,' reading u3'
;  readu,1,u3

;  close,1
;  u4  = fltarr(nz,nf,nt)
;  openr,1,dir+'u4u.dat',/f77_unformatted
;  print,' reading u4'
;  readu,1,u4

;  close,1
;  u5  = fltarr(nz,nf,nt)
;  openr,1,dir+'u5u.dat',/f77_unformatted
;  print,' reading u5'
;  readu,1,u5

;  close,1
;  t1  = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'t1u.dat',/f77_unformatted
;  print,' reading t1'
;  readu,1,t1

;  close,1
;  t2 = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'t2u.dat',/f77_unformatted
;  print,' reading t2'
;  readu,1,t2

;  close,1
;  t3 = fltarr(nz,nf,nion,nt)
;  openr,1,dir+'t3u.dat',/f77_unformatted
;  print,' reading t3'
;  readu,1,t3

; set the color table 

  device,true=24
  device,de=0
  loadct,39

  end
