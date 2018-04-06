/*
 * _coder_FirstPiolaKirchhoffStressTensorUC_mex.cpp
 *
 * Code generation for function '_coder_FirstPiolaKirchhoffStressTensorUC_mex'
 *
 */

/* Include files */
#include "FirstPiolaKirchhoffStressTensorUC.h"
#include "_coder_FirstPiolaKirchhoffStressTensorUC_mex.h"
#include "FirstPiolaKirchhoffStressTensorUC_terminate.h"
#include "_coder_FirstPiolaKirchhoffStressTensorUC_api.h"
#include "FirstPiolaKirchhoffStressTensorUC_initialize.h"
#include "FirstPiolaKirchhoffStressTensorUC_data.h"

/* Function Declarations */
static void c_FirstPiolaKirchhoffStressTens(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[8]);

/* Function Definitions */
static void c_FirstPiolaKirchhoffStressTens(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[8])
{
  int32_T n;
  const mxArray *inputs[8];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 8) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 8, 4,
                        33, "FirstPiolaKirchhoffStressTensorUC");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 33,
                        "FirstPiolaKirchhoffStressTensorUC");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  FirstPiolaKirchhoffStressTensorUC_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  FirstPiolaKirchhoffStressTensorUC_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(FirstPiolaKirchhoffStressTensorUC_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  FirstPiolaKirchhoffStressTensorUC_initialize();

  /* Dispatch the entry-point. */
  c_FirstPiolaKirchhoffStressTens(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_FirstPiolaKirchhoffStressTensorUC_mex.cpp) */
