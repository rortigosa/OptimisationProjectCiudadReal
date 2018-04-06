@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=ResidualsMatricesUCMex
set MEX_NAME=ResidualsMatricesUCMex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for ResidualsMatricesUC > ResidualsMatricesUC_mex.mki
echo COMPILER=%COMPILER%>> ResidualsMatricesUC_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> ResidualsMatricesUC_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> ResidualsMatricesUC_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> ResidualsMatricesUC_mex.mki
echo LINKER=%LINKER%>> ResidualsMatricesUC_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> ResidualsMatricesUC_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> ResidualsMatricesUC_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> ResidualsMatricesUC_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> ResidualsMatricesUC_mex.mki
echo BORLAND=%BORLAND%>> ResidualsMatricesUC_mex.mki
echo OMPFLAGS= >> ResidualsMatricesUC_mex.mki
echo OMPLINKFLAGS= >> ResidualsMatricesUC_mex.mki
echo EMC_COMPILER=mingw64>> ResidualsMatricesUC_mex.mki
echo EMC_CONFIG=optim>> ResidualsMatricesUC_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f ResidualsMatricesUC_mex.mk
