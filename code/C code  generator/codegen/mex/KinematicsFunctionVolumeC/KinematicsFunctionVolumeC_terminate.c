/*
 * KinematicsFunctionVolumeC_terminate.c
 *
 * Code generation for function 'KinematicsFunctionVolumeC_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "KinematicsFunctionVolumeC.h"
#include "KinematicsFunctionVolumeC_terminate.h"
#include "_coder_KinematicsFunctionVolumeC_mex.h"
#include "KinematicsFunctionVolumeC_data.h"
#include "lapacke.h"

/* Function Definitions */
void KinematicsFunctionVolumeC_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void KinematicsFunctionVolumeC_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (KinematicsFunctionVolumeC_terminate.c) */
