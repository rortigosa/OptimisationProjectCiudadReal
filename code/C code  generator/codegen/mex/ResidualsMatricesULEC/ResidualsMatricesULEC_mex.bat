@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=ResidualsMatricesULECMex
set MEX_NAME=ResidualsMatricesULECMex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for ResidualsMatricesULEC > ResidualsMatricesULEC_mex.mki
echo COMPILER=%COMPILER%>> ResidualsMatricesULEC_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> ResidualsMatricesULEC_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> ResidualsMatricesULEC_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> ResidualsMatricesULEC_mex.mki
echo LINKER=%LINKER%>> ResidualsMatricesULEC_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> ResidualsMatricesULEC_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> ResidualsMatricesULEC_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> ResidualsMatricesULEC_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> ResidualsMatricesULEC_mex.mki
echo BORLAND=%BORLAND%>> ResidualsMatricesULEC_mex.mki
echo OMPFLAGS= >> ResidualsMatricesULEC_mex.mki
echo OMPLINKFLAGS= >> ResidualsMatricesULEC_mex.mki
echo EMC_COMPILER=mingw64>> ResidualsMatricesULEC_mex.mki
echo EMC_CONFIG=optim>> ResidualsMatricesULEC_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f ResidualsMatricesULEC_mex.mk
