@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=func_1_mex
set MEX_NAME=func_1_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2015b\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for func_1 > func_1_mex.mki
echo COMPILER=%COMPILER%>> func_1_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> func_1_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> func_1_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> func_1_mex.mki
echo LINKER=%LINKER%>> func_1_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> func_1_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> func_1_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> func_1_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> func_1_mex.mki
echo BORLAND=%BORLAND%>> func_1_mex.mki
echo OMPFLAGS= >> func_1_mex.mki
echo OMPLINKFLAGS= >> func_1_mex.mki
echo EMC_COMPILER=lcc64>> func_1_mex.mki
echo EMC_CONFIG=optim>> func_1_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f func_1_mex.mk
