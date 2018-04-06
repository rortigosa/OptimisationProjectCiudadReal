/*
 * _coder_KinematicsFunctionVolumeC_mex.c
 *
 * Code generation for function '_coder_KinematicsFunctionVolumeC_mex'
 *
 */

/* Include files */
#include "KinematicsFunctionVolumeC.h"
#include "_coder_KinematicsFunctionVolumeC_mex.h"
#include "KinematicsFunctionVolumeC_terminate.h"
#include "_coder_KinematicsFunctionVolumeC_api.h"
#include "KinematicsFunctionVolumeC_initialize.h"
#include "KinematicsFunctionVolumeC_data.h"
#include "lapacke.h"

/* Function Declarations */
static void c_KinematicsFunctionVolumeC_mex(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[4]);

/* Function Definitions */
static void c_KinematicsFunctionVolumeC_mex(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[4])
{
  int32_T n;
  const mxArray *inputs[4];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL, NULL, NULL };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 4) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 4, 4,
                        25, "KinematicsFunctionVolumeC");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 25,
                        "KinematicsFunctionVolumeC");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  KinematicsFunctionVolumeC_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  KinematicsFunctionVolumeC_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(KinematicsFunctionVolumeC_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  KinematicsFunctionVolumeC_initialize();

  /* Dispatch the entry-point. */
  c_KinematicsFunctionVolumeC_mex(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_KinematicsFunctionVolumeC_mex.c) */
