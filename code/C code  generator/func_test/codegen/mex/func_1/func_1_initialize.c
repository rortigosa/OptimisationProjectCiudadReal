/*
 * func_1_initialize.c
 *
 * Code generation for function 'func_1_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_1.h"
#include "func_1_initialize.h"
#include "_coder_func_1_mex.h"
#include "func_1_data.h"

/* Function Definitions */
void func_1_initialize(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (func_1_initialize.c) */
