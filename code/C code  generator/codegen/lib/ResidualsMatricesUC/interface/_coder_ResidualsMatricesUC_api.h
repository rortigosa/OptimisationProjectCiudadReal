/*
 * File: _coder_ResidualsMatricesUC_api.h
 *
 * MATLAB Coder version            : 3.0
 * C/C++ source code generated on  : 16-Nov-2017 12:07:55
 */

#ifndef ___CODER_RESIDUALSMATRICESUC_API_H__
#define ___CODER_RESIDUALSMATRICESUC_API_H__

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_ResidualsMatricesUC_api.h"

/* Type Definitions */
#ifndef typedef_struct0_T
#define typedef_struct0_T

typedef struct {
  real_T Tx[8];
  real_T Kxx[64];
} struct0_T;

#endif                                 /*typedef_struct0_T*/

#ifndef typedef_struct2_T
#define typedef_struct2_T

typedef struct {
  real_T D2UDFDF[64];
  real_T D2UDFDH[64];
  real_T D2UDFDJ[16];
  real_T D2UDHDH[64];
  real_T D2UDHDJ[16];
  real_T D2UDJDJ[4];
} struct2_T;

#endif                                 /*typedef_struct2_T*/

#ifndef typedef_struct3_T
#define typedef_struct3_T

typedef struct {
  real_T DUDJ[4];
} struct3_T;

#endif                                 /*typedef_struct3_T*/

#ifndef typedef_struct1_T
#define typedef_struct1_T

typedef struct {
  struct2_T D2U;
  struct3_T DU;
} struct1_T;

#endif                                 /*typedef_struct1_T*/

#ifndef typedef_struct4_T
#define typedef_struct4_T

typedef struct {
  real_T BF[128];
  real_T QF[64];
  real_T QSigmaH[64];
} struct4_T;

#endif                                 /*typedef_struct4_T*/

#ifndef typedef_struct5_T
#define typedef_struct5_T

typedef struct {
  real_T H[16];
} struct5_T;

#endif                                 /*typedef_struct5_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void ResidualsMatricesUC(struct0_T *asmb, struct1_T derivatives, real_T
  Piola_vect[16], struct4_T vect_kin, struct5_T kinematics, real_T IntWeight[4],
  real_T dim, real_T n_node_elem, real_T ngauss);
extern void ResidualsMatricesUC_api(const mxArray *prhs[9], const mxArray *plhs
  [1]);
extern void ResidualsMatricesUC_atexit(void);
extern void ResidualsMatricesUC_initialize(void);
extern void ResidualsMatricesUC_terminate(void);
extern void ResidualsMatricesUC_xil_terminate(void);

#endif

/*
 * File trailer for _coder_ResidualsMatricesUC_api.h
 *
 * [EOF]
 */
