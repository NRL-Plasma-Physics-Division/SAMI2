; ZALT1D.PRO

; line plot of the function f 
; (defined by the user at the idl prompt) 
; as a function of altitude at
; a given universal time and geographic latitude.

; plots to the screen and to a postscript file named 'zalt1d.ps'

; --------------------------------------------------------------------------

; input at idl command line:

;   f     (mandatory)  : function to be plotted (e.g., f = alog10(denee))
;   ntm   (mandatory)  : time step to be plotted (e.g., ntm = 32)
;   glat0 (mandatory)  : geographic latitude (e.g., glat0 = 18.3)
;   ft    (optional)   : title of plot (e.g., ft = 'Electron Density')
;   xt    (optional)   : title of x-axis (e.g., xt = 'Electron Density')
;   nf    (mandatory)  : provided by 'read-u' or 'read-f'

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

; set arrays for functions to be plotted (i.e., fg vs zg)

  zg   = fltarr(nf)
  fg   = fltarr(nf)

; define the universal time and latitude

  hr   = time(1,ntm)
  phr  = string(format='(i2)',hr)
  while(((i=strpos(phr,' '))) ne -1) do strput,phr,'0',i
  min  = time(2,ntm)
  pmin = string(format='(i2)',min)
  while(((i=strpos(pmin,' '))) ne -1) do strput,pmin,'0',i
  t    = phr+pmin+' UT'
  pg   = string(format='(f5.1)',glat0)
  g    = 'Latitude: '+pg+'!uo!n'

; set the x and y ranges (i.e., min and max values)

  xr=[min(f),max(f)]
  yr=[min(zalt),max(zalt)]

; set specific x and y ranges

  xr=[3.,7.]
;  yr=[0,1000]


; set up the plot axes, titles, and labels (but no data)

  plot,fg,zg,/nodata,xrange=xr,yrange=yr,xstyle=1,ystyle=1,$
       xtitle=xt,title=ft,ytitle='Altitude (km)',$
       charsize=1.4,color=0

; interpolate to find the vaules of fg and zg

  istop = 0
  izg = 0
  for j = 0,nf-1 do begin 
    for iz = 0,nz-2 do begin
      if glat(iz,j) lt glat0 then izg = iz  
    endfor
    delglat = ( glat0         - glat(izg,j) ) /  $
              ( glat(izg+1,j) - glat(izg,j) )
    delf    = delglat * (f(izg+1,j,ntm) - f(izg,j,ntm) )
    delzalt = delglat * (zalt(izg+1,j) - zalt(izg,j) )
    fg(j)   = f(izg,j,ntm) + delf
    zg(j)   = zalt(izg,j) + delzalt
  endfor

; do the line plot

  oplot,fg,zg,color=0,psym=1

; print the universal time and latitude

  xp = .2
  yp = .85
  xyouts,xp,yp,t,size=1.2,color=0,/normal
  xp = .2
  yp = .82
  xyouts,xp,yp,g,size=1.2,color=0,/normal

; -----------------------
; set plot to postscript
; -----------------------

  set_plot,'ps'

  device,file='zalt1d.ps',xsize=xps,ysize=yps,/inches,$
         xoffset=1,yoffset=2

; set up the plot axes, titles, and labels (but no data)

  plot,fg,zg,/nodata,xrange=xr,yrange=yr,xstyle=1,ystyle=1,$
       xtitle=xt,title=ft,ytitle='Altitude (km)',$
       charsize=1.4,color=0

; do the line plot

  oplot,fg,zg,color=0,psym=1

; print the universal time and latitude

  xp = .22
  yp = .85
  xyouts,xp,yp,t,size=1.2,color=0,/normal
  xp = .22
  yp = .82
  xyouts,xp,yp,g,size=1.2,color=0,/normal

; close the postscipt file

  device,/close

; reset the display to the screen

  set_plot,'x'

end
