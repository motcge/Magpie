//!MAGPIE EFFECT
//!VERSION 4
//!SORT_NAME SMAA_1


//!TEXTURE
Texture2D INPUT;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
Texture2D OUTPUT;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R8G8_UNORM
Texture2D edgesTex;

//!TEXTURE
//!WIDTH INPUT_WIDTH
//!HEIGHT INPUT_HEIGHT
//!FORMAT R8G8B8A8_UNORM
Texture2D blendTex;

//!TEXTURE
//!SOURCE AreaTex.dds
//!FORMAT R8G8B8A8_UNORM
Texture2D areaTex;

//!TEXTURE
//!SOURCE SearchTex.dds
//!FORMAT R8_UNORM
Texture2D searchTex;

//!SAMPLER
//!FILTER POINT
SamplerState PointSampler;

//!SAMPLER
//!FILTER LINEAR
SamplerState LinearSampler;


//!COMMON

#define SMAA_RT_METRICS float4(GetInputPt(), GetInputSize())
#define SMAA_LINEAR_SAMPLER LinearSampler
#define SMAA_POINT_SAMPLER PointSampler
#define SMAA_PRESET_MEDIUM
#include "SMAA.hlsli"

//!PASS 1
//!DESC Luma Edge Detection
//!STYLE PS
//!IN INPUT
//!OUT edgesTex

float2 Pass1(float2 pos) {
	return SMAALumaEdgeDetectionPS(pos, INPUT);
}

//!PASS 2
//!DESC Blending Weight Calculation
//!STYLE PS
//!IN edgesTex, areaTex, searchTex
//!OUT blendTex

float4 Pass2(float2 pos) {
	return SMAABlendingWeightCalculationPS(pos, edgesTex, areaTex, searchTex, 0);
}

//!PASS 3
//!DESC Neighborhood Blending
//!STYLE PS
//!IN INPUT, blendTex
//!OUT OUTPUT

float4 Pass3(float2 pos) {
	return SMAANeighborhoodBlendingPS(pos, INPUT, blendTex);
}
