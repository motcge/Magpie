// Conv-4x3x3x8 (1)
// ��ֲ�� https://github.com/bloc97/Anime4K/blob/master/glsl/Upscale%2BDeblur/Anime4K_Upscale_CNN_M_x2_Deblur.glsl
//
// Anime4K-v3.1-Upscale(x2)-CNN(M)-Conv-4x3x3x8


cbuffer constants : register(b0) {
	int2 srcSize : packoffset(c0);
};


#define D2D_INPUT_COUNT 1
#define D2D_INPUT0_COMPLEX
#define MAGPIE_USE_SAMPLE_INPUT
#include "Anime4K.hlsli"



D2D_PS_ENTRY(main) {
	InitMagpieSampleInput();

	float left1X = GetCheckedLeft(1);
	float right1X = GetCheckedRight(1);
	float top1Y = GetCheckedTop(1);
	float bottom1Y = GetCheckedBottom(1);

	// [ a, d, g ]
	// [ b, e, h ]
	// [ c, f, i ]
	float4 a = Uncompress(SampleInputRGBANoCheck(0, float2(left1X, top1Y)));
	float4 b = Uncompress(SampleInputRGBANoCheck(0, float2(left1X, coord.y)));
	float4 c = Uncompress(SampleInputRGBANoCheck(0, float2(left1X, bottom1Y)));
	float4 d = Uncompress(SampleInputRGBANoCheck(0, float2(coord.x, top1Y)));
	float4 e = Uncompress(SampleInputRGBACur(0));
	float4 f = Uncompress(SampleInputRGBANoCheck(0, float2(coord.x, bottom1Y)));
	float4 g = Uncompress(SampleInputRGBANoCheck(0, float2(right1X, top1Y)));
	float4 h = Uncompress(SampleInputRGBANoCheck(0, float2(right1X, coord.y)));
	float4 i = Uncompress(SampleInputRGBANoCheck(0, float2(right1X, bottom1Y)));

	float4 na = -min(a, ZEROS4);
	float4 nb = -min(b, ZEROS4);
	float4 nc = -min(c, ZEROS4);
	float4 nd = -min(d, ZEROS4);
	float4 ne = -min(e, ZEROS4);
	float4 nf = -min(f, ZEROS4);
	float4 ng = -min(g, ZEROS4);
	float4 nh = -min(h, ZEROS4);
	float4 ni = -min(i, ZEROS4);

	a = max(a, ZEROS4);
	b = max(b, ZEROS4);
	c = max(c, ZEROS4);
	d = max(d, ZEROS4);
	e = max(e, ZEROS4);
	f = max(f, ZEROS4);
	g = max(g, ZEROS4);
	h = max(h, ZEROS4);
	i = max(i, ZEROS4);

	float s = -0.015687061 * a.x + -0.005086804 * b.x + -0.08009774 * c.x + 0.4036132 * d.x + -0.55772984 * e.x + -0.2755099 * f.x + -0.1277555 * g.x + 0.48264486 * h.x + -0.039350368 * i.x;
	float t = -0.1956287 * a.y + 0.24631155 * b.y + -0.1362055 * c.y + -0.017237768 * d.y + -0.31328484 * e.y + 0.32078618 * f.y + 0.17252642 * g.y + 1.288781 * h.y + 0.6368975 * i.y;
	float u = 0.02843324 * a.z + -0.18332094 * b.z + 0.049802452 * c.z + -0.010743182 * d.z + 0.17832276 * e.z + -0.2522149 * f.z + -0.099589445 * g.z + 0.37256712 * h.z + -0.28898144 * i.z;
	float v = 0.30594558 * a.w + 0.3486534 * b.w + 0.26476768 * c.w + -0.076578766 * d.w + -0.3232688 * e.w + -0.14864787 * f.w + -0.6317181 * g.w + -0.06437228 * h.w + 0.640803 * i.w;
	float w = 0.17802098 * na.x + 0.05835295 * nb.x + -0.058673255 * nc.x + -0.014066361 * nd.x + 0.33812046 * ne.x + 0.25138128 * nf.x + -0.072104186 * ng.x + -0.36128563 * nh.x + 0.07699219 * ni.x;
	float x = 0.16941643 * na.y + -0.15021013 * nb.y + 0.15018505 * nc.y + -0.05500566 * nd.y + 0.15511088 * ne.y + -0.2458257 * nf.y + -0.5108843 * ng.y + -1.476235 * nh.y + -0.71722806 * ni.y;
	float y = 0.00975281 * na.z + 0.19094622 * nb.z + 0.021969974 * nc.z + -0.04512019 * nd.z + -0.044636417 * ne.z + 0.21892478 * nf.z + 0.070494205 * ng.z + 0.0051582125 * nh.z + 0.103034526 * ni.z;
	float z = -0.31174728 * na.w + -0.52086604 * nb.w + -0.13394079 * nc.w + 0.19892856 * nd.w + 0.36054957 * ne.w + 0.09852359 * nf.w + 0.51038855 * ng.w + -0.1278927 * nh.w + -0.4340372 * ni.w;
	float o = s + t + u + v + w + x + y + z + 0.035186045;
	s = -0.09755112 * a.x + 0.007670719 * b.x + 0.015862316 * c.x + -0.074987575 * d.x + 0.15913595 * e.x + -0.021152943 * f.x + 0.18060294 * g.x + 0.022476852 * h.x + 0.029400269 * i.x;
	t = 0.13646232 * a.y + -0.41485998 * b.y + 0.017277138 * c.y + -0.38909444 * d.y + -0.1432292 * e.y + 0.15183213 * f.y + -0.34036225 * g.y + 0.210981 * h.y + -0.14121912 * i.y;
	u = -0.0792608 * a.z + 0.27101266 * b.z + 0.009590067 * c.z + 0.12913375 * d.z + -0.07959797 * e.z + -0.048253924 * f.z + 0.047642067 * g.z + 0.2640562 * h.z + 0.11656182 * i.z;
	v = -0.059286937 * a.w + -0.27622 * b.w + -0.042677224 * c.w + 0.03761667 * d.w + 0.029374314 * e.w + -0.099095084 * f.w + 0.109775394 * g.w + -0.27415258 * h.w + 0.07044724 * i.w;
	w = 0.24230115 * na.x + 0.17628567 * nb.x + 0.0020990286 * nc.x + 0.96724355 * nd.x + 0.02996021 * ne.x + 0.019217826 * nf.x + 0.1365564 * ng.x + 0.071021535 * nh.x + -0.06381019 * ni.x;
	x = -0.20798545 * na.y + 0.34536365 * nb.y + -0.02818564 * nc.y + 0.18876718 * nd.y + 0.15433654 * ne.y + -0.18622455 * nf.y + 0.11045272 * ng.y + -0.2562474 * nh.y + 0.04179886 * ni.y;
	y = 0.10773426 * na.z + -0.28337282 * nb.z + -0.08160168 * nc.z + -0.06236418 * nd.z + 0.312426 * ne.z + -0.03483054 * nf.z + -0.09783074 * ng.z + 0.013053401 * nh.z + -0.09047153 * ni.z;
	z = 0.12738748 * na.w + 0.32590875 * nb.w + 0.017520528 * nc.w + 0.28071648 * nd.w + -0.78307766 * ne.w + 0.078845695 * nf.w + -0.2234345 * ng.w + 0.11153006 * nh.w + -0.044529624 * ni.w;
	float p = s + t + u + v + w + x + y + z + -0.038306642;
	s = -0.035723098 * a.x + -0.68245345 * b.x + -0.002786794 * c.x + 0.122930825 * d.x + 0.62216485 * e.x + -0.009912186 * f.x + 0.028877307 * g.x + -0.16926426 * h.x + 0.06577198 * i.x;
	t = 0.05365136 * a.y + 0.25071046 * b.y + -0.098311916 * c.y + -0.6723615 * d.y + 0.008480647 * e.y + 0.12375723 * f.y + -0.3281113 * g.y + -0.27574605 * h.y + -0.6595807 * i.y;
	u = -0.13840118 * a.z + -0.44505855 * b.z + 0.030087678 * c.z + 0.2731763 * d.z + 0.5879375 * e.z + 0.41888592 * f.z + -0.26414788 * g.z + -0.5527709 * h.z + 0.8234306 * i.z;
	v = -0.6976394 * a.w + 0.1321562 * b.w + 0.060074754 * c.w + -1.0131954 * d.w + 0.7812007 * e.w + 0.09399807 * f.w + 0.20834799 * g.w + -0.25666532 * h.w + 0.10436948 * i.w;
	w = -0.11991033 * na.x + 0.5989035 * nb.x + -0.008915402 * nc.x + -0.25999224 * nd.x + -0.24793556 * ne.x + 0.08827613 * nf.x + -0.014217819 * ng.x + 0.41833654 * nh.x + 0.011899245 * ni.x;
	x = -0.058299407 * na.y + -0.2646685 * nb.y + 0.0028501004 * nc.y + 0.5013734 * nd.y + 0.18170716 * ne.y + -0.32118702 * nf.y + 0.18985182 * ng.y + -0.6646725 * nh.y + 0.66861767 * ni.y;
	y = 0.09095102 * na.z + 0.4223372 * nb.z + -0.017415347 * nc.z + -0.30837548 * nd.z + -0.57201403 * ne.z + -0.21062538 * nf.z + 0.22605824 * ng.z + 0.11097055 * nh.z + -0.47204867 * ni.z;
	z = 0.77669513 * na.w + -0.19212194 * nb.w + 0.07572081 * nc.w + 0.97353625 * nd.w + -0.5117217 * ne.w + -0.5606905 * nf.w + -0.20132294 * ng.w + 0.22203396 * nh.w + -0.38304013 * ni.w;
	float q = s + t + u + v + w + x + y + z + -0.0053037074;
	s = 0.013148909 * a.x + -0.018101854 * b.x + -0.02898365 * c.x + -0.3221552 * d.x + 0.041935045 * e.x + -0.09236182 * f.x + -0.1982523 * g.x + 0.07636514 * h.x + 0.011796842 * i.x;
	t = -0.011906759 * a.y + 0.0047230097 * b.y + 0.2781825 * c.y + -0.03722119 * d.y + -0.18879256 * e.y + 0.20578861 * f.y + -0.024139037 * g.y + 0.12750165 * h.y + 0.5047841 * i.y;
	u = 0.033963 * a.z + 0.027810164 * b.z + -0.07853949 * c.z + -0.13363425 * d.z + 0.030586613 * e.z + -0.07423147 * f.z + 0.042373702 * g.z + 0.0150760105 * h.z + -0.26815572 * i.z;
	v = -0.25720397 * a.w + -0.38199362 * b.w + -0.3775784 * c.w + -0.14141917 * d.w + 0.42101896 * e.w + 0.3119284 * f.w + 0.37579316 * g.w + -0.14884286 * h.w + -0.20396978 * i.w;
	w = -0.07763323 * na.x + -0.2494878 * nb.x + -0.05896541 * nc.x + 0.06702383 * nd.x + -0.1958453 * ne.x + 0.10558022 * nf.x + 0.23849143 * ng.x + -0.027347537 * nh.x + -0.092861 * ni.x;
	x = 0.059992112 * na.y + 0.0670551 * nb.y + -0.2532366 * nc.y + 0.21315406 * nd.y + 0.5451952 * ne.y + -0.17559859 * nf.y + 0.31270707 * ng.y + 1.1990402 * nh.y + -0.2656133 * ni.y;
	y = -0.06375488 * na.z + 0.03755093 * nb.z + 0.1775088 * nc.z + 0.074394844 * nd.z + -0.21401094 * ne.z + 0.093671985 * nf.z + -0.068302386 * ng.z + 0.057559006 * nh.z + 0.4602701 * ni.z;
	z = 0.07200058 * na.w + 0.2625209 * nb.w + 0.2245587 * nc.w + -0.032449882 * nd.w + -0.9196903 * ne.w + -0.27814385 * nf.w + -0.544985 * ng.w + -0.10481027 * nh.w + 0.4820764 * ni.w;
	float r = s + t + u + v + w + x + y + z + -0.09481775;

	return Compress(float4(o, p, q, r));
}