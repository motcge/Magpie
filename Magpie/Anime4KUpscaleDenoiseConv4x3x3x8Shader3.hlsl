// Conv-4x3x3x8 (3)
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

	float s = -0.11332997 * a.x + -0.030096909 * b.x + 0.08148866 * c.x + -0.010003128 * d.x + -0.3719025 * e.x + 0.42076835 * f.x + -0.054107253 * g.x + 0.38734847 * h.x + -0.11231825 * i.x;
	float t = 0.025680946 * a.y + -0.024454257 * b.y + 0.014810714 * c.y + 0.036770396 * d.y + -0.0070939185 * e.y + -0.0018907397 * f.y + -0.0069138035 * g.y + 0.042922944 * h.y + -0.026554981 * i.y;
	float u = 0.17945814 * a.z + 0.013098164 * b.z + 0.054402053 * c.z + -0.36088273 * d.z + 0.2196976 * e.z + -0.14696789 * f.z + -0.1504518 * g.z + -0.07471018 * h.z + 0.09389284 * i.z;
	float v = -0.03949051 * a.w + -0.3112672 * b.w + 0.03312816 * c.w + -0.15758176 * d.w + 0.012970425 * e.w + -0.032173485 * f.w + 0.0059135878 * g.w + -0.018274516 * h.w + 0.006665848 * i.w;
	float w = 0.060758714 * na.x + 0.119630076 * nb.x + -0.055826433 * nc.x + 0.024306111 * nd.x + -0.17980659 * ne.x + 0.06985393 * nf.x + 0.12661703 * ng.x + -0.19770502 * nh.x + 0.13595854 * ni.x;
	float x = 0.029055506 * na.y + -0.12881005 * nb.y + 0.036180172 * nc.y + 0.08952762 * nd.y + 0.043251947 * ne.y + 0.0309519 * nf.y + -0.027306352 * ng.y + 0.090683386 * nh.y + 0.02579988 * ni.y;
	float y = -0.085502416 * na.z + -0.112721406 * nb.z + 0.097885445 * nc.z + 0.37216458 * nd.z + -0.96167123 * ne.z + 0.18936911 * nf.z + 0.2518813 * ng.z + -0.34743145 * nh.z + -0.042477675 * ni.z;
	float z = -0.1021104 * na.w + -0.0024531253 * nb.w + -0.05186199 * nc.w + -0.10294499 * nd.w + -0.40830356 * ne.w + 0.08315621 * nf.w + -0.16157012 * ng.w + -0.21950066 * nh.w + -0.1614427 * ni.w;
	float o = s + t + u + v + w + x + y + z + -0.002265523;
	s = 0.021600334 * a.x + 0.10832676 * b.x + -0.024148826 * c.x + 0.13570073 * d.x + -0.21699049 * e.x + -0.06750743 * f.x + -0.029798364 * g.x + -0.09693352 * h.x + 0.0147330705 * i.x;
	t = -0.013208378 * a.y + -0.048681907 * b.y + 0.008304722 * c.y + 0.02060466 * d.y + 0.060887072 * e.y + -0.029299827 * f.y + 0.026754655 * g.y + -0.021247081 * h.y + -0.0038295237 * i.y;
	u = -0.03708045 * a.z + -0.21871905 * b.z + -0.021733213 * c.z + -0.2442365 * d.z + -0.13438821 * e.z + 0.010540137 * f.z + 0.0020230296 * g.z + 0.03257546 * h.z + -0.021659117 * i.z;
	v = 0.072284244 * a.w + -0.0068167807 * b.w + -0.039564237 * c.w + 0.08290029 * d.w + -0.023164112 * e.w + 0.05348939 * f.w + 0.0016720649 * g.w + 0.012663401 * h.w + -0.02184872 * i.w;
	w = -0.07998153 * na.x + -0.18709537 * nb.x + -0.005292238 * nc.x + -0.1348702 * nd.x + 0.49248907 * ne.x + -0.05204193 * nf.x + -0.06340117 * ng.x + 0.007885183 * nh.x + -0.029052222 * ni.x;
	x = -0.05064604 * na.y + -0.035637096 * nb.y + 0.013302106 * nc.y + 0.01650534 * nd.y + -0.1477934 * ne.y + 0.043521415 * nf.y + -0.030470217 * ng.y + -0.031236814 * nh.y + -0.0046578054 * ni.y;
	y = 0.07605579 * na.z + 0.15499325 * nb.z + 0.029893741 * nc.z + -0.03078108 * nd.z + 0.19679599 * ne.z + 0.0116642965 * nf.z + 0.024839424 * ng.z + 0.055510025 * nh.z + 0.0051100547 * ni.z;
	z = 0.16119163 * na.w + 0.114809826 * nb.w + 0.07049681 * nc.w + -0.133776 * nd.w + 0.32676715 * ne.w + -0.048946135 * nf.w + 0.030700788 * ng.w + 0.009784126 * nh.w + 0.08081439 * ni.w;
	float p = s + t + u + v + w + x + y + z + -0.008238084;
	s = -0.11814972 * a.x + -0.22662362 * b.x + -0.32331735 * c.x + -0.32201746 * d.x + 0.36564782 * e.x + 0.4426983 * f.x + 0.07923639 * g.x + -0.021336399 * h.x + 0.20492047 * i.x;
	t = 0.023790328 * a.y + 0.21819559 * b.y + -0.0030968755 * c.y + 0.008919413 * d.y + -0.05898664 * e.y + -0.01876806 * f.y + -0.023788428 * g.y + 0.3268361 * h.y + 0.20320326 * i.y;
	u = 0.3627926 * a.z + 0.24333648 * b.z + 0.36114886 * c.z + -0.22440743 * d.z + -0.33366778 * e.z + -0.2563366 * f.z + 0.17747861 * g.z + -0.036596447 * h.z + -0.14797947 * i.z;
	v = 0.044698503 * a.w + -0.08930945 * b.w + 0.003949861 * c.w + 0.06074132 * d.w + 0.033413503 * e.w + 0.031703018 * f.w + -0.12555575 * g.w + -0.17760313 * h.w + -0.023225365 * i.w;
	w = 0.2835165 * na.x + 0.5397253 * nb.x + 0.43220985 * nc.x + 0.21800578 * nd.x + -0.49878022 * ne.x + -0.14049673 * nf.x + 0.0635294 * ng.x + -0.061934207 * nh.x + -0.09326524 * ni.x;
	x = 0.12654181 * na.y + 0.17621928 * nb.y + -0.008198183 * nc.y + 0.104607224 * nd.y + -0.33173743 * ne.y + -0.09671909 * nf.y + 0.048836842 * ng.y + -0.33907175 * nh.y + -0.106737114 * ni.y;
	y = -0.5081512 * na.z + -0.380074 * nb.z + -0.37692118 * nc.z + -0.24946907 * nd.z + 0.040042657 * ne.z + 0.14976257 * nf.z + -0.1887001 * ng.z + -0.08455224 * nh.z + -0.057611104 * ni.z;
	z = -0.64085907 * na.w + -0.8459774 * nb.w + -0.2510755 * nc.w + 0.42802453 * nd.w + 0.91313195 * ne.w + 0.13899519 * nf.w + 0.06350987 * ng.w + -0.18764617 * nh.w + 0.02081424 * ni.w;
	float q = s + t + u + v + w + x + y + z + 0.027070472;
	s = 0.085782826 * a.x + -0.1726551 * b.x + 0.043658435 * c.x + -0.19243051 * d.x + -0.15005304 * e.x + 0.4900343 * f.x + -0.10336709 * g.x + 0.18312618 * h.x + -0.27707884 * i.x;
	t = -0.004284496 * a.y + 0.037800293 * b.y + -0.064419575 * c.y + -0.09865947 * d.y + 0.080926254 * e.y + -0.08812109 * f.y + -0.03724518 * g.y + -0.3518894 * h.y + 0.006982196 * i.y;
	u = 0.27069104 * a.z + 0.50021005 * b.z + 0.36097506 * c.z + 0.6951922 * d.z + -0.037900347 * e.z + 0.2528657 * f.z + 0.05860036 * g.z + 0.27981114 * h.z + 0.3613525 * i.z;
	v = -0.05924939 * a.w + -0.22080211 * b.w + 0.09578901 * c.w + -0.10867603 * d.w + -0.5372019 * e.w + -0.35316542 * f.w + 0.10804751 * g.w + 0.15515941 * h.w + -0.0054505514 * i.w;
	w = 0.010304433 * na.x + 0.1640876 * nb.x + -0.17266113 * nc.x + 0.21446994 * nd.x + 0.23574792 * ne.x + 0.5137865 * nf.x + 0.21062104 * ng.x + 0.17340744 * nh.x + 0.15868759 * ni.x;
	x = 0.06865077 * na.y + 0.04066122 * nb.y + 0.07871106 * nc.y + 0.04974146 * nd.y + 0.24277933 * ne.y + -0.13853991 * nf.y + -0.0046235975 * ng.y + 0.3110683 * nh.y + -0.055814896 * ni.y;
	y = 0.18448246 * na.z + 0.23644273 * nb.z + 0.1740395 * nc.z + 0.056280363 * nd.z + 0.321761 * ne.z + 0.3599845 * nf.z + 0.049847838 * ng.z + 0.12761155 * nh.z + 0.25527006 * ni.z;
	z = -0.40113544 * na.w + -0.5755716 * nb.w + -0.45964563 * nc.w + -0.47008777 * nd.w + -0.5389698 * ne.w + 0.04141921 * nf.w + -0.35219887 * ng.w + -0.5849454 * nh.w + -0.5195555 * ni.w;
	float r = s + t + u + v + w + x + y + z + 0.04324416;

	return Compress(float4(o, p, q, r));
}