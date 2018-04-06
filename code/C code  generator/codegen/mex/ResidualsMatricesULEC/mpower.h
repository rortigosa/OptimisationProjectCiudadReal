/*
 * mpower.h
 *
 * Code generation for function 'mpower'
 *
 */

#ifndef __MPOWER_H__
#define __MPOWER_H__

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "ResidualsMatricesULEC_types.h"

/* Function Declarations */
extern real_T mpower(real_T a);

#ifdef __WATCOMC__

#pragma aux mpower value [8087];

#endif
#endif

/* End of code generation (mpower.h) */
