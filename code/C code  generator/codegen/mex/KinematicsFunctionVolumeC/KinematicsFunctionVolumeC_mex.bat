@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=KinematicsFunctionVolumeC_mex
set MEX_NAME=KinematicsFunctionVolumeC_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for KinematicsFunctionVolumeC > KinematicsFunctionVolumeC_mex.mki
echo COMPILER=%COMPILER%>> KinematicsFunctionVolumeC_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> KinematicsFunctionVolumeC_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> KinematicsFunctionVolumeC_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> KinematicsFunctionVolumeC_mex.mki
echo LINKER=%LINKER%>> KinematicsFunctionVolumeC_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> KinematicsFunctionVolumeC_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> KinematicsFunctionVolumeC_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> KinematicsFunctionVolumeC_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> KinematicsFunctionVolumeC_mex.mki
echo BORLAND=%BORLAND%>> KinematicsFunctionVolumeC_mex.mki
echo OMPFLAGS= >> KinematicsFunctionVolumeC_mex.mki
echo OMPLINKFLAGS= >> KinematicsFunctionVolumeC_mex.mki
echo EMC_COMPILER=mingw64>> KinematicsFunctionVolumeC_mex.mki
echo EMC_CONFIG=optim>> KinematicsFunctionVolumeC_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f KinematicsFunctionVolumeC_mex.mk
