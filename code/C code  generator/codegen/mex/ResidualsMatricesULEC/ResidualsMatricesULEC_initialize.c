/*
 * ResidualsMatricesULEC_initialize.c
 *
 * Code generation for function 'ResidualsMatricesULEC_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesULEC.h"
#include "ResidualsMatricesULEC_initialize.h"
#include "_coder_ResidualsMatricesULEC_mex.h"
#include "ResidualsMatricesULEC_data.h"

/* Function Definitions */
void ResidualsMatricesULEC_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (ResidualsMatricesULEC_initialize.c) */
