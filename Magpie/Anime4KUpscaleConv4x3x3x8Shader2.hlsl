// Conv-4x3x3x8 (2)
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

	float s = 0.062563986 * a.x + 0.7022818 * b.x + -0.011810557 * c.x + 0.25277942 * d.x + -0.2097257 * e.x + 0.17233184 * f.x + -0.28609228 * g.x + -0.32957354 * h.x + -0.11091415 * i.x;
	float t = 0.0074290223 * a.y + 0.25707433 * b.y + 0.02356039 * c.y + -0.0033311683 * d.y + 0.78796846 * e.y + -0.8613285 * f.y + 0.020431397 * g.y + -0.014993784 * h.y + -0.5224642 * i.y;
	float u = -0.099318005 * a.z + 0.096692294 * b.z + -0.081225544 * c.z + 0.4837614 * d.z + 0.40215006 * e.z + 0.06631713 * f.z + -0.28298393 * g.z + -0.15690443 * h.z + -0.11722153 * i.z;
	float v = -0.20104708 * a.w + 0.29773432 * b.w + -0.059524678 * c.w + 0.672484 * d.w + 0.58850944 * e.w + 0.19088581 * f.w + 0.085560724 * g.w + -0.3429526 * h.w + -0.01970963 * i.w;
	float w = 0.2530852 * na.x + -0.26206517 * nb.x + -0.0087517025 * nc.x + -0.33815455 * nd.x + -0.00843703 * ne.x + -0.22927909 * nf.x + -0.062886484 * ng.x + 0.17524554 * nh.x + -0.008373106 * ni.x;
	float x = 0.17741594 * na.y + -0.52788115 * nb.y + -0.10984838 * nc.y + -0.13678722 * nd.y + -0.28618953 * ne.y + 0.1595905 * nf.y + -0.04411071 * ng.y + -0.3234863 * nh.y + 0.4967709 * ni.y;
	float y = 0.042347442 * na.z + 0.08541207 * nb.z + -0.15857157 * nc.z + -0.30902776 * nd.z + -0.8957161 * ne.z + -0.29276812 * nf.z + 0.47053015 * ng.z + 0.6092259 * nh.z + 0.31623343 * ni.z;
	float z = 0.17963913 * na.w + -0.30821583 * nb.w + 0.15316938 * nc.w + -0.37125722 * nd.w + -0.5975526 * ne.w + -0.07182377 * nf.w + 0.069451295 * ng.w + 0.61750644 * nh.w + 0.07411387 * ni.w;
	float o = s + t + u + v + w + x + y + z + 0.025282431;
	s = 0.15042752 * a.x + 0.76578605 * b.x + 0.15916896 * c.x + 0.062038895 * d.x + 0.90041196 * e.x + 0.44829968 * f.x + -0.1525204 * g.x + -0.0769386 * h.x + -0.017208606 * i.x;
	t = -0.24956173 * a.y + -0.4890138 * b.y + -0.5667875 * c.y + -0.04361386 * d.y + -1.2683009 * e.y + 0.49874577 * f.y + -0.023511255 * g.y + -0.44963378 * h.y + -0.44784302 * i.y;
	u = -0.4755887 * a.z + 0.5499969 * b.z + -0.40806842 * c.z + 0.18438272 * d.z + -0.24848352 * e.z + -0.6397795 * f.z + -0.26359263 * g.z + 0.48188695 * h.z + 0.4296102 * i.z;
	v = -0.42948166 * a.w + 0.47963342 * b.w + 0.2660744 * c.w + 0.009006623 * d.w + -0.20249301 * e.w + 0.3191499 * f.w + -0.009933394 * g.w + 0.022085298 * h.w + -0.05937115 * i.w;
	w = 0.39071006 * na.x + 0.96707124 * nb.x + 0.5870382 * nc.x + -0.0009634084 * nd.x + -0.60501117 * ne.x + -0.26205206 * nf.x + 0.0022803913 * ng.x + 0.19914602 * nh.x + -0.0075327456 * ni.x;
	x = 0.6501524 * na.y + -0.6191325 * nb.y + 0.033584982 * nc.y + -0.23792362 * nd.y + 0.28443542 * ne.y + 0.7995467 * nf.y + 0.61443925 * ng.y + -0.2151685 * nh.y + -0.64213204 * ni.y;
	y = -0.028933166 * na.z + -0.8038524 * nb.z + -0.89384586 * nc.z + -0.5202012 * nd.z + 0.2658711 * ne.z + -0.9662124 * nf.z + 0.16669375 * ng.z + 0.00071032986 * nh.z + -0.15632267 * ni.z;
	z = 0.04982121 * na.w + 0.3209018 * nb.w + -0.18828197 * nc.w + 0.09291354 * nd.w + -0.17046586 * ne.w + -0.34567246 * nf.w + -0.30839518 * ng.w + 0.10585062 * nh.w + 0.21802926 * ni.w;
	float p = s + t + u + v + w + x + y + z + -0.038783036;
	s = -0.0086537115 * a.x + 0.29274273 * b.x + -0.14299169 * c.x + 0.24355909 * d.x + 0.44158313 * e.x + 0.3856316 * f.x + 0.1826302 * g.x + 0.0468175 * h.x + 0.08368182 * i.x;
	t = -0.0030031276 * a.y + -0.25766936 * b.y + -0.16684678 * c.y + -0.07155021 * d.y + 0.49751604 * e.y + 0.51993954 * f.y + -0.055723842 * g.y + -0.20152062 * h.y + -0.3310546 * i.y;
	u = -0.19360077 * a.z + 0.29092705 * b.z + -0.14313088 * c.z + -0.12219053 * d.z + 0.3336699 * e.z + 0.19800198 * f.z + 0.12873465 * g.z + 0.16162138 * h.z + 0.05346552 * i.z;
	v = -0.12214463 * a.w + -0.32187235 * b.w + -0.4942458 * c.w + 0.047901243 * d.w + 0.1315279 * e.w + 0.25730842 * f.w + -0.03230636 * g.w + -0.35371637 * h.w + -0.16514161 * i.w;
	w = 0.06874291 * na.x + -0.19512849 * nb.x + 0.4657543 * nc.x + -0.031914163 * nd.x + 0.37405568 * ne.x + 0.15239602 * nf.x + -0.023567 * ng.x + 0.31183028 * nh.x + 0.0394527 * ni.x;
	x = -0.07513823 * na.y + 0.041872643 * nb.y + 0.35610527 * nc.y + -0.1445567 * nd.y + -1.024163 * ne.y + -0.6282327 * nf.y + 0.06843732 * ng.y + 0.009273292 * nh.y + -0.23500894 * ni.y;
	y = 0.10864135 * na.z + -0.25950822 * nb.z + -0.27286842 * nc.z + -0.0922535 * nd.z + -0.49195388 * ne.z + -0.9883521 * nf.z + -0.16378482 * ng.z + -0.44275576 * nh.z + -0.19259977 * ni.z;
	z = -0.07329517 * na.w + 0.73912215 * nb.w + -0.27922824 * nc.w + -0.19892885 * nd.w + -0.029165866 * ne.w + -0.64475375 * nf.w + -0.1735304 * ng.w + 0.030360926 * nh.w + 0.023611842 * ni.w;
	float q = s + t + u + v + w + x + y + z + 0.0059805913;
	s = 0.0520063 * a.x + 0.32099065 * b.x + 0.10096528 * c.x + -0.3286558 * d.x + 0.21782263 * e.x + -0.16726571 * f.x + -0.0061505553 * g.x + -0.006116407 * h.x + 0.04923024 * i.x;
	t = -0.0034328692 * a.y + -0.093817174 * b.y + -0.16234896 * c.y + 0.070740886 * d.y + 0.09283234 * e.y + -0.5086407 * f.y + 0.14033465 * g.y + 0.2656622 * h.y + -0.069810264 * i.y;
	u = 0.0036944423 * a.z + -0.12574191 * b.z + -0.05118089 * c.z + -0.57802665 * d.z + 0.7782018 * e.z + -0.50453955 * f.z + 0.020464642 * g.z + 0.036232006 * h.z + 0.07828021 * i.z;
	v = 0.14491023 * a.w + -0.08246158 * b.w + 0.0048284433 * c.w + -0.41679582 * d.w + -0.37185597 * e.w + -0.5086088 * f.w + -0.101141416 * g.w + 0.021782609 * h.w + 0.024443237 * i.w;
	w = -0.09724159 * na.x + -0.13913961 * nb.x + 0.13188085 * nc.x + 0.4496926 * nd.x + -0.2343041 * ne.x + 0.30554664 * nf.x + 0.10852492 * ng.x + 0.09672956 * nh.x + 0.06470584 * ni.x;
	x = -0.22092621 * na.y + -0.17034335 * nb.y + -0.46865875 * nc.y + -0.16638382 * nd.y + -0.36817726 * ne.y + 2.8126082 * nf.y + 0.20136675 * ng.y + -0.028155493 * nh.y + -0.6738389 * ni.y;
	y = 0.08178478 * na.z + -0.13104321 * nb.z + -0.0031215427 * nc.z + 0.25492746 * nd.z + -0.6011733 * ne.z + 1.2705562 * nf.z + -0.053312294 * ng.z + 0.04038377 * nh.z + -0.21168794 * ni.z;
	z = -0.26104185 * na.w + 0.24431077 * nb.w + 0.44925603 * nc.w + 0.23646158 * nd.w + 0.45555523 * ne.w + 0.9546111 * nf.w + -0.24485165 * ng.w + -0.13658847 * nh.w + 0.033205047 * ni.w;
	float r = s + t + u + v + w + x + y + z + -0.039946888;

	return Compress(float4(o, p, q, r));
}