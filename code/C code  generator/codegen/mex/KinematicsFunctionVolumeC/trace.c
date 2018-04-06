/*
 * trace.c
 *
 * Code generation for function 'trace'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "KinematicsFunctionVolumeC.h"
#include "trace.h"
#include "lapacke.h"

/* Variable Definitions */
static emlrtRTEInfo c_emlrtRTEI = { 11, 15, "trace",
  "C:\\Program Files\\MATLAB\\R2015b\\toolbox\\eml\\lib\\matlab\\matfun\\trace.m"
};

/* Function Definitions */
real_T trace(const emlrtStack *sp, const real_T a_data[], const int32_T a_size[2])
{
  real_T t;
  int32_T k;
  if (a_size[0] == a_size[1]) {
  } else {
    emlrtErrorWithMessageIdR2012b(sp, &c_emlrtRTEI, "Coder:MATLAB:square", 0);
  }

  t = 0.0;
  for (k = 0; k < a_size[0]; k++) {
    t += a_data[k + a_size[0] * k];
  }

  return t;
}

/* End of code generation (trace.c) */
