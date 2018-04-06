/*
 * func_1_terminate.c
 *
 * Code generation for function 'func_1_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_1.h"
#include "func_1_terminate.h"
#include "_coder_func_1_mex.h"
#include "func_1_data.h"

/* Function Definitions */
void func_1_atexit(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void func_1_terminate(void)
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (func_1_terminate.c) */
