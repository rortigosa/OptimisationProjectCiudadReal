/*
 * _coder_func_1_info.c
 *
 * Code generation for function '_coder_func_1_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_1.h"
#include "_coder_func_1_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 7);
  emlrtSetField(xEntryPoints, 0, "Name", mxCreateString("func_1"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", mxCreateDoubleScalar(7.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", mxCreateDoubleScalar(2.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", mxCreateString("9.2.0.538062 (R2017a)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[15] = {
    "789ced5cbb6fdb461867d2a4488616ecd047fa8cfb98029892adc476bbe845d9b22d9bb6944471504814759468f12191d4c39e0c14e854b4ff40a74e1d3a74ec"
    "18a043fb07f401141d3a7428d0bd7349512789575fa4581455d2778071bcfca8fb7dfaf2f17e77df9d485dc9e6ae5014f522e59462cda95f18b4e9417d957217",
    "14bf32a85f42dab05ca7aeb93e07f12f07b5a0a926e8994e439654b0d7562a40b71a2aaf806137554d91545e350b274d40e9c0d0e40ea8f6115192414152c0ae"
    "36d6d892ac86921983860d1bb2af53752034f26d85d2ebc6c85c79bc418df9e76bccf7bf36a57f588c7f68047fcc7e9cfa9049186d83c9b36c9ac9f1e62e5fb9",
    "2d6855c0aca69994551b4c57d31ba51c5b644c60988cd85685d2e82abaac8cd9ddc3d8f5fc94763f87b1fbe6a07ecdf5afefc69dfaeea0be179f64c7b4fec3c5"
    "178de040914b8a69fd3f1ba53a909bfd48b20bb4a37c413bd082b30316c8f7dd05f960fff9097c107f9cdd2df64387d3b59ace2bb7ed1837985ca2b09b483287",
    "2b91e81acf989a2657b41e63398991a50aa3f0a6cc5718ad6930fff15b3f8a26fb6dda38426b586e5237e0e5077ffef673c247be7eb92c7cb33e7faf60f86804"
    "af1e9df0b18ac017d3313e71aab105e5f8513333b2839bc033c90e0ad3f6abff1f319f9fd68f3ca67f1ac1e7f03c2f099aa2686a49b0950fca1cfc5e4d8cddd3",
    "c6e355a40d0bd409d7f878968f3b1785a13e9c61fa9fd6afef60f86904b785545f96ac4987aef2f2b26424db926c66556bda01744998592720fff3487b648f83"
    "54b5764506dee94411cbe7c69f39aeecbf3b7daf3177a0db18d46dcb8a7fe3dad97b442782af13fb9d562a216e75d60b07b1138155d495cc91bc151e9d08cbbc",
    "cf5f5dd8893b35e7d9bae1550c3f8de0882e18022ff33a5b5b981e7c3b231f87b429e43e887ba307d05dbeeac0cdcf7e273a10741d88ec75d79482a41ced4887"
    "5576272de445f124191e1d20cff1f9f6bbe2ee2c179fa437d3fa0bcd3352c87d10970cd599ba9a764671f6fcd0a2c6f97d2c9f1bbfd03c41947aa0dad4acf060",
    "5cfeb2e6083ec6c7adcc2d32ce077d9cdf5c6d9ce45b35494e15528dc356b25668dc67d3649cbface33c8e6f5a7fdd40dad4f03e07910c51b29639f5a08eebdb"
    "583e373efbb8eef869b0ec23e37a48f8661dd75fc6f0d108de6901b6d9118c8d627755d338231f5d7d744485675c0f565e7634ae2f89926e98a2e46bfc3d297b",
    "96cf7f1bc34723b89dbfb2be7e49d47459d39a25ad037451d6bace2ec7e2f67d9f5c900ff65f9ec007f159f27f83307a8aff7ccde77cf3ebf55f881ecc89cfaf"
    "79beb1c3f6d8f4e929b7dd5b89e55622a9834434c286470ffec27c7e5a3f7e8ae99f46f0793fd74b4fbf617878c6df78ddf46c7d700d6953c3fb1cc49ef7daf5",
    "82f71924b50a7a59d5f4ec9c5966821d10f762dd60af197c8c8ff7c9be6ff0f5217fd29494bbadc38751a9528d658f0eb85cb413a23c10797eddc51d6f91d0e4"
    "f927e98b50e7fb474f499efffc1a16920ff2878fe4f9bde99fccffddf67a1baf59cfe6ff93f2f5d65757f85e70f560aefb03308e64eb82713cb580fd8137881e",
    "045f0fe4debd231039de8fdc97929142f734cac7642e44e73c891eb8edf576bfd85f3d9054a207d3e981a4123d08179f5f7a70379b6b341b7ba0676ee5f2356e"
    "7387db8cc8213aef49f68bcfaf6171c5df1f65cfc6f767cdf7cfcaf7ace781485ed05d485edf1f3e92d7f7a6ffb0fc9eab8cb1d3dbf83bf0ec1cd02d0c1f8de0",
    "c8be6a45e68de55e0d288369eac2e6f5ffdbb839773e70c7f61bd3f79bff71f3f9477f131d08ba0edc338f6bd543f5b8555c13125bbd8dce16b7a6101db88ccf"
    "b335f86f7ba603af63f868043f4f0724d57eb194832fea3ce8ac715398c007712fe3c6f19b13383ec6cd57ff9cfd4474604e7c7ee940b2c2278ce45e8cebc8eb",
    "07aa69ae3f6cb45a9b44072ea50e5039cf74e082eff9e9eb40db00251d88f675607f17f068021fc4bd8c9b31bfc1b43fd18390f0f9a5077a2217cb27c4d4bec0"
    "1ac631ff205bdf482ba9f0e8c1acef851330fdd3083e073d58aa007b9fd7acebc0a86b72d5f5bdca18bb3d8dc7f863cff4e12d0c1f8de0e7e9c3b807829a2f7a",
    "88e573e35ec6d1d06ffe9e17fd61f57b922f0aba2ee4aa0f36f6f7d6db9b99edea5e4bdbe7eea74f5743f47bb1b0ac139a183be7f31e382edeafe3a37d04f21e"
    "b88bf171489b42ee837870df2b42de03374f3ef21e386ffa0f8b0e9431767abb6fb0efd97ae04d0c1f8de0c8b80fd31dc32de4a0ae071e60f9dcb8477133f0db",
    "28747cd4812f3e69101d08ba0e8820d9ddd09ad162eba069aee7957a3793e886204ff42f609a4bb9",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 26480U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_func_1_info.c) */
