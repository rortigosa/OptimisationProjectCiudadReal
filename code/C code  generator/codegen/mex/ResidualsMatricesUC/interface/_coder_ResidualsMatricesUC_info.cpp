/*
 * _coder_ResidualsMatricesUC_info.cpp
 *
 * Code generation for function '_coder_ResidualsMatricesUC_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "ResidualsMatricesUC.h"
#include "_coder_ResidualsMatricesUC_info.h"

/* Function Declarations */
static const mxArray *b_emlrt_marshallOut(const uint32_T u);
static void b_info_helper(const mxArray **info);
static const mxArray *emlrt_marshallOut(const char * u);
static void info_helper(const mxArray **info);

/* Function Definitions */
static const mxArray *b_emlrt_marshallOut(const uint32_T u)
{
  const mxArray *y;
  const mxArray *m1;
  y = NULL;
  m1 = emlrtCreateNumericMatrix(1, 1, mxUINT32_CLASS, mxREAL);
  *(uint32_T *)mxGetData(m1) = u;
  emlrtAssign(&y, m1);
  return y;
}

static void b_info_helper(const mxArray **info)
{
  const mxArray *rhs64 = NULL;
  const mxArray *lhs64 = NULL;
  const mxArray *rhs65 = NULL;
  const mxArray *lhs65 = NULL;
  const mxArray *rhs66 = NULL;
  const mxArray *lhs66 = NULL;
  const mxArray *rhs67 = NULL;
  const mxArray *lhs67 = NULL;
  const mxArray *rhs68 = NULL;
  const mxArray *lhs68 = NULL;
  const mxArray *rhs69 = NULL;
  const mxArray *lhs69 = NULL;
  const mxArray *rhs70 = NULL;
  const mxArray *lhs70 = NULL;
  const mxArray *rhs71 = NULL;
  const mxArray *lhs71 = NULL;
  const mxArray *rhs72 = NULL;
  const mxArray *lhs72 = NULL;
  const mxArray *rhs73 = NULL;
  const mxArray *lhs73 = NULL;
  const mxArray *rhs74 = NULL;
  const mxArray *lhs74 = NULL;
  const mxArray *rhs75 = NULL;
  const mxArray *lhs75 = NULL;
  const mxArray *rhs76 = NULL;
  const mxArray *lhs76 = NULL;
  const mxArray *rhs77 = NULL;
  const mxArray *lhs77 = NULL;
  const mxArray *rhs78 = NULL;
  const mxArray *lhs78 = NULL;
  const mxArray *rhs79 = NULL;
  const mxArray *lhs79 = NULL;
  const mxArray *rhs80 = NULL;
  const mxArray *lhs80 = NULL;
  const mxArray *rhs81 = NULL;
  const mxArray *lhs81 = NULL;
  const mxArray *rhs82 = NULL;
  const mxArray *lhs82 = NULL;
  const mxArray *rhs83 = NULL;
  const mxArray *lhs83 = NULL;
  const mxArray *rhs84 = NULL;
  const mxArray *lhs84 = NULL;
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m"),
                "context", 64);
  emlrtAddField(*info, emlrt_marshallOut("eml_int_forloop_overflow_check"),
                "name", 64);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 64);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"),
                "resolved", 64);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911534U), "fileTimeLo", 64);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 64);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 64);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 64);
  emlrtAssign(&rhs64, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs64, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs64), "rhs", 64);
  emlrtAddField(*info, emlrtAliasP(lhs64), "lhs", 64);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m"),
                "context", 65);
  emlrtAddField(*info, emlrt_marshallOut("max"), "name", 65);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 65);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/datafun/max.m"),
                "resolved", 65);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911526U), "fileTimeLo", 65);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 65);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 65);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 65);
  emlrtAssign(&rhs65, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs65, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs65), "rhs", 65);
  emlrtAddField(*info, emlrtAliasP(lhs65), "lhs", 65);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/datafun/max.m"),
                "context", 66);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.minOrMax"), "name", 66);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 66);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m"),
                "resolved", 66);
  emlrtAddField(*info, b_emlrt_marshallOut(1426780042U), "fileTimeLo", 66);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 66);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 66);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 66);
  emlrtAssign(&rhs66, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs66, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs66), "rhs", 66);
  emlrtAddField(*info, emlrtAliasP(lhs66), "lhs", 66);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_extremum"),
                "context", 67);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.constNonSingletonDim"),
                "name", 67);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 67);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/constNonSingletonDim.m"),
                "resolved", 67);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911514U), "fileTimeLo", 67);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 67);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 67);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 67);
  emlrtAssign(&rhs67, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs67, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs67), "rhs", 67);
  emlrtAddField(*info, emlrtAliasP(lhs67), "lhs", 67);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_extremum"),
                "context", 68);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 68);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 68);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 68);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 68);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 68);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 68);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 68);
  emlrtAssign(&rhs68, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs68, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs68), "rhs", 68);
  emlrtAddField(*info, emlrtAliasP(lhs68), "lhs", 68);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_extremum_sub"),
                "context", 69);
  emlrtAddField(*info, emlrt_marshallOut("isnan"), "name", 69);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 69);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/isnan.m"),
                "resolved", 69);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 69);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 69);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 69);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 69);
  emlrtAssign(&rhs69, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs69, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs69), "rhs", 69);
  emlrtAddField(*info, emlrtAliasP(lhs69), "lhs", 69);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_extremum_sub"),
                "context", 70);
  emlrtAddField(*info, emlrt_marshallOut("eml_int_forloop_overflow_check"),
                "name", 70);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 70);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"),
                "resolved", 70);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911534U), "fileTimeLo", 70);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 70);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 70);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 70);
  emlrtAssign(&rhs70, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs70, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs70), "rhs", 70);
  emlrtAddField(*info, emlrtAliasP(lhs70), "lhs", 70);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_extremum_sub"),
                "context", 71);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.relop"), "name", 71);
  emlrtAddField(*info, emlrt_marshallOut("function_handle"), "dominantType", 71);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/relop.m"),
                "resolved", 71);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911516U), "fileTimeLo", 71);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 71);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 71);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 71);
  emlrtAssign(&rhs71, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs71, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs71), "rhs", 71);
  emlrtAddField(*info, emlrtAliasP(lhs71), "lhs", 71);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_bin_extremum"),
                "context", 72);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 72);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 72);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 72);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 72);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 72);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 72);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 72);
  emlrtAssign(&rhs72, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs72, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs72), "rhs", 72);
  emlrtAddField(*info, emlrtAliasP(lhs72), "lhs", 72);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "context", 73);
  emlrtAddField(*info, emlrt_marshallOut("isnumerictype"), "name", 73);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 73);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isnumerictype.m"),
                "resolved", 73);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 73);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 73);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 73);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 73);
  emlrtAssign(&rhs73, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs73, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs73), "rhs", 73);
  emlrtAddField(*info, emlrtAliasP(lhs73), "lhs", 73);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "context", 74);
  emlrtAddField(*info, emlrt_marshallOut("isfimath"), "name", 74);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 74);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfimath.m"),
                "resolved", 74);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 74);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 74);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 74);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 74);
  emlrtAssign(&rhs74, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs74, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs74), "rhs", 74);
  emlrtAddField(*info, emlrtAliasP(lhs74), "lhs", 74);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m!firstfi"),
                "context", 75);
  emlrtAddField(*info, emlrt_marshallOut("isfi"), "name", 75);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 75);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfi.m"),
                "resolved", 75);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 75);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 75);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 75);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 75);
  emlrtAssign(&rhs75, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs75, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs75), "rhs", 75);
  emlrtAddField(*info, emlrtAliasP(lhs75), "lhs", 75);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_bin_extremum"),
                "context", 76);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalexpAlloc"), "name",
                76);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 76);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAlloc.m"),
                "resolved", 76);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911516U), "fileTimeLo", 76);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 76);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 76);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 76);
  emlrtAssign(&rhs76, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs76, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs76), "rhs", 76);
  emlrtAddField(*info, emlrtAliasP(lhs76), "lhs", 76);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_scalar_bin_extremum"),
                "context", 77);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 77);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 77);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 77);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 77);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 77);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 77);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 77);
  emlrtAssign(&rhs77, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs77, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs77), "rhs", 77);
  emlrtAddField(*info, emlrtAliasP(lhs77), "lhs", 77);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_scalar_bin_extremum"),
                "context", 78);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.relop"), "name", 78);
  emlrtAddField(*info, emlrt_marshallOut("function_handle"), "dominantType", 78);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/relop.m"),
                "resolved", 78);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911516U), "fileTimeLo", 78);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 78);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 78);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 78);
  emlrtAssign(&rhs78, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs78, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs78), "rhs", 78);
  emlrtAddField(*info, emlrtAliasP(lhs78), "lhs", 78);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/relop.m"),
                "context", 79);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexIntRelop"), "name",
                79);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 79);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/indexIntRelop.m"),
                "resolved", 79);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911546U), "fileTimeLo", 79);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 79);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 79);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 79);
  emlrtAssign(&rhs79, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs79, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs79), "rhs", 79);
  emlrtAddField(*info, emlrtAliasP(lhs79), "lhs", 79);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/minOrMax.m!eml_scalar_bin_extremum"),
                "context", 80);
  emlrtAddField(*info, emlrt_marshallOut("isnan"), "name", 80);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 80);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/isnan.m"),
                "resolved", 80);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 80);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 80);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 80);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 80);
  emlrtAssign(&rhs80, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs80, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs80), "rhs", 80);
  emlrtAddField(*info, emlrtAliasP(lhs80), "lhs", 80);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/isnan.m"),
                "context", 81);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 81);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 81);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 81);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 81);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 81);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 81);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 81);
  emlrtAssign(&rhs81, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs81, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs81), "rhs", 81);
  emlrtAddField(*info, emlrtAliasP(lhs81), "lhs", 81);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m"),
                "context", 82);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.error"), "name", 82);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 82);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/error.m"),
                "resolved", 82);
  emlrtAddField(*info, b_emlrt_marshallOut(1435849094U), "fileTimeLo", 82);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 82);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 82);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 82);
  emlrtAssign(&rhs82, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs82, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs82), "rhs", 82);
  emlrtAddField(*info, emlrtAliasP(lhs82), "lhs", 82);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m"),
                "context", 83);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 83);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 83);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 83);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 83);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 83);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 83);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 83);
  emlrtAssign(&rhs83, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs83, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs83), "rhs", 83);
  emlrtAddField(*info, emlrtAliasP(lhs83), "lhs", 83);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m"),
                "context", 84);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexIntRelop"), "name",
                84);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 84);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/indexIntRelop.m"),
                "resolved", 84);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911546U), "fileTimeLo", 84);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 84);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 84);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 84);
  emlrtAssign(&rhs84, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs84, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs84), "rhs", 84);
  emlrtAddField(*info, emlrtAliasP(lhs84), "lhs", 84);
  emlrtDestroyArray(&rhs64);
  emlrtDestroyArray(&lhs64);
  emlrtDestroyArray(&rhs65);
  emlrtDestroyArray(&lhs65);
  emlrtDestroyArray(&rhs66);
  emlrtDestroyArray(&lhs66);
  emlrtDestroyArray(&rhs67);
  emlrtDestroyArray(&lhs67);
  emlrtDestroyArray(&rhs68);
  emlrtDestroyArray(&lhs68);
  emlrtDestroyArray(&rhs69);
  emlrtDestroyArray(&lhs69);
  emlrtDestroyArray(&rhs70);
  emlrtDestroyArray(&lhs70);
  emlrtDestroyArray(&rhs71);
  emlrtDestroyArray(&lhs71);
  emlrtDestroyArray(&rhs72);
  emlrtDestroyArray(&lhs72);
  emlrtDestroyArray(&rhs73);
  emlrtDestroyArray(&lhs73);
  emlrtDestroyArray(&rhs74);
  emlrtDestroyArray(&lhs74);
  emlrtDestroyArray(&rhs75);
  emlrtDestroyArray(&lhs75);
  emlrtDestroyArray(&rhs76);
  emlrtDestroyArray(&lhs76);
  emlrtDestroyArray(&rhs77);
  emlrtDestroyArray(&lhs77);
  emlrtDestroyArray(&rhs78);
  emlrtDestroyArray(&lhs78);
  emlrtDestroyArray(&rhs79);
  emlrtDestroyArray(&lhs79);
  emlrtDestroyArray(&rhs80);
  emlrtDestroyArray(&lhs80);
  emlrtDestroyArray(&rhs81);
  emlrtDestroyArray(&lhs81);
  emlrtDestroyArray(&rhs82);
  emlrtDestroyArray(&lhs82);
  emlrtDestroyArray(&rhs83);
  emlrtDestroyArray(&lhs83);
  emlrtDestroyArray(&rhs84);
  emlrtDestroyArray(&lhs84);
}

