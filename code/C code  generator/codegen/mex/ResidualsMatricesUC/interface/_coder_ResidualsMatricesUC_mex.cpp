/*
 * _coder_ResidualsMatricesUC_mex.cpp
 *
 * Code generation for function '_coder_ResidualsMatricesUC_mex'
 *
 */

/* Include files */
#include "ResidualsMatricesUC.h"
#include "_coder_ResidualsMatricesUC_mex.h"
#include "ResidualsMatricesUC_terminate.h"
#include "_coder_ResidualsMatricesUC_api.h"
#include "ResidualsMatricesUC_initialize.h"
#include "ResidualsMatricesUC_data.h"

/* Function Declarations */
static void ResidualsMatricesUC_mexFunction(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[9]);

/* Function Definitions */
static void ResidualsMatricesUC_mexFunction(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[9])
{
  int32_T n;
  const mxArray *inputs[9];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 9) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 9, 4,
                        19, "ResidualsMatricesUC");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 19,
                        "ResidualsMatricesUC");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  ResidualsMatricesUC_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  ResidualsMatricesUC_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(ResidualsMatricesUC_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  ResidualsMatricesUC_initialize();

  /* Dispatch the entry-point. */
  ResidualsMatricesUC_mexFunction(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_ResidualsMatricesUC_mex.cpp) */
