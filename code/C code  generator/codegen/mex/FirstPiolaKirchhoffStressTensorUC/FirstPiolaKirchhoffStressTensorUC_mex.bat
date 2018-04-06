@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=FirstPiolaKirchhoffStressTensorUCMex
set MEX_NAME=FirstPiolaKirchhoffStressTensorUCMex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for FirstPiolaKirchhoffStressTensorUC > FirstPiolaKirchhoffStressTensorUC_mex.mki
echo COMPILER=%COMPILER%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo LINKER=%LINKER%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo BORLAND=%BORLAND%>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo OMPFLAGS= >> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo OMPLINKFLAGS= >> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo EMC_COMPILER=mingw64>> FirstPiolaKirchhoffStressTensorUC_mex.mki
echo EMC_CONFIG=optim>> FirstPiolaKirchhoffStressTensorUC_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f FirstPiolaKirchhoffStressTensorUC_mex.mk
