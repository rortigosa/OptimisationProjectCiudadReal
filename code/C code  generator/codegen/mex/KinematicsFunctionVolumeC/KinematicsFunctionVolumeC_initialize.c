/*
 * KinematicsFunctionVolumeC_initialize.c
 *
 * Code generation for function 'KinematicsFunctionVolumeC_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "KinematicsFunctionVolumeC.h"
#include "KinematicsFunctionVolumeC_initialize.h"
#include "_coder_KinematicsFunctionVolumeC_mex.h"
#include "KinematicsFunctionVolumeC_data.h"
#include "lapacke.h"

/* Function Definitions */
void KinematicsFunctionVolumeC_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (KinematicsFunctionVolumeC_initialize.c) */
