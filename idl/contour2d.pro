; CONTOUR.PRO

; color contour plot of the function f 
; (defined by the user at the idl prompt) 
; as a function of geographic latitude and 
; altitude at a given universal time.

; puts the contour plot to the screen and to a 
; postscript file named 'contour.ps'

; --------------------------------------------------------------------------

; input at idl command line:

;   f  (mandatory)   : function to be plotted (e.g., f = alog10(denee))
;   ntm (mandatory)  : time step to be plotted (e.g., ntm = 32)
;   time, glat, zalt, nf (mandatory): already defined if
;                                      data is read in using read-u
;                                      or read-f
;   cbt (optional)   : caption for color bar (e.g., cbt = 'log n!de!n')
;   ft  (optional)   : title of plot (e.g., ft = 'Electron Density')

; --------------------------------------------------------------------------

; -----------------------
; set plot to the screen
; -----------------------

  set_plot,'x'

; set to a single window

  !p.multi=0

; set the background to white 
; (instead of the default which is black)

  !p.background=65535

; set the window size

  xwin = 480 
  ywin = 360
  window,xsize=xwin,ysize=ywin

; scale the window for the postscript plot

  xps  = 6.5
  yps  = xps * ywin / xwin

; position and size of the color bar

  posc = [.65,.8,.9,.8]
  xszc = ( posc(2) - posc(0) ) * xps
  yszc = ( posc(3) - posc(1) ) * yps
  xstc = posc(0) * xps
  ystc = posc(1) * yps
  xszw = ( posc(2) - posc(0) ) * xwin

; set font to simplex roman

  xyouts,.5,.5,'!3 ',/normal 

; set global minimum and maximum values

  fmn    = min(f) * .95
  fmx    = max(f) * 1.05
  glatmn  = min(glat)
  glatmx  = max(glat)
  zaltmn  = min(zalt)
  zaltmx  = max(zalt)

; set specific minimum and maximun values

;  fmn    = 3.
;  fmx    = 7.
;  fmn    = 0
;  fmx    = 5.e4
;  glatmn  = -40.
;  glatmx  = 20.
;  zaltmn  = 0.
;  zaltmx  = 2000.

; define the universal time

  hr   = time(1,ntm)
  phr  = string(format='(i2)',hr)
  while(((i=strpos(phr,' '))) ne -1) do strput,phr,'0',i
  min  = time(2,ntm)
  pmin = string(format='(i2)',min)
  while(((i=strpos(pmin,' '))) ne -1) do strput,pmin,'0',i
  t    = phr+pmin+' UT'

; set the contour levels

  nsteps  = 56
  dellevs = ( fmx - fmn ) / nsteps
  nlevs   = fmn + findgen(nsteps) * dellevs

; plot the contour

  contour,f(*,1:nf-1,ntm),$
          glat(*,1:nf-1),$
          zalt(*,1:nf-1),$
          levels=nlevs,/cell_fill,$
          yrange=[zaltmn,zaltmx],xstyle=1,$
          xrange=[glatmn,glatmx],ystyle=1,$
          xtitle='Geographic Latitude',$
          ytitle='Altitude (km)',$
          charsize=1.2,$
          title=ft,color=0

; print the time

  xp = .2
  yp = .85
  xyouts,xp,yp,t,size=1.2,color=0,/normal

; put contour lines on plot
; (set the number of contour levels to a smaller number)
; uncomment the following lines for contour lines

;  nsteps  = 12
;  dellevs = ( fmx - fmn ) / nsteps
;  nlevsc  = fmn + findgen(nsteps) * dellevs
;  contour,f(*,1:nf-1,ntm),$
;          glat(*,1:nf-1),$
;          zalt(*,1:nf-1),$
;          levels=nlevsc,/overplot,color=0

; put grid points on plot
; uncomment the following lines to put the grid points on the plot

;  for n = 0,nf-1 do begin
;  oplot,glat(*,n),zalt(*,n),psym=3,color=0
;  endfor

