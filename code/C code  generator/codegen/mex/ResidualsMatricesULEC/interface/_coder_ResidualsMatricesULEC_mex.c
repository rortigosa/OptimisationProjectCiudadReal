/*
 * _coder_ResidualsMatricesULEC_mex.c
 *
 * Code generation for function '_coder_ResidualsMatricesULEC_mex'
 *
 */

/* Include files */
#include "ResidualsMatricesULEC.h"
#include "_coder_ResidualsMatricesULEC_mex.h"
#include "ResidualsMatricesULEC_terminate.h"
#include "_coder_ResidualsMatricesULEC_api.h"
#include "ResidualsMatricesULEC_initialize.h"
#include "ResidualsMatricesULEC_data.h"

/* Function Declarations */
static void c_ResidualsMatricesULEC_mexFunc(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[10]);

/* Function Definitions */
static void c_ResidualsMatricesULEC_mexFunc(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[10])
{
  int32_T n;
  const mxArray *inputs[10];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 10) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 10, 4,
                        21, "ResidualsMatricesULEC");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 21,
                        "ResidualsMatricesULEC");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  ResidualsMatricesULEC_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  ResidualsMatricesULEC_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(ResidualsMatricesULEC_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  ResidualsMatricesULEC_initialize();

  /* Dispatch the entry-point. */
  c_ResidualsMatricesULEC_mexFunc(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_ResidualsMatricesULEC_mex.c) */
