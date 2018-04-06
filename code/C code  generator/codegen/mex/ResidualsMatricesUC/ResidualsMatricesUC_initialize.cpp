/*
 * ResidualsMatricesUC_initialize.cpp
 *
 * Code generation for function 'ResidualsMatricesUC_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesUC.h"
#include "ResidualsMatricesUC_initialize.h"
#include "_coder_ResidualsMatricesUC_mex.h"
#include "ResidualsMatricesUC_data.h"

/* Function Definitions */
void ResidualsMatricesUC_initialize()
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (ResidualsMatricesUC_initialize.cpp) */