; put geomagnetic field lines on plot
; uncomment the following lines to put the field lines on the plot

;  for n = 0,nf-1 do begin
;  oplot,glat(*,n),zalt(*,n),color=0
;  endfor

; colorbar
; two formats for the label are provided (e8.1 and f3.1)
; depending on the values of the function plotted

  bar  = bindgen(256) # replicate(1b,20) 
  tvscl,congrid(bar,xszw,20,/interp),posc(0),posc(1),/normal
  cxs = fltarr(3) 
  cxs = [fmn,.5*(fmn+fmx),fmx]
;  cxsl= [string(format='(e8.1)',cxs(0)),$
;         string(format='(e8.1)',cxs(1)),$
;         string(format='(e8.1)',cxs(2))]
  cxsl= [string(format='(f3.1)',cxs(0)),$
         string(format='(f3.1)',cxs(1)),$
         string(format='(f3.1)',cxs(2))]
  plot,cxs,/noerase,/nodata,position=posc,xticks=2,$ 
       ystyle=4,xstyle=1,charsize=1.,$
       xtickname=cxsl,color=0,$
       xtitle=cbt

; -----------------------
; set plot to postscript
; -----------------------

  set_plot,'ps'
  device,file='contour2d.ps',bits_per_pixel=8,/color, $
         xsize=xps,ysize=yps,/inches,xoffset=1.25

  contour,f(*,1:nf-1,ntm),$
          glat(*,1:nf-1),$
          zalt(*,1:nf-1),$
          levels=nlevs,/cell_fill,$
          xrange=[glatmn,glatmx],xstyle=1,$
          yrange=[zaltmn,zaltmx],ystyle=1,$
          xtitle='Geographic Latitude',$
          ytitle='Altitude (km)',$
          charsize=1.2,$
          title=ft

; print the universal time

  xp = .2
  yp = .8
  xyouts,xp,yp,t,size=1.2,color=0,/normal

; put contour lines on plot
; (set the number of contour levels to a smaller number)
; uncomment the following lines for contour lines

;  nsteps  = 12
;  dellevs = ( fmx - fmn ) / nsteps
;  nlevsc  = fmn + findgen(nsteps) * dellevs
;  contour,f(*,1:nf-1,ntm),$
;          glat(*,1:nf-1),$
;          zalt(*,1:nf-1),$
;          levels=nlevsc,/overplot,color=0

; put grid points on plot
; uncomment the following lines to put the grid points on the plot

;  for nf = 0,nf-1 do begin
;  oplot,glat(*,1:nf-1),zalt(*,1:nf-1),psym=3,color=0
;  endfor

; put geomagnetic field lines on plot
; uncomment the following lines to put the field lines on the plot

;  for nf = 0,nf-1 do begin
;  oplot,glat(*,1:nf-1),zalt(*,1:nf-1),color=0
;  endfor

; colorbar
; two formats for the label are provided (e8.1 and f3.1)
; depending on the values of the function plotted

  bar  = bindgen(256); # replicate(1b,20) 
  tvscl,congrid(bar,xwin,20,/interp),$
        xstc,ystc,xsize=xszc,ysize=.2,/inches
  cxs = fltarr(3) 
  cxs = [fmn,.5*(fmn+fmx),fmx] 
;  cxsl= [string(format='(e8.1)',cxs(0)),$
;         string(format='(e8.1)',cxs(1)),$
;         string(format='(e8.1)',cxs(2))]
  cxsl= [string(format='(f3.1)',cxs(0)),$
         string(format='(f3.1)',cxs(1)),$
         string(format='(f3.1)',cxs(2))]
  plot,cxs,/noerase,/nodata,position=posc,xticks=2,$ 
       ystyle=4,xstyle=1,charsize=1.,$
       xtickname=cxsl,color=0,$
       xtitle=cbt

; close the postscript file 'contour.ps'

  device,/close

; reset the display to the screen

  set_plot,'x'

end