static const mxArray *emlrt_marshallOut(const char * u)
{
  const mxArray *y;
  const mxArray *m0;
  y = NULL;
  m0 = emlrtCreateString(u);
  emlrtAssign(&y, m0);
  return y;
}

static void info_helper(const mxArray **info)
{
  const mxArray *rhs0 = NULL;
  const mxArray *lhs0 = NULL;
  const mxArray *rhs1 = NULL;
  const mxArray *lhs1 = NULL;
  const mxArray *rhs2 = NULL;
  const mxArray *lhs2 = NULL;
  const mxArray *rhs3 = NULL;
  const mxArray *lhs3 = NULL;
  const mxArray *rhs4 = NULL;
  const mxArray *lhs4 = NULL;
  const mxArray *rhs5 = NULL;
  const mxArray *lhs5 = NULL;
  const mxArray *rhs6 = NULL;
  const mxArray *lhs6 = NULL;
  const mxArray *rhs7 = NULL;
  const mxArray *lhs7 = NULL;
  const mxArray *rhs8 = NULL;
  const mxArray *lhs8 = NULL;
  const mxArray *rhs9 = NULL;
  const mxArray *lhs9 = NULL;
  const mxArray *rhs10 = NULL;
  const mxArray *lhs10 = NULL;
  const mxArray *rhs11 = NULL;
  const mxArray *lhs11 = NULL;
  const mxArray *rhs12 = NULL;
  const mxArray *lhs12 = NULL;
  const mxArray *rhs13 = NULL;
  const mxArray *lhs13 = NULL;
  const mxArray *rhs14 = NULL;
  const mxArray *lhs14 = NULL;
  const mxArray *rhs15 = NULL;
  const mxArray *lhs15 = NULL;
  const mxArray *rhs16 = NULL;
  const mxArray *lhs16 = NULL;
  const mxArray *rhs17 = NULL;
  const mxArray *lhs17 = NULL;
  const mxArray *rhs18 = NULL;
  const mxArray *lhs18 = NULL;
  const mxArray *rhs19 = NULL;
  const mxArray *lhs19 = NULL;
  const mxArray *rhs20 = NULL;
  const mxArray *lhs20 = NULL;
  const mxArray *rhs21 = NULL;
  const mxArray *lhs21 = NULL;
  const mxArray *rhs22 = NULL;
  const mxArray *lhs22 = NULL;
  const mxArray *rhs23 = NULL;
  const mxArray *lhs23 = NULL;
  const mxArray *rhs24 = NULL;
  const mxArray *lhs24 = NULL;
  const mxArray *rhs25 = NULL;
  const mxArray *lhs25 = NULL;
  const mxArray *rhs26 = NULL;
  const mxArray *lhs26 = NULL;
  const mxArray *rhs27 = NULL;
  const mxArray *lhs27 = NULL;
  const mxArray *rhs28 = NULL;
  const mxArray *lhs28 = NULL;
  const mxArray *rhs29 = NULL;
  const mxArray *lhs29 = NULL;
  const mxArray *rhs30 = NULL;
  const mxArray *lhs30 = NULL;
  const mxArray *rhs31 = NULL;
  const mxArray *lhs31 = NULL;
  const mxArray *rhs32 = NULL;
  const mxArray *lhs32 = NULL;
  const mxArray *rhs33 = NULL;
  const mxArray *lhs33 = NULL;
  const mxArray *rhs34 = NULL;
  const mxArray *lhs34 = NULL;
  const mxArray *rhs35 = NULL;
  const mxArray *lhs35 = NULL;
  const mxArray *rhs36 = NULL;
  const mxArray *lhs36 = NULL;
  const mxArray *rhs37 = NULL;
  const mxArray *lhs37 = NULL;
  const mxArray *rhs38 = NULL;
  const mxArray *lhs38 = NULL;
  const mxArray *rhs39 = NULL;
  const mxArray *lhs39 = NULL;
  const mxArray *rhs40 = NULL;
  const mxArray *lhs40 = NULL;
  const mxArray *rhs41 = NULL;
  const mxArray *lhs41 = NULL;
  const mxArray *rhs42 = NULL;
  const mxArray *lhs42 = NULL;
  const mxArray *rhs43 = NULL;
  const mxArray *lhs43 = NULL;
  const mxArray *rhs44 = NULL;
  const mxArray *lhs44 = NULL;
  const mxArray *rhs45 = NULL;
  const mxArray *lhs45 = NULL;
  const mxArray *rhs46 = NULL;
  const mxArray *lhs46 = NULL;
  const mxArray *rhs47 = NULL;
  const mxArray *lhs47 = NULL;
  const mxArray *rhs48 = NULL;
  const mxArray *lhs48 = NULL;
  const mxArray *rhs49 = NULL;
  const mxArray *lhs49 = NULL;
  const mxArray *rhs50 = NULL;
  const mxArray *lhs50 = NULL;
  const mxArray *rhs51 = NULL;
  const mxArray *lhs51 = NULL;
  const mxArray *rhs52 = NULL;
  const mxArray *lhs52 = NULL;
  const mxArray *rhs53 = NULL;
  const mxArray *lhs53 = NULL;
  const mxArray *rhs54 = NULL;
  const mxArray *lhs54 = NULL;
  const mxArray *rhs55 = NULL;
  const mxArray *lhs55 = NULL;
  const mxArray *rhs56 = NULL;
  const mxArray *lhs56 = NULL;
  const mxArray *rhs57 = NULL;
  const mxArray *lhs57 = NULL;
  const mxArray *rhs58 = NULL;
  const mxArray *lhs58 = NULL;
  const mxArray *rhs59 = NULL;
  const mxArray *lhs59 = NULL;
  const mxArray *rhs60 = NULL;
  const mxArray *lhs60 = NULL;
  const mxArray *rhs61 = NULL;
  const mxArray *lhs61 = NULL;
  const mxArray *rhs62 = NULL;
  const mxArray *lhs62 = NULL;
  const mxArray *rhs63 = NULL;
  const mxArray *lhs63 = NULL;
  emlrtAddField(*info, emlrt_marshallOut(
    "[E]C:/SoftwareDevelopment/OPTIMISATION_CODE/code/C code  generator/ResidualsMatricesUC.m"),
                "context", 0);
  emlrtAddField(*info, emlrt_marshallOut("mpower"), "name", 0);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 0);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/mpower.m"),
                "resolved", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911538U), "fileTimeLo", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 0);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 0);
  emlrtAssign(&rhs0, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs0, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs0), "rhs", 0);
  emlrtAddField(*info, emlrtAliasP(lhs0), "lhs", 0);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/mpower.m"),
                "context", 1);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 1);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 1);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 1);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 1);
  emlrtAssign(&rhs1, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs1, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs1), "rhs", 1);
  emlrtAddField(*info, emlrtAliasP(lhs1), "lhs", 1);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/mpower.m"),
                "context", 2);
  emlrtAddField(*info, emlrt_marshallOut("ismatrix"), "name", 2);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 2);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/ismatrix.m"),
                "resolved", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 2);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 2);
  emlrtAssign(&rhs2, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs2, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs2), "rhs", 2);
  emlrtAddField(*info, emlrtAliasP(lhs2), "lhs", 2);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/mpower.m"),
                "context", 3);
  emlrtAddField(*info, emlrt_marshallOut("power"), "name", 3);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 3);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m"),
                "resolved", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(1419317430U), "fileTimeLo", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 3);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 3);
  emlrtAssign(&rhs3, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs3, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs3), "rhs", 3);
  emlrtAddField(*info, emlrtAliasP(lhs3), "lhs", 3);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m"),
                "context", 4);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 4);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 4);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 4);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 4);
  emlrtAssign(&rhs4, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs4, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs4), "rhs", 4);
  emlrtAddField(*info, emlrtAliasP(lhs4), "lhs", 4);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m!fltpower"),
                "context", 5);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 5);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 5);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 5);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 5);
  emlrtAssign(&rhs5, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs5, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs5), "rhs", 5);
  emlrtAddField(*info, emlrtAliasP(lhs5), "lhs", 5);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "context", 6);
  emlrtAddField(*info, emlrt_marshallOut("isnumerictype"), "name", 6);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 6);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isnumerictype.m"),
                "resolved", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 6);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 6);
  emlrtAssign(&rhs6, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs6, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs6), "rhs", 6);
  emlrtAddField(*info, emlrtAliasP(lhs6), "lhs", 6);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "context", 7);
  emlrtAddField(*info, emlrt_marshallOut("isfimath"), "name", 7);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 7);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfimath.m"),
                "resolved", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 7);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 7);
  emlrtAssign(&rhs7, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs7, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs7), "rhs", 7);
  emlrtAddField(*info, emlrtAliasP(lhs7), "lhs", 7);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m!firstfi"),
                "context", 8);
  emlrtAddField(*info, emlrt_marshallOut("eml_int_forloop_overflow_check"),
                "name", 8);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 8);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"),
                "resolved", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911534U), "fileTimeLo", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 8);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 8);
  emlrtAssign(&rhs8, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs8, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs8), "rhs", 8);
  emlrtAddField(*info, emlrtAliasP(lhs8), "lhs", 8);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_"
    "helper"), "context", 9);
  emlrtAddField(*info, emlrt_marshallOut("isfi"), "name", 9);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 9);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfi.m"),
                "resolved", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 9);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 9);
  emlrtAssign(&rhs9, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs9, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs9), "rhs", 9);
  emlrtAddField(*info, emlrtAliasP(lhs9), "lhs", 9);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfi.m"),
                "context", 10);
  emlrtAddField(*info, emlrt_marshallOut("isnumerictype"), "name", 10);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 10);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isnumerictype.m"),
                "resolved", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 10);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 10);
  emlrtAssign(&rhs10, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs10, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs10), "rhs", 10);
  emlrtAddField(*info, emlrtAliasP(lhs10), "lhs", 10);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_"
    "helper"), "context", 11);
  emlrtAddField(*info, emlrt_marshallOut("intmax"), "name", 11);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 11);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmax.m"),
                "resolved", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 11);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 11);
  emlrtAssign(&rhs11, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs11, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs11), "rhs", 11);
  emlrtAddField(*info, emlrtAliasP(lhs11), "lhs", 11);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m!eml_int_forloop_overflow_check_"
    "helper"), "context", 12);
  emlrtAddField(*info, emlrt_marshallOut("intmin"), "name", 12);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 12);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmin.m"),
                "resolved", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 12);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 12);
  emlrtAssign(&rhs12, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs12, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs12), "rhs", 12);
  emlrtAddField(*info, emlrtAliasP(lhs12), "lhs", 12);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m!firstfi"),
                "context", 13);
  emlrtAddField(*info, emlrt_marshallOut("isfi"), "name", 13);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 13);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/fixedpoint/isfi.m"),
                "resolved", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911524U), "fileTimeLo", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 13);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 13);
  emlrtAssign(&rhs13, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs13, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs13), "rhs", 13);
  emlrtAddField(*info, emlrtAliasP(lhs13), "lhs", 13);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m!fltpower"),
                "context", 14);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.applyScalarFunction"),
                "name", 14);
  emlrtAddField(*info, emlrt_marshallOut("function_handle"), "dominantType", 14);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"),
                "resolved", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(1422887902U), "fileTimeLo", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 14);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 14);
  emlrtAssign(&rhs14, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs14, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs14), "rhs", 14);
  emlrtAddField(*info, emlrtAliasP(lhs14), "lhs", 14);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"),
                "context", 15);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalexpAlloc"), "name",
                15);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 15);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAlloc.m"),
                "resolved", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911516U), "fileTimeLo", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 15);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 15);
  emlrtAssign(&rhs15, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs15, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs15), "rhs", 15);
  emlrtAddField(*info, emlrtAliasP(lhs15), "lhs", 15);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAlloc.m"),
                "context", 16);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalexpAllocNoCheck"),
                "name", 16);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 16);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalexpAllocNoCheck.m"),
                "resolved", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(1410440690U), "fileTimeLo", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 16);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 16);
  emlrtAssign(&rhs16, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs16, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs16), "rhs", 16);
  emlrtAddField(*info, emlrtAliasP(lhs16), "lhs", 16);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m!scalar_float_power"),
                "context", 17);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 17);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 17);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 17);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 17);
  emlrtAssign(&rhs17, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs17, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs17), "rhs", 17);
  emlrtAddField(*info, emlrtAliasP(lhs17), "lhs", 17);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m!fltpower_domain_error"),
                "context", 18);
  emlrtAddField(*info, emlrt_marshallOut("isnan"), "name", 18);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 18);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/isnan.m"),
                "resolved", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 18);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 18);
  emlrtAssign(&rhs18, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs18, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs18), "rhs", 18);
  emlrtAddField(*info, emlrtAliasP(lhs18), "lhs", 18);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/isnan.m"),
                "context", 19);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 19);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 19);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 19);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 19);
  emlrtAssign(&rhs19, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs19, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs19), "rhs", 19);
  emlrtAddField(*info, emlrtAliasP(lhs19), "lhs", 19);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m!fltpower_domain_error"),
                "context", 20);
  emlrtAddField(*info, emlrt_marshallOut("floor"), "name", 20);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 20);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/floor.m"),
                "resolved", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(1419317428U), "fileTimeLo", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 20);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 20);
  emlrtAssign(&rhs20, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs20, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs20), "rhs", 20);
  emlrtAddField(*info, emlrtAliasP(lhs20), "lhs", 20);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/floor.m"),
                "context", 21);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 21);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 21);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 21);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 21);
  emlrtAssign(&rhs21, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs21, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs21), "rhs", 21);
  emlrtAddField(*info, emlrtAliasP(lhs21), "lhs", 21);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/floor.m"),
                "context", 22);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalar.floor"), "name",
                22);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 22);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+scalar/floor.m"),
                "resolved", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911514U), "fileTimeLo", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 22);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 22);
  emlrtAssign(&rhs22, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs22, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs22), "rhs", 22);
  emlrtAddField(*info, emlrtAliasP(lhs22), "lhs", 22);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/floor.m"),
                "context", 23);
  emlrtAddField(*info, emlrt_marshallOut(
    "coder.internal.applyScalarFunctionInPlace"), "name", 23);
  emlrtAddField(*info, emlrt_marshallOut("function_handle"), "dominantType", 23);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/applyScalarFunctionInPlace.m"),
                "resolved", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(1422887800U), "fileTimeLo", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 23);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 23);
  emlrtAssign(&rhs23, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs23, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs23), "rhs", 23);
  emlrtAddField(*info, emlrtAliasP(lhs23), "lhs", 23);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/applyScalarFunctionInPlace.m"),
                "context", 24);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalar.floor"), "name",
                24);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 24);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+scalar/floor.m"),
                "resolved", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911514U), "fileTimeLo", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 24);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 24);
  emlrtAssign(&rhs24, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs24, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs24), "rhs", 24);
  emlrtAddField(*info, emlrtAliasP(lhs24), "lhs", 24);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/power.m!fltpower"),
                "context", 25);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.error"), "name", 25);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 25);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/error.m"),
                "resolved", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(1435849094U), "fileTimeLo", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 25);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 25);
  emlrtAssign(&rhs25, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs25, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs25), "rhs", 25);
  emlrtAddField(*info, emlrtAliasP(lhs25), "lhs", 25);
  emlrtAddField(*info, emlrt_marshallOut(
    "[E]C:/SoftwareDevelopment/OPTIMISATION_CODE/code/C code  generator/ResidualsMatricesUC.m"),
                "context", 26);
  emlrtAddField(*info, emlrt_marshallOut("eml_mtimes_helper"), "name", 26);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 26);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"),
                "resolved", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911538U), "fileTimeLo", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 26);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 26);
  emlrtAssign(&rhs26, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs26, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs26), "rhs", 26);
  emlrtAddField(*info, emlrtAliasP(lhs26), "lhs", 26);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m!common_checks"),
                "context", 27);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 27);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 27);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 27);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 27);
  emlrtAssign(&rhs27, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs27, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs27), "rhs", 27);
  emlrtAddField(*info, emlrtAliasP(lhs27), "lhs", 27);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"),
                "context", 28);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 28);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 28);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 28);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 28);
  emlrtAssign(&rhs28, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs28, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs28), "rhs", 28);
  emlrtAddField(*info, emlrtAliasP(lhs28), "lhs", 28);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"),
                "context", 29);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.blas.xgemm"), "name",
                29);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 29);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m"),
                "resolved", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911512U), "fileTimeLo", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 29);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 29);
  emlrtAssign(&rhs29, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs29, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs29), "rhs", 29);
  emlrtAddField(*info, emlrtAliasP(lhs29), "lhs", 29);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m"),
                "context", 30);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.blas.inline"), "name",
                30);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 30);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/inline.m"),
                "resolved", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(1375984264U), "fileTimeLo", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 30);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 30);
  emlrtAssign(&rhs30, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs30, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs30), "rhs", 30);
  emlrtAddField(*info, emlrtAliasP(lhs30), "lhs", 30);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m"),
                "context", 31);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.blas.use_refblas"),
                "name", 31);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 31);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/use_refblas.m"),
                "resolved", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(1375984264U), "fileTimeLo", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 31);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 31);
  emlrtAssign(&rhs31, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs31, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs31), "rhs", 31);
  emlrtAddField(*info, emlrtAliasP(lhs31), "lhs", 31);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m!below_threshold"),
                "context", 32);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.blas.threshold"),
                "name", 32);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 32);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/threshold.m"),
                "resolved", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(1375984264U), "fileTimeLo", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 32);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 32);
  emlrtAssign(&rhs32, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs32, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs32), "rhs", 32);
  emlrtAddField(*info, emlrtAliasP(lhs32), "lhs", 32);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m"),
                "context", 33);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 33);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 33);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 33);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 33);
  emlrtAssign(&rhs33, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs33, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs33), "rhs", 33);
  emlrtAddField(*info, emlrtAliasP(lhs33), "lhs", 33);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m"),
                "context", 34);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.refblas.xgemm"), "name",
                34);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 34);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+refblas/xgemm.m"),
                "resolved", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911512U), "fileTimeLo", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 34);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 34);
  emlrtAssign(&rhs34, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs34, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs34), "rhs", 34);
  emlrtAddField(*info, emlrtAliasP(lhs34), "lhs", 34);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+refblas/xgemm.m"),
                "context", 35);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexMinus"), "name",
                35);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 35);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/indexMinus.m"),
                "resolved", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(1372586760U), "fileTimeLo", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 35);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 35);
  emlrtAssign(&rhs35, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs35, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs35), "rhs", 35);
  emlrtAddField(*info, emlrtAliasP(lhs35), "lhs", 35);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+refblas/xgemm.m"),
                "context", 36);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 36);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 36);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 36);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 36);
  emlrtAssign(&rhs36, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs36, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs36), "rhs", 36);
  emlrtAddField(*info, emlrtAliasP(lhs36), "lhs", 36);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+refblas/xgemm.m"),
                "context", 37);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexTimes"), "name",
                37);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 37);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/indexTimes.m"),
                "resolved", 37);
  emlrtAddField(*info, b_emlrt_marshallOut(1372586760U), "fileTimeLo", 37);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 37);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 37);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 37);
  emlrtAssign(&rhs37, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs37, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs37), "rhs", 37);
  emlrtAddField(*info, emlrtAliasP(lhs37), "lhs", 37);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+refblas/xgemm.m"),
                "context", 38);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexPlus"), "name", 38);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 38);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/indexPlus.m"),
                "resolved", 38);
  emlrtAddField(*info, b_emlrt_marshallOut(1372586760U), "fileTimeLo", 38);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 38);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 38);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 38);
  emlrtAssign(&rhs38, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs38, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs38), "rhs", 38);
  emlrtAddField(*info, emlrtAliasP(lhs38), "lhs", 38);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+refblas/xgemm.m"),
                "context", 39);
  emlrtAddField(*info, emlrt_marshallOut("eml_int_forloop_overflow_check"),
                "name", 39);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 39);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"),
                "resolved", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911534U), "fileTimeLo", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 39);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 39);
  emlrtAssign(&rhs39, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs39, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs39), "rhs", 39);
  emlrtAddField(*info, emlrtAliasP(lhs39), "lhs", 39);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+refblas/xgemm.m"),
                "context", 40);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexPlus"), "name", 40);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 40);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/indexPlus.m"),
                "resolved", 40);
  emlrtAddField(*info, b_emlrt_marshallOut(1372586760U), "fileTimeLo", 40);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 40);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 40);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 40);
  emlrtAssign(&rhs40, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs40, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs40), "rhs", 40);
  emlrtAddField(*info, emlrtAliasP(lhs40), "lhs", 40);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m"),
                "context", 41);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.blas.int"), "name", 41);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 41);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/int.m"),
                "resolved", 41);
  emlrtAddField(*info, b_emlrt_marshallOut(1375984264U), "fileTimeLo", 41);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 41);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 41);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 41);
  emlrtAssign(&rhs41, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs41, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs41), "rhs", 41);
  emlrtAddField(*info, emlrtAliasP(lhs41), "lhs", 41);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m!ceval_xgemm"),
                "context", 42);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.blas.size_ptr"), "name",
                42);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 42);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/size_ptr.m"),
                "resolved", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(1375984264U), "fileTimeLo", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 42);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 42);
  emlrtAssign(&rhs42, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs42, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs42), "rhs", 42);
  emlrtAddField(*info, emlrtAliasP(lhs42), "lhs", 42);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m!ceval_xgemm"),
                "context", 43);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.c_cast"), "name", 43);
  emlrtAddField(*info, emlrt_marshallOut("int32"), "dominantType", 43);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/coder/coder/+coder/+internal/c_cast.p"),
                "resolved", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(1438289598U), "fileTimeLo", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 43);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 43);
  emlrtAssign(&rhs43, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs43, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs43), "rhs", 43);
  emlrtAddField(*info, emlrtAliasP(lhs43), "lhs", 43);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/+blas/xgemm.m!ceval_xgemm"),
                "context", 44);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.scalarEg"), "name", 44);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 44);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/scalarEg.m"),
                "resolved", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(1430220368U), "fileTimeLo", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 44);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 44);
  emlrtAssign(&rhs44, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs44, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs44), "rhs", 44);
  emlrtAddField(*info, emlrtAliasP(lhs44), "lhs", 44);
  emlrtAddField(*info, emlrt_marshallOut(
    "[E]C:/SoftwareDevelopment/OPTIMISATION_CODE/code/C code  generator/ResidualsMatricesUC.m"),
                "context", 45);
  emlrtAddField(*info, emlrt_marshallOut("reshape"), "name", 45);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 45);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m"),
                "resolved", 45);
  emlrtAddField(*info, b_emlrt_marshallOut(1430232488U), "fileTimeLo", 45);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 45);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 45);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 45);
  emlrtAssign(&rhs45, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs45, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs45), "rhs", 45);
  emlrtAddField(*info, emlrtAliasP(lhs45), "lhs", 45);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m"),
                "context", 46);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.narginchk"), "name", 46);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 46);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/narginchk.m"),
                "resolved", 46);
  emlrtAddField(*info, b_emlrt_marshallOut(1363718158U), "fileTimeLo", 46);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 46);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 46);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 46);
  emlrtAssign(&rhs46, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs46, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs46), "rhs", 46);
  emlrtAddField(*info, emlrtAliasP(lhs46), "lhs", 46);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/narginchk.m"),
                "context", 47);
  emlrtAddField(*info, emlrt_marshallOut("floor"), "name", 47);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 47);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elfun/floor.m"),
                "resolved", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(1419317428U), "fileTimeLo", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 47);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 47);
  emlrtAssign(&rhs47, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs47, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs47), "rhs", 47);
  emlrtAddField(*info, emlrtAliasP(lhs47), "lhs", 47);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m!varargin_nempty"),
                "context", 48);
  emlrtAddField(*info, emlrt_marshallOut("eml_int_forloop_overflow_check"),
                "name", 48);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 48);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"),
                "resolved", 48);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911534U), "fileTimeLo", 48);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 48);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 48);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 48);
  emlrtAssign(&rhs48, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs48, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs48), "rhs", 48);
  emlrtAddField(*info, emlrtAliasP(lhs48), "lhs", 48);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m!computeDimsData"),
                "context", 49);
  emlrtAddField(*info, emlrt_marshallOut("eml_int_forloop_overflow_check"),
                "name", 49);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 49);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/eml/eml_int_forloop_overflow_check.m"),
                "resolved", 49);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911534U), "fileTimeLo", 49);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 49);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 49);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 49);
  emlrtAssign(&rhs49, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs49, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs49), "rhs", 49);
  emlrtAddField(*info, emlrtAliasP(lhs49), "lhs", 49);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m!computeDimsData"),
                "context", 50);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.assertValidSizeArg"),
                "name", 50);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 50);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m"),
                "resolved", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(1427212622U), "fileTimeLo", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 50);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 50);
  emlrtAssign(&rhs50, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs50, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs50), "rhs", 50);
  emlrtAddField(*info, emlrtAliasP(lhs50), "lhs", 50);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m"),
                "context", 51);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 51);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 51);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 51);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 51);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 51);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 51);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 51);
  emlrtAssign(&rhs51, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs51, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs51), "rhs", 51);
  emlrtAddField(*info, emlrtAliasP(lhs51), "lhs", 51);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m!isintegral"),
                "context", 52);
  emlrtAddField(*info, emlrt_marshallOut("isinf"), "name", 52);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 52);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/isinf.m"),
                "resolved", 52);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 52);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 52);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 52);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 52);
  emlrtAssign(&rhs52, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs52, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs52), "rhs", 52);
  emlrtAddField(*info, emlrtAliasP(lhs52), "lhs", 52);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/isinf.m"),
                "context", 53);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isBuiltInNumeric"),
                "name", 53);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 53);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isBuiltInNumeric.m"),
                "resolved", 53);
  emlrtAddField(*info, b_emlrt_marshallOut(1395935456U), "fileTimeLo", 53);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 53);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 53);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 53);
  emlrtAssign(&rhs53, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs53, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs53), "rhs", 53);
  emlrtAddField(*info, emlrtAliasP(lhs53), "lhs", 53);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m!isinbounds"),
                "context", 54);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.isIntegerClass"),
                "name", 54);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 54);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/isIntegerClass.m"),
                "resolved", 54);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911514U), "fileTimeLo", 54);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 54);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 54);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 54);
  emlrtAssign(&rhs54, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs54, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs54), "rhs", 54);
  emlrtAddField(*info, emlrtAliasP(lhs54), "lhs", 54);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m!isinbounds"),
                "context", 55);
  emlrtAddField(*info, emlrt_marshallOut("intmax"), "name", 55);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 55);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmax.m"),
                "resolved", 55);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 55);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 55);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 55);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 55);
  emlrtAssign(&rhs55, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs55, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs55), "rhs", 55);
  emlrtAddField(*info, emlrtAliasP(lhs55), "lhs", 55);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m!isinbounds"),
                "context", 56);
  emlrtAddField(*info, emlrt_marshallOut("intmin"), "name", 56);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 56);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmin.m"),
                "resolved", 56);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 56);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 56);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 56);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 56);
  emlrtAssign(&rhs56, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs56, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs56), "rhs", 56);
  emlrtAddField(*info, emlrtAliasP(lhs56), "lhs", 56);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m!isinbounds"),
                "context", 57);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexIntRelop"), "name",
                57);
  emlrtAddField(*info, emlrt_marshallOut(""), "dominantType", 57);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/indexIntRelop.m"),
                "resolved", 57);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911546U), "fileTimeLo", 57);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 57);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 57);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 57);
  emlrtAssign(&rhs57, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs57, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs57), "rhs", 57);
  emlrtAddField(*info, emlrtAliasP(lhs57), "lhs", 57);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/indexIntRelop.m!float_class_contains_indexIntCl"
    "ass"), "context", 58);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.floatModel"), "name",
                58);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 58);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/floatModel.m"),
                "resolved", 58);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911514U), "fileTimeLo", 58);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 58);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 58);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 58);
  emlrtAssign(&rhs58, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs58, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs58), "rhs", 58);
  emlrtAddField(*info, emlrtAliasP(lhs58), "lhs", 58);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/shared/coder/coder/+coder/+internal/indexIntRelop.m!is_signed_indexIntClass"),
                "context", 59);
  emlrtAddField(*info, emlrt_marshallOut("intmin"), "name", 59);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 59);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmin.m"),
                "resolved", 59);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 59);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 59);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 59);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 59);
  emlrtAssign(&rhs59, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs59, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs59), "rhs", 59);
  emlrtAddField(*info, emlrtAliasP(lhs59), "lhs", 59);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m"),
                "context", 60);
  emlrtAddField(*info, emlrt_marshallOut("intmin"), "name", 60);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 60);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmin.m"),
                "resolved", 60);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 60);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 60);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 60);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 60);
  emlrtAssign(&rhs60, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs60, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs60), "rhs", 60);
  emlrtAddField(*info, emlrtAliasP(lhs60), "lhs", 60);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/assertValidSizeArg.m"),
                "context", 61);
  emlrtAddField(*info, emlrt_marshallOut("intmax"), "name", 61);
  emlrtAddField(*info, emlrt_marshallOut("char"), "dominantType", 61);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/intmax.m"),
                "resolved", 61);
  emlrtAddField(*info, b_emlrt_marshallOut(1415911532U), "fileTimeLo", 61);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 61);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 61);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 61);
  emlrtAssign(&rhs61, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs61, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs61), "rhs", 61);
  emlrtAddField(*info, emlrtAliasP(lhs61), "lhs", 61);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m!computeDimsData"),
                "context", 62);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexTimes"), "name",
                62);
  emlrtAddField(*info, emlrt_marshallOut("double"), "dominantType", 62);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/indexTimes.m"),
                "resolved", 62);
  emlrtAddField(*info, b_emlrt_marshallOut(1372586760U), "fileTimeLo", 62);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 62);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 62);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 62);
  emlrtAssign(&rhs62, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs62, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs62), "rhs", 62);
  emlrtAddField(*info, emlrtAliasP(lhs62), "lhs", 62);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/lib/matlab/elmat/reshape.m!computeDimsData"),
                "context", 63);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexDivide"), "name",
                63);
  emlrtAddField(*info, emlrt_marshallOut("coder.internal.indexInt"),
                "dominantType", 63);
  emlrtAddField(*info, emlrt_marshallOut(
    "[ILXE]C:/Program Files/MATLAB/R2015b/toolbox/eml/eml/+coder/+internal/indexDivide.m"),
                "resolved", 63);
  emlrtAddField(*info, b_emlrt_marshallOut(1372586760U), "fileTimeLo", 63);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "fileTimeHi", 63);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeLo", 63);
  emlrtAddField(*info, b_emlrt_marshallOut(0U), "mFileTimeHi", 63);
  emlrtAssign(&rhs63, emlrtCreateCellMatrix(0, 1));
  emlrtAssign(&lhs63, emlrtCreateCellMatrix(0, 1));
  emlrtAddField(*info, emlrtAliasP(rhs63), "rhs", 63);
  emlrtAddField(*info, emlrtAliasP(lhs63), "lhs", 63);
  emlrtDestroyArray(&rhs0);
  emlrtDestroyArray(&lhs0);
  emlrtDestroyArray(&rhs1);
  emlrtDestroyArray(&lhs1);
  emlrtDestroyArray(&rhs2);
  emlrtDestroyArray(&lhs2);
  emlrtDestroyArray(&rhs3);
  emlrtDestroyArray(&lhs3);
  emlrtDestroyArray(&rhs4);
  emlrtDestroyArray(&lhs4);
  emlrtDestroyArray(&rhs5);
  emlrtDestroyArray(&lhs5);
  emlrtDestroyArray(&rhs6);
  emlrtDestroyArray(&lhs6);
  emlrtDestroyArray(&rhs7);
  emlrtDestroyArray(&lhs7);
  emlrtDestroyArray(&rhs8);
  emlrtDestroyArray(&lhs8);
  emlrtDestroyArray(&rhs9);
  emlrtDestroyArray(&lhs9);
  emlrtDestroyArray(&rhs10);
  emlrtDestroyArray(&lhs10);
  emlrtDestroyArray(&rhs11);
  emlrtDestroyArray(&lhs11);
  emlrtDestroyArray(&rhs12);
  emlrtDestroyArray(&lhs12);
  emlrtDestroyArray(&rhs13);
  emlrtDestroyArray(&lhs13);
  emlrtDestroyArray(&rhs14);
  emlrtDestroyArray(&lhs14);
  emlrtDestroyArray(&rhs15);
  emlrtDestroyArray(&lhs15);
  emlrtDestroyArray(&rhs16);
  emlrtDestroyArray(&lhs16);
  emlrtDestroyArray(&rhs17);
  emlrtDestroyArray(&lhs17);
  emlrtDestroyArray(&rhs18);
  emlrtDestroyArray(&lhs18);
  emlrtDestroyArray(&rhs19);
  emlrtDestroyArray(&lhs19);
  emlrtDestroyArray(&rhs20);
  emlrtDestroyArray(&lhs20);
  emlrtDestroyArray(&rhs21);
  emlrtDestroyArray(&lhs21);
  emlrtDestroyArray(&rhs22);
  emlrtDestroyArray(&lhs22);
  emlrtDestroyArray(&rhs23);
  emlrtDestroyArray(&lhs23);
  emlrtDestroyArray(&rhs24);
  emlrtDestroyArray(&lhs24);
  emlrtDestroyArray(&rhs25);
  emlrtDestroyArray(&lhs25);
  emlrtDestroyArray(&rhs26);
  emlrtDestroyArray(&lhs26);
  emlrtDestroyArray(&rhs27);
  emlrtDestroyArray(&lhs27);
  emlrtDestroyArray(&rhs28);
  emlrtDestroyArray(&lhs28);
  emlrtDestroyArray(&rhs29);
  emlrtDestroyArray(&lhs29);
  emlrtDestroyArray(&rhs30);
  emlrtDestroyArray(&lhs30);
  emlrtDestroyArray(&rhs31);
  emlrtDestroyArray(&lhs31);
  emlrtDestroyArray(&rhs32);
  emlrtDestroyArray(&lhs32);
  emlrtDestroyArray(&rhs33);
  emlrtDestroyArray(&lhs33);
  emlrtDestroyArray(&rhs34);
  emlrtDestroyArray(&lhs34);
  emlrtDestroyArray(&rhs35);
  emlrtDestroyArray(&lhs35);
  emlrtDestroyArray(&rhs36);
  emlrtDestroyArray(&lhs36);
  emlrtDestroyArray(&rhs37);
  emlrtDestroyArray(&lhs37);
  emlrtDestroyArray(&rhs38);
  emlrtDestroyArray(&lhs38);
  emlrtDestroyArray(&rhs39);
  emlrtDestroyArray(&lhs39);
  emlrtDestroyArray(&rhs40);
  emlrtDestroyArray(&lhs40);
  emlrtDestroyArray(&rhs41);
  emlrtDestroyArray(&lhs41);
  emlrtDestroyArray(&rhs42);
  emlrtDestroyArray(&lhs42);
  emlrtDestroyArray(&rhs43);
  emlrtDestroyArray(&lhs43);
  emlrtDestroyArray(&rhs44);
  emlrtDestroyArray(&lhs44);
  emlrtDestroyArray(&rhs45);
  emlrtDestroyArray(&lhs45);
  emlrtDestroyArray(&rhs46);
  emlrtDestroyArray(&lhs46);
  emlrtDestroyArray(&rhs47);
  emlrtDestroyArray(&lhs47);
  emlrtDestroyArray(&rhs48);
  emlrtDestroyArray(&lhs48);
  emlrtDestroyArray(&rhs49);
  emlrtDestroyArray(&lhs49);
  emlrtDestroyArray(&rhs50);
  emlrtDestroyArray(&lhs50);
  emlrtDestroyArray(&rhs51);
  emlrtDestroyArray(&lhs51);
  emlrtDestroyArray(&rhs52);
  emlrtDestroyArray(&lhs52);
  emlrtDestroyArray(&rhs53);
  emlrtDestroyArray(&lhs53);
  emlrtDestroyArray(&rhs54);
  emlrtDestroyArray(&lhs54);
  emlrtDestroyArray(&rhs55);
  emlrtDestroyArray(&lhs55);
  emlrtDestroyArray(&rhs56);
  emlrtDestroyArray(&lhs56);
  emlrtDestroyArray(&rhs57);
  emlrtDestroyArray(&lhs57);
  emlrtDestroyArray(&rhs58);
  emlrtDestroyArray(&lhs58);
  emlrtDestroyArray(&rhs59);
  emlrtDestroyArray(&lhs59);
  emlrtDestroyArray(&rhs60);
  emlrtDestroyArray(&lhs60);
  emlrtDestroyArray(&rhs61);
  emlrtDestroyArray(&lhs61);
  emlrtDestroyArray(&rhs62);
  emlrtDestroyArray(&lhs62);
  emlrtDestroyArray(&rhs63);
  emlrtDestroyArray(&lhs63);
}

mxArray *emlrtMexFcnProperties()
{
  mxArray *xResult;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xEntryPoints;
  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 9);
  emlrtSetField(xEntryPoints, 0, "Name", mxCreateString("ResidualsMatricesUC"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", mxCreateDoubleScalar(9.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", mxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", mxCreateString("8.6.0.267246 (R2015b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo()
{
  const mxArray *nameCaptureInfo;
  nameCaptureInfo = NULL;
  emlrtAssign(&nameCaptureInfo, emlrtCreateStructMatrix(85, 1, 0, NULL));
  info_helper(&nameCaptureInfo);
  b_info_helper(&nameCaptureInfo);
  emlrtNameCapturePostProcessR2013b(&nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_ResidualsMatricesUC_info.cpp) */
