MINGWPATH=C:\Compilers\mingw64
CYGPATH=c:/cygwin

MATLABROOT=C:\Program Files\MATLAB\R2015b
CC=$(MINGWPATH)/bin/
CFLAG= -Wall -m64 -O3 -I$(MATLABROOT)/extern/include $(SRC) $(LIBS) -o $(EXE)
MEXFLAG=-m64 -shared -DMATLAB_MEX_FILE -I$(MATLABROOT)/extern/include -Wl,--export-all-symbols $(LIBS) $(MEXSRC) -o $(MEXTGT).mexw64

LIBS= -L$(MATLABROOT)/bin/win64 -L$(MATLABROOT)/extern/lib/win64/microsoft -lmex -lmx -lmwlapack -lmwblas -leng
EXE=../bin/matrixTranspose.exe
MEXTGT=
SRC=matrixTranspose.c
MEXSRC=
all:$(EXE)

$(EXE):  $(SRC)
    $(CC) $(CFLAG) -ladvapi32 -luser32 -lgdi32 -lkernel32 -lmingwex -o $(EXE)
    @rm -f *.o*

$(MEXTGT):  $(MEXSRC)
    $(CC) $(MEXFLAG) -ladvapi32 -luser32 -lgdi32 -lkernel32 -lmingwex 
    @rm -f *.o*