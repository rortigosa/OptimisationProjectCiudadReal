set COMPILER=C:\TDM-GCC-64\bin\gcc
                set CXXCOMPILER=C:\TDM-GCC-64\bin\g++
                set COMPFLAGS=-c -fexceptions -fno-omit-frame-pointer -DTARGET_API_VERSION=700   -m64 -DMATLAB_MEX_FILE  -DMATLAB_MEX_FILE 
                set CXXCOMPFLAGS=-c -fexceptions -fno-omit-frame-pointer -std=c++11 -DTARGET_API_VERSION=700   -m64 -DMATLAB_MEX_FILE  -DMATLAB_MEX_FILE 
                set OPTIMFLAGS=-O -DNDEBUG
                set DEBUGFLAGS=-g
                set LINKER=C:\TDM-GCC-64\bin\gcc
                set CXXLINKER=C:\TDM-GCC-64\bin\g++
                set LINKFLAGS=-m64 -Wl,--no-undefined -shared -L"C:\Program Files\MATLAB\R2017a\extern\lib\win64\mingw64" -llibmx -llibmex -llibmat -lm -llibmwlapack -llibmwblas 
                set LINKDEBUGFLAGS=-g
                set NAME_OUTPUT=-o "%OUTDIR%%MEX_NAME%%MEX_EXT%"
set PATH=C:\TDM-GCC-64\bin;C:\Program Files\MATLAB\R2017a\extern\include\win64;C:\Program Files\MATLAB\R2017a\extern\include;C:\Program Files\MATLAB\R2017a\simulink\include;C:\Program Files\MATLAB\R2017a\lib\win64;%MATLAB_BIN%;%PATH%
set INCLUDE=C:\TDM-GCC-64\include;;%INCLUDE%
set LIB=C:\TDM-GCC-64\lib;;%LIB%
set LIBPATH=C:\Program Files\MATLAB\R2017a\extern\lib\win64;%LIBPATH%
