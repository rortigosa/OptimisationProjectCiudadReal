/*
 * ResidualsMatricesUC_terminate.cpp
 *
 * Code generation for function 'ResidualsMatricesUC_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesUC.h"
#include "ResidualsMatricesUC_terminate.h"
#include "_coder_ResidualsMatricesUC_mex.h"
#include "ResidualsMatricesUC_data.h"

/* Function Definitions */
void ResidualsMatricesUC_atexit()
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void ResidualsMatricesUC_terminate()
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (ResidualsMatricesUC_terminate.cpp) */
