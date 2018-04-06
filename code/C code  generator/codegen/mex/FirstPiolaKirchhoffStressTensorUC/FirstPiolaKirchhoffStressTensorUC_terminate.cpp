/*
 * FirstPiolaKirchhoffStressTensorUC_terminate.cpp
 *
 * Code generation for function 'FirstPiolaKirchhoffStressTensorUC_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "FirstPiolaKirchhoffStressTensorUC.h"
#include "FirstPiolaKirchhoffStressTensorUC_terminate.h"
#include "_coder_FirstPiolaKirchhoffStressTensorUC_mex.h"
#include "FirstPiolaKirchhoffStressTensorUC_data.h"

/* Function Definitions */
void FirstPiolaKirchhoffStressTensorUC_atexit()
{
  emlrtStack st = { NULL, NULL, NULL };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void FirstPiolaKirchhoffStressTensorUC_terminate()
{
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (FirstPiolaKirchhoffStressTensorUC_terminate.cpp) */
