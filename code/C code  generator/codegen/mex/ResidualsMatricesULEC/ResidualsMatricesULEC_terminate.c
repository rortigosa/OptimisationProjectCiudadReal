/*
 * ResidualsMatricesULEC_terminate.c
 *
 * Code generation for function 'ResidualsMatricesULEC_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesULEC.h"
#include "ResidualsMatricesULEC_terminate.h"
#include "_coder_ResidualsMatricesULEC_mex.h"
#include "ResidualsMatricesULEC_data.h"

/* Function Definitions */
void ResidualsMatricesULEC_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void ResidualsMatricesULEC_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (ResidualsMatricesULEC_terminate.c) */
