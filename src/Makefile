
OBJ= hwm93.o nrlmsise00.o grid-1.00.o sami2-1.00.o

# Uncomment the compiler you want to use

#   1. Absoft

#  f77 = f77 -s -O3 -g

#    2. Lahey

# f77 = lf95  --sav -O

#    3. Portland Group

# f77 = pgf77 -Msave -fast

#    4. intel

#  f77 = ifort -save -O2 

#    5. gfortran

 f77 = gfortran -O2 -fno-automatic

.f.o:
	$(f77) -c $*.f
#
sami2.x:    $(OBJ)
	$(f77)  -o sami2.x   $(OBJ)
#
clean:
	rm *.x *.o
#
$(OBJ): com-1.00.inc
$(OBJ): param-1.00.inc


