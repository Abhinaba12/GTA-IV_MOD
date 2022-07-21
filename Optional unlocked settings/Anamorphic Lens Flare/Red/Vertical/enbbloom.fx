//++++++++++++++++++++++++++++++
// CryENB V3 ENBBLOOM.FX FILE
// Made by icelaglace - tweaked for CryENB V3
// Copyright: Boris Vorontsov, IceLaGlace, gp65cj04, Dpeasant3 & Fabriciuz
// Do NOT upload this FX unless you have permission from Fabriciuz or IceLaGlace
//++++++++++++++++++++++++++++++

float4	BloomParameters;
float4	TempParameters;
float4	ScreenSize;

float BloomRadius3 = 32;
float BloomRadius4 = 64;
float MixFactor = 0.3;
float Smoothness = 6;
float bloomthres = 1;
float4 LenzParameters = 0.05;

float3 violetpremierepasse = float3(0.81, 0.81, 0.98);
float3 violetsoleil = float3(1.0, 1.0, 1.0);
float3 couleurglobale = float3(0.81, 0.81, 0.98);

//anamorphic lens
float fLuminance =0.80;
float fBlur = 20;
float fIntensity = 0.3;

//quad
struct VS_OUTPUT_POST
{
	float4 vpos  : POSITION;
	float2 txcoord0 : TEXCOORD0;
};
struct VS_INPUT_POST
{
	float3 pos  : POSITION;
	float2 txcoord0 : TEXCOORD0;
};



texture2D texBloom1;
texture2D texBloom2;
texture2D texBloom3;
texture2D texBloom4;
texture2D texBloom5;

