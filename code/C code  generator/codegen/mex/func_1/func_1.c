/*
 * func_1.c
 *
 * Code generation for function 'func_1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_1.h"
#include "func_1_data.h"

/* Variable Definitions */
static emlrtRTEInfo emlrtRTEI = { 3,   /* lineNo */
  9,                                   /* colNo */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { 1,     /* iFirst */
  50000,                               /* iLast */
  4,                                   /* lineNo */
  20,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  4,                                   /* lineNo */
  31,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  4,                                   /* lineNo */
  43,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  4,                                   /* lineNo */
  54,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  4,                                   /* lineNo */
  65,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  4,                                   /* lineNo */
  76,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  5,                                   /* lineNo */
  20,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  5,                                   /* lineNo */
  31,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  5,                                   /* lineNo */
  43,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  5,                                   /* lineNo */
  54,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  5,                                   /* lineNo */
  65,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  5,                                   /* lineNo */
  76,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  6,                                   /* lineNo */
  20,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  6,                                   /* lineNo */
  31,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  6,                                   /* lineNo */
  43,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  6,                                   /* lineNo */
  54,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  6,                                   /* lineNo */
  65,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  6,                                   /* lineNo */
  76,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  9,                                   /* lineNo */
  25,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo b_emlrtRTEI = { 14,/* lineNo */
  7,                                   /* colNo */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m"/* pName */
};

static emlrtBCInfo t_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  16,                                  /* lineNo */
  18,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  17,                                  /* lineNo */
  21,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  17,                                  /* lineNo */
  30,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo w_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  17,                                  /* lineNo */
  42,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo x_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  17,                                  /* lineNo */
  51,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo y_emlrtBCI = { 1,   /* iFirst */
  50000,                               /* iLast */
  17,                                  /* lineNo */
  62,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ab_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  17,                                  /* lineNo */
  71,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  18,                                  /* lineNo */
  21,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  18,                                  /* lineNo */
  30,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  18,                                  /* lineNo */
  42,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  18,                                  /* lineNo */
  51,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  18,                                  /* lineNo */
  62,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  18,                                  /* lineNo */
  71,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  19,                                  /* lineNo */
  21,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ib_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  19,                                  /* lineNo */
  30,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  19,                                  /* lineNo */
  42,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  19,                                  /* lineNo */
  51,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  19,                                  /* lineNo */
  62,                                  /* colNo */
  "c",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  19,                                  /* lineNo */
  71,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  22,                                  /* lineNo */
  25,                                  /* colNo */
  "b",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ob_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  22,                                  /* lineNo */
  7,                                   /* colNo */
  "B",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo pb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  9,                                   /* lineNo */
  7,                                   /* colNo */
  "A",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  3                                    /* checkKind */
};

static emlrtBCInfo qb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  8,                                   /* lineNo */
  24,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  8,                                   /* lineNo */
  33,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  8,                                   /* lineNo */
  42,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  8,                                   /* lineNo */
  51,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ub_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  8,                                   /* lineNo */
  60,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vb_emlrtBCI = { 1,  /* iFirst */
  50000,                               /* iLast */
  8,                                   /* lineNo */
  69,                                  /* colNo */
  "d",                                 /* aName */
  "func_1",                            /* fName */
  "C:\\Asus\\SEED\\MatLab code\\3D\\Codes\\work_MEX\\test\\func_test\\func_1.m",/* pName */
  0                                    /* checkKind */
};

/* Function Definitions */
void func_1(const emlrtStack *sp, real_T A[450000], real_T B[450000], real_T a,
            const real_T b[450000], const real_T c[450000], const real_T d
            [150000], real_T e)
{
  int32_T i;
  int32_T i0;
  real_T bb;
  int32_T i1;
  real_T b_c[3];
  real_T c_c[9];
  int32_T i2;
  emlrtForLoopVectorCheckR2012b(1.0, 1.0, a, mxDOUBLE_CLASS, (int32_T)a,
    &emlrtRTEI, sp);
  i = 0;
  while (i <= (int32_T)a - 1) {
    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &b_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &c_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &d_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &e_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &f_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &g_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &h_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &i_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &j_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &k_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &l_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &m_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &n_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &o_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &p_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &q_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &r_emlrtBCI, sp);
    }

    if (!((i + 1 >= 1) && (i + 1 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &qb_emlrtBCI, sp);
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &rb_emlrtBCI, sp);
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &sb_emlrtBCI, sp);
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &tb_emlrtBCI, sp);
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &ub_emlrtBCI, sp);
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &vb_emlrtBCI, sp);
    }

    bb = ((((((((b[9 * i] * c[9 * i] + b[3 + 9 * i] * c[3 + 9 * i]) + b[6 + 9 *
                i] * c[6 + 9 * i]) + b[1 + 9 * i] * c[1 + 9 * i]) + b[4 + 9 * i]
              * c[4 + 9 * i]) + b[7 + 9 * i] * c[7 + 9 * i]) + b[2 + 9 * i] * c
            [2 + 9 * i]) + b[5 + 9 * i] * c[5 + 9 * i]) + b[8 + 9 * i] * c[8 + 9
          * i]) * ((d[3 * i] * d[3 * i] + d[1 + 3 * i] * d[1 + 3 * i]) + d[2 + 3
                   * i] * d[2 + 3 * i]);
    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &s_emlrtBCI, sp);
    }

    if (!((i + 1 >= 1) && (i + 1 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &pb_emlrtBCI, sp);
    }

    for (i0 = 0; i0 < 3; i0++) {
      for (i1 = 0; i1 < 3; i1++) {
        A[(i1 + 3 * i0) + 9 * i] = bb * c[(i1 + 3 * i0) + 9 * i];
      }
    }

    i++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emlrtForLoopVectorCheckR2012b(1.0, 1.0, e, mxDOUBLE_CLASS, (int32_T)e,
    &b_emlrtRTEI, sp);
  i = 0;
  while (i <= (int32_T)e - 1) {
    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &t_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &u_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &v_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &w_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &x_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &y_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &ab_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &bb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &cb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &db_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &eb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &fb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &gb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &hb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &ib_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &jb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &kb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &lb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &mb_emlrtBCI, sp);
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &nb_emlrtBCI, sp);
    }

    if (!((i + 1 >= 1) && (i + 1 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &ob_emlrtBCI, sp);
    }

    for (i0 = 0; i0 < 3; i0++) {
      for (i1 = 0; i1 < 3; i1++) {
        B[(i1 + 3 * i0) + 9 * i] = 0.0;
      }
    }

    i0 = i + 1;
    if (!((i0 >= 1) && (i0 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 50000, &ob_emlrtBCI, sp);
    }

    b_c[0] = (c[9 * i] * d[3 * i] + c[3 + 9 * i] * d[3 * i]) + c[6 + 9 * i] * d
      [3 * i];
    b_c[1] = (c[1 + 9 * i] * d[1 + 3 * i] + c[4 + 9 * i] * d[1 + 3 * i]) + c[7 +
      9 * i] * d[1 + 3 * i];
    b_c[2] = (c[2 + 9 * i] * d[2 + 3 * i] + c[5 + 9 * i] * d[2 + 3 * i]) + c[8 +
      9 * i] * d[2 + 3 * i];
    for (i0 = 0; i0 < 3; i0++) {
      for (i1 = 0; i1 < 3; i1++) {
        c_c[i0 + 3 * i1] = b_c[i0] * d[i1 + 3 * i];
      }
    }

    if (!((i + 1 >= 1) && (i + 1 <= 50000))) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, 50000, &ob_emlrtBCI, sp);
    }

    for (i0 = 0; i0 < 3; i0++) {
      for (i1 = 0; i1 < 3; i1++) {
        B[(i0 + 3 * i1) + 9 * i] = 0.0;
        for (i2 = 0; i2 < 3; i2++) {
          B[(i0 + 3 * i1) + 9 * i] += c_c[i0 + 3 * i2] * b[(i2 + 3 * i1) + 9 * i];
        }
      }
    }

    i++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }
}

/* End of code generation (func_1.c) */
