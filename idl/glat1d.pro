; GLAT1D.PRO

; line plot of the function f 
; (defined by the user at the idl prompt) 
; as a function of latitude at
; a given universal time and altitude.

; plots to the screen and to a postscript file named 'glat1d.ps'

; --------------------------------------------------------------------------

; input at idl command line:

;   f     (mandatory)  : function to be plotted (e.g., f = alog10(dene))
;   ntm   (mandatory)  : time step to be plotted (e.g., ntm = 32)
;   zalt0 (mandatory)  : altitude (e.g., zalt0 = 400.)
;   ft    (optional)   : title of plot (e.g., ft = 'Electron Density')
;   yt    (optional)   : title of y-axis (e.g., xt = 'Electron Density')
;   nf    (mandatory)  : provided by 'read-f' or 'read-u'

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
  ywin = 480
  window,xsize=xwin,ysize=ywin

; scale the window for the postscript plot

  xps  = 6.5
  yps  = xps * ywin / xwin

; set font to simplex roman

  xyouts,.1,.1,'!3 ',/normal

; set arrays for functions to be plotted

  ggs  = fltarr(nf)
  fgs  = fltarr(nf)
  ggn  = fltarr(nf)
  fgn  = fltarr(nf)

; define the universal time and altitude

  hr   = time(1,ntm)
  phr  = string(format='(i2)',hr)
  while(((i=strpos(phr,' '))) ne -1) do strput,phr,'0',i
  min  = time(2,ntm)
  pmin = string(format='(i2)',min)
  while(((i=strpos(pmin,' '))) ne -1) do strput,pmin,'0',i
  t    = phr+pmin+' UT'
  pz   = string(format='(i5)',zalt0)
  z    = 'Altitude: '+pz+' km'

; set the x and y ranges (i.e., min and max values)

  xr=[min(glat),max(glat)]
  yr=[min(f),max(f)]

; set specific x and y ranges

;  xr=[-30,30]
  yr=[5.,7.]

; set up the plot axes, titles, and labels (but no data)

  plot,ggs,fgs,/nodata,xrange=xr,yrange=yr,xstyle=1,ystyle=1,$
    xtitle='Geographic Latitude',title=ft,charsize=1.2,color=0,$
    ytitle=yt

; interpolate to find the values of fgs, ggs, fgn, ggn

  nzh   = ( nz - 1 ) / 2

  for j = nf-1,1,-1 do begin 
    izgs = 1 
    for iz = 0,nzh do begin
      if zalt(iz,j) lt zalt0 and zalt(iz+1,j) ge zalt0 then izgs=iz 
    endfor
    izgn = nzh
    for iz = nzh+1,nz-1 do begin
      if zalt(iz,j) lt zalt0 and zalt(iz-1,j) ge zalt0 then izgn=iz 
    endfor
    delzs =   ( zalt0            - zalt(izgs,j) ) $
              / ( zalt(izgs+1,j) - zalt(izgs,j) )
    delzn =   ( zalt0            - zalt(izgn,j) ) $
              / ( zalt(izgn-1,j) - zalt(izgn,j) )
    delf1s   = delzs * ( f(izgs+1,j,ntm) - f(izgs,j,ntm) )
    delf1n   = delzn * ( f(izgn-1,j,ntm) - f(izgn,j,ntm) )
    delglats = delzs * ( glat(izgs+1,j) - glat(izgs,j) )
    delglatn = delzn * ( glat(izgn-1,j) - glat(izgn,j) )
    fgs(j)  = f(izgs,j,ntm) + delf1s
    ggs(j)  = glat(izgs,j) + delglats
    fgn(j)  = f(izgn,j,ntm) + delf1n
    ggn(j)  = glat(izgn,j) + delglatn
    if  izgs eq 1   then fgs(j) = -1.e6*max(f) 
    if  izgn eq nzh then fgn(j) = -1.e6*max(f) 
  endfor

  oplot,ggs,fgs,color=0,psym=1
  oplot,ggn,fgn,color=0,psym=1

; print the universal time and altitude

  xp = .2
  yp = .25
  xyouts,xp,yp,t,size=1.2,color=0,/normal
  xp = .2
  yp = .22
  xyouts,xp,yp,z,size=1.2,color=0,/normal

; -----------------------
; set plot to postscript
; -----------------------

  set_plot,'ps'

  device,file='glat1d.ps',xsize=xps,ysize=yps,/inches,$
         xoffset=1,yoffset=2

; set up the plot axes, titles, and labels (but no data)

  plot,ggs,fgs,/nodata,xrange=xr,yrange=yr,xstyle=1,ystyle=1,$
    xtitle='Geographic Latitude',title=ft,charsize=1.2,color=0,$
    ytitle=yt

; plot the data

  oplot,ggs,fgs,color=0,psym=1
  oplot,ggn,fgn,color=0,psym=1

; print the universal time and altitude

  xp = .2
  yp = .25
  xyouts,xp,yp,t,size=1.2,color=0,/normal
  xp = .2
  yp = .22
  xyouts,xp,yp,z,size=1.2,color=0,/normal

; close the postscipt file

  device,/close

; reset the display to the screen

  set_plot,'x'

end