sampler2D SamplerBloom1 = sampler_state
{
    Texture   = <texBloom1>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom2 = sampler_state
{
    Texture   = <texBloom2>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom3 = sampler_state
{
    Texture   = <texBloom3>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom4 = sampler_state
{
    Texture   = <texBloom4>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D SamplerBloom5 = sampler_state
{
    Texture   = <texBloom5>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;//NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};



//++++++++++++++++++++++
//
//++++++++++++++++++++++
VS_OUTPUT_POST VS_Bloom(VS_INPUT_POST IN)
{
	VS_OUTPUT_POST OUT;

	OUT.vpos=float4(IN.pos.x,IN.pos.y,IN.pos.z,1.0);

	OUT.txcoord0.xy=IN.txcoord0.xy+TempParameters.xy;//1.0/(bloomtexsize*2.0)

	return OUT;
}



float4 PS_BloomPrePass(VS_OUTPUT_POST In) : COLOR
{
	float4 bloomuv;

	float4 bloom=tex2D(SamplerBloom1, In.txcoord0);
	const float2 offset[8]=
	{
/*		float2(0.707, 0.707),
		float2(0.707, -0.707),
		float2(-0.707, 0.707),
		float2(-0.707, -0.707),*/
		float2(1.0, 1.0),
		float2(0.0, -1.0),
		float2(-1.0, 1.0),
		float2(-1.0, -1.0),
		float2(0.0, 1.0),
		float2(0.0, -1.0),
		float2(1.0, 0.0),
		float2(-1.0, 0.0)
	};
	float2 screenfact=1.0;
	screenfact.y*=ScreenSize.z;
	screenfact.xy*=TempParameters.z*1.5;
	float4 srcbloom=bloom;
	for (int i=0; i<8; i++)
	{
		bloomuv.xy=offset[i];
		bloomuv.xy=(bloomuv.xy*screenfact.xy)+In.txcoord0.xy;//-(1.0/256.0);//-(1.0/512.0);
		float4 tempbloom=tex2D(SamplerBloom1, bloomuv.xy) - bloomthres;
		tempbloom = max(tempbloom,0.0);
		bloom.xyz+=tempbloom.xyz;
	}
	bloom*=0.175;//0.125;

	bloom.w=1.0;
	return bloom;
}






float4 PS_BloomTexture1(VS_OUTPUT_POST In) : COLOR
{
	float4 bloomuv;
	float4 bloomuv2;

	float4 bloom=tex2D(SamplerBloom1, In.txcoord0);
const float2 offset[16]=
{
float2(-0.94201624, -0.39906216),
float2( 0.94558609, -0.76890725),
float2(-0.09418410, -0.92938870),
float2( 0.34495938,  0.29387760),
float2(-0.91588581,  0.45771432),
float2(-0.81544232, -0.87912464),
float2(-0.38277543,  0.27676845),
float2( 0.97484398,  0.75648379),
float2( 0.44323325, -0.97511554),
float2( 0.53742981, -0.47373420),
float2(-0.26496911, -0.41893023),
float2( 0.79197514,  0.19090188),
float2(-0.24188840,  0.99706507),
float2(-0.81409955,  0.91437590),
float2( 0.19984126,  0.78641367),
float2( 0.14383161, -0.14100790)
};
	float2 screenfact=1.0;
	screenfact.y*=ScreenSize.z;
	screenfact.xy/=ScreenSize.x;
	float4 srcbloom=bloom;
	float step=(TempParameters.w-0.5);//*1.5;
	screenfact.xy*=step;

	float4 bloomadd=bloom;
	for (int i=0; i<16; i++)
	{
		bloomuv.xy=offset[i]*BloomParameters.x;
		bloomuv.xy=(bloomuv.xy*screenfact.xy)+In.txcoord0.xy;//-(1.0/256.0);//-(1.0/512.0);

		bloomuv2.xy=offset[i]*BloomRadius3;
		bloomuv2.xy=(bloomuv2.xy*screenfact.xy)+In.txcoord0.xy;

		//v2
		float4 tempbloom1=tex2D(SamplerBloom1, bloomuv.xy);
		float4 tempbloom2=tex2D(SamplerBloom1, bloomuv2.xy);

		float4 tempbloom = lerp(tempbloom1, tempbloom2, MixFactor);
		bloomadd+=tempbloom;
		
		bloom.xyz = max(bloom.xyz, tempbloom.xyz*0.99);




	}
	//v1
	bloomadd*=0.111111;
	//v0
	bloom.xyz=lerp(bloomadd.xyz, bloom.xyz, BloomParameters.w);


	//float3 violet=float3(0.78, 0.5, 1.0);
	//float3 violet=float3(0.6, 0.4, 1.0);//v2
	float3 violet=violetpremierepasse;//v3

	
	//float gray=0.104*dot(srcbloom.xyz, 0.333);//max(srcbloom.x, max(srcbloom.y, srcbloom.z));
	
	float ttt=dot(bloom.xyz, 0.333)-dot(srcbloom.xyz, 0.333);
	ttt=max(ttt, 0.0);
	float gray=BloomParameters.z*ttt;//max(srcbloom.x, max(srcbloom.y, srcbloom.z));
	float mixfact=(gray/(1.0+gray));
	mixfact*=1.0-saturate((TempParameters.w-1.0)*0.3);
	violet.xy+=saturate((TempParameters.w-1.0)*0.3);
	violet.xy=saturate(violet.xy);
	bloom.xyz*=lerp(1.0, violet.xyz, mixfact);

	bloom.w=1.0;
	return bloom;
}



float4 PS_BloomTexture2(VS_OUTPUT_POST In) : COLOR
{
	float4 bloomuv;
	float4 bloomuv2;

	float4 bloom=tex2D(SamplerBloom1, In.txcoord0);
const float2 offset[16]=
{
float2(-0.94201624, -0.39906216),
float2( 0.94558609, -0.76890725),
float2(-0.09418410, -0.92938870),
float2( 0.34495938,  0.29387760),
float2(-0.91588581,  0.45771432),
float2(-0.81544232, -0.87912464),
float2(-0.38277543,  0.27676845),
float2( 0.97484398,  0.75648379),
float2( 0.44323325, -0.97511554),
float2( 0.53742981, -0.47373420),
float2(-0.26496911, -0.41893023),
float2( 0.79197514,  0.19090188),
float2(-0.24188840,  0.99706507),
float2(-0.81409955,  0.91437590),
float2( 0.19984126,  0.78641367),
float2( 0.14383161, -0.14100790)
};
	float2 screenfact=1.0;
	screenfact.y*=ScreenSize.z;
	screenfact.xy/=ScreenSize.x;
	float4 srcbloom=bloom;

	float step=(TempParameters.w-0.5)*1.2;//v3
	screenfact.xy*=step;
	float4 rotvec=0.0;
	sincos(0.19635, rotvec.x, rotvec.y);
	for (int i=0; i<16; i++)
	{

		bloomuv.xy=offset[i];
		bloomuv.xy=reflect(bloomuv.xy, rotvec.xy);
		bloomuv.xy*=BloomParameters.y;
		
		bloomuv.xy=(bloomuv.xy*screenfact.xy)+In.txcoord0.xy;//-(1.0/256.0);//-(1.0/512.0);

		float4 tempbloom1 = tex2D(SamplerBloom1, bloomuv.xy);



		bloomuv2.xy=offset[i];
		bloomuv2.xy=reflect(bloomuv2.xy, rotvec.xy);
		bloomuv2.xy*=BloomRadius4;
		bloomuv2.xy=(bloomuv2.xy*screenfact.xy)+In.txcoord0.xy;//-(1.0/256.0);//-(1.0/512.0);
		float4 tempbloom2 = tex2D(SamplerBloom1, bloomuv2.xy);

		float4 tempbloom = lerp(tempbloom1, tempbloom2, MixFactor);

		bloom+=tempbloom;

	}
	float3 violet=couleurglobale;
	float ttt=dot(bloom.xyz, 0.333)-dot(srcbloom.xyz, 0.333);
	ttt=max(ttt, 0.0);
	float gray=BloomParameters.z*ttt;//max(srcbloom.x, max(srcbloom.y, srcbloom.z));
	float mixfact=(gray/(1.0+gray));
	mixfact*=1.0-saturate((TempParameters.w-1.0)*0.3);
	violet.xy+=saturate((TempParameters.w-1.0)*0.3);
	violet.xy=saturate(violet.xy);
	bloom.xyz*=lerp(1.0, violet.xyz, mixfact);
	bloom*=0.05;//0.125;

	bloom.w=1.0;
	return bloom;
}

float3 BrightPass(float2 tex)
{
	float3 c = tex2D(SamplerBloom5, tex).rgb;
	float3 bC = max(c - float3(fLuminance, fLuminance, fLuminance), 0.0);
	float bright = dot(bC, 20);
	bright = smoothstep(0.0f, 0.5f, bright);
	return lerp(0.0, c, bright);
}
float3 AnamorphicSample(int axis, float2 tex, float blur)
{
	float2 oritex=tex;
	tex = 2.0 * tex - 1.0;
	if (!axis) tex.x /= -blur;
	else tex.y /= -blur;
	tex = 0.5 * tex + 0.5;
	return BrightPass(tex);
}

float4 PS_ProcessPass_Anamorphic(VS_OUTPUT_POST IN, float2 vPos : VPOS) : COLOR
{
	float4 res;
	float2 coord = IN.txcoord0.xy;
	float3 anamFlare = AnamorphicSample(0, coord.xy, fBlur) * float3(0.7, 0.1, 0.1);
	res.rgb = anamFlare * fIntensity;
	res.a = 1.0;
	return res;
}


float4 PS_BloomPostPass(VS_OUTPUT_POST In) : COLOR
{
	float4 bloom;
	float4 temp;
	//v1
	bloom =tex2D(SamplerBloom1, In.txcoord0);
	bloom+=tex2D(SamplerBloom2, In.txcoord0);
	bloom+=tex2D(SamplerBloom3, In.txcoord0);
	bloom+=tex2D(SamplerBloom4, In.txcoord0);
	bloom+=tex2D(SamplerBloom5, In.txcoord0);
	bloom*=0.2;
	temp = bloom;

	//v2
	float4 bloom1=tex2D(SamplerBloom1, In.txcoord0);
	float4 bloom2=tex2D(SamplerBloom2, In.txcoord0);
	float4 bloom3=tex2D(SamplerBloom3, In.txcoord0);
	float4 bloom4=tex2D(SamplerBloom4, In.txcoord0);
	float4 bloom5=tex2D(SamplerBloom5, In.txcoord0);
	bloom=max(bloom1, bloom2);
	bloom=max(bloom, bloom3);
	bloom=max(bloom, bloom4);
	bloom=max(bloom, bloom5);

	bloom = lerp(temp, bloom, 0.3);
	
	float3 lenz=0;
	float2 lenzuv=0.0;

	const float3 offset[18]=
	{
		float3(0.9, 0.01, 4),
		float3(0.7, 0.25, 25),
		float3(0.3, 0.25, 15),

		float3(1, 1.0, 5),

		float3(-0.15, 20, 1),
		float3(-0.3, 20, 1),

		float3(0.5, 0.1, 1),
		float3(0.01, 10, 1),
		float3(20, 0.25, 1),
		float3(1000, 5, 100),

		float3(0.15, 10, 1),
		float3(0.2, 10, 1),
		float3(0.4, 1, 10),

		float3(0.5, -0.5, 2),

		float3(2, 2, -5),

		float3(-5, 0.2, 0.2),

		float3(0.15, 0.5, 20),
		float3(0.4, 1, 10)
	};

	const float3 factors[18]=
	{
		float3(0.5, 0.5, 0),
		float3(0, 0.5, 0),
		float3(0, 0, 0.5),

		float3(0.2, 0.25, 0),

		float3(0.15, 0, 0.0),
		float3(0, 0.0, 0.15),

		float3(0.2, 0.2, 0.05),
		float3(0.25, 0.25, 0.25),
		float3(1, 1, 1),
		float3(0, 0.25, 1),

		float3(0, 1, 0.0),
		float3(0, 0.0, 1),
		float3(10, 0, 0),

		float3(0, 0,0.0),

		float3(0, 0, 1),

		float3(2, 2, 2),
		float3(1, 1, 0.25),
		float3(0.0, 0, 0.2)

	};

//lenzuv.xy=0.5-lenzuv.xy;
//distfact=0.5-lenzuv.xy-0.5;

	if (LenzParameters.x>0.00001)
	{
		for (int i=0; i<18; i++)
		{
			float2 distfact=(In.txcoord0.xy-0.5);
			lenzuv.xy=offset[i].x*distfact;
			lenzuv.xy*=pow(2.0*length(float2(distfact.x*ScreenSize.z,distfact.y)), offset[i].y);
			lenzuv.xy*=offset[i].z;
			//lenzuv.xy=0.5-lenzuv.xy;//v1
			lenzuv.xy=In.txcoord0.xy-lenzuv.xy;//v2
			float3 templenz=tex2D(SamplerBloom2, lenzuv.xy);
			templenz=templenz*factors[i];
			distfact=(lenzuv.xy-0.5);
			distfact*=2.0;
			templenz*=saturate(1.0-dot(distfact,distfact));//limit by uv 0..1
	//		templenz=factors[i] * (1.0-dot(distfact,distfact));
			float maxlenz=max(templenz.x, max(templenz.y, templenz.z));
/*			float3 tempnor=(templenz.xyz/maxlenz);
			tempnor=pow(tempnor, tempF1.z);
			templenz.xyz=tempnor.xyz*maxlenz;
*/
			float tempnor=(maxlenz/(1.0+maxlenz));
			tempnor=pow(tempnor, LenzParameters.y);
			templenz.xyz*=tempnor;

	//		templenz*=maxlenz*maxlenz;
			lenz+=templenz;
	//		lenz.xyz=max(lenz.xyz, templenz.xyz*0.99);
		}
		lenz.xyz*=0.25*LenzParameters.x;

		bloom.xyz+=lenz.xyz;
//		bloom.w=dot(lenz.xyz, 0.333);
		bloom.w=max(lenz.xyz, max(lenz.y, lenz.z));
	}

	//bloom =tex2D(SamplerBloom1, In.txcoord0);

	bloom.w=1.0;
	return bloom;
}



technique BloomPrePass
{
    pass p0
    {
	VertexShader = compile vs_3_0 VS_Bloom();
	PixelShader  = compile ps_3_0 PS_BloomPrePass();

	COLORWRITEENABLE=ALPHA|RED|GREEN|BLUE;
	CullMode=NONE;
	AlphaBlendEnable=TRUE;
	AlphaTestEnable=FALSE;
	SEPARATEALPHABLENDENABLE=FALSE;
	FogEnable=FALSE;
	SRGBWRITEENABLE=FALSE;
	}
}

technique BloomTexture1
{
    pass p0
    {
	VertexShader = compile vs_3_0 VS_Bloom();
	PixelShader  = compile ps_3_0 PS_BloomTexture1();

	COLORWRITEENABLE=ALPHA|RED|GREEN|BLUE;
	CullMode=NONE;
	AlphaBlendEnable=TRUE;
	AlphaTestEnable=FALSE;
	SEPARATEALPHABLENDENABLE=FALSE;
	FogEnable=FALSE;
	SRGBWRITEENABLE=FALSE;
	}
}


technique BloomTexture2
{
    pass p0
    {
	VertexShader = compile vs_3_0 VS_Bloom();
	PixelShader  = compile ps_3_0 PS_BloomTexture2();

	COLORWRITEENABLE=ALPHA|RED|GREEN|BLUE;
	CullMode=NONE;
	AlphaBlendEnable=TRUE;
	AlphaTestEnable=FALSE;
	SEPARATEALPHABLENDENABLE=FALSE;
	FogEnable=FALSE;
	SRGBWRITEENABLE=FALSE;
	}
}

technique BloomPostPass
{
    pass p0
    {
	VertexShader = compile vs_3_0 VS_Bloom();
	PixelShader  = compile ps_3_0 PS_BloomPostPass();

	COLORWRITEENABLE=ALPHA|RED|GREEN|BLUE;
	CullMode=NONE;
	AlphaBlendEnable=TRUE;
	AlphaTestEnable=FALSE;
	SEPARATEALPHABLENDENABLE=FALSE;
	FogEnable=FALSE;
	SRGBWRITEENABLE=FALSE;
	}
	pass p1
	{
			AlphaBlendEnable = true;
			SrcBlend = One;
			DestBlend = One;

		VertexShader = compile vs_3_0 VS_Bloom();
		PixelShader  = compile ps_3_0 PS_ProcessPass_Anamorphic();

	}	
}
