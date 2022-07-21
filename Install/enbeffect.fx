//++++++++++++++++++++++++++++++
// CryENB V3 ENBEFFECT.FX FILE
// Original shader from iCEnhancer by IceLaGlace
// Edited by Buzzbass & Fabriciuz
// Fixed by IceLaGlace, cleaned, made faster, fixed issues
//
// Copyright: Boris Vorontsov, IceLaGlace, gp65cj04, Buzzbass & Fabriciuz
// Do NOT upload this FX unless you have permission from Fabriciuz or IceLaGlace
//++++++++++++++++++++++++++++++

// IMAGE SETTINGS
float Bloom1 = 1;
float Bloom2 = 0;
float Brightness = 1;
float Saturation = 1.17;
float Contrast = 0.35;
float LensDirt = 0.3;
float Vignette = 0.15;

//++++++++++++++++++++++++++++++

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

float4	_c44 : register(c44);
float4	_c66 : register(c66);
float4	_c72 : register(c72);
float4	_c73 : register(c73);
float4	_c74 : register(c74);
float4	_c75 : register(c75);
float4	_c76 : register(c76);
float4	_c77 : register(c77);
float4	_c78 : register(c78);
float4	_c79 : register(c79);
float4	_c80 : register(c80);
float4	_c81 : register(c81);
float4	_c82 : register(c82);
float4	_c83 : register(c83);
float4	_c84 : register(c84);
float4	_c85 : register(c85);

texture2D texs0 : register(s0);
texture2D texs1 : register(s1);
texture2D texs2 : register(s2);
texture2D texs3 : register(s3);
texture2D texs4 : register(s4);
texture2D texs5 : register(s5);
texture2D texs6 : register(s6);
texture2D texs7 : register(s7);
texture2D texs13 : register(s13);
texture2D texs15 : register(s15);
sampler2D s2=sampler_state { Texture=<texs2>; };
sampler2D s4=sampler_state { Texture=<texs4>; };
sampler2D s5=sampler_state { Texture=<texs5>; };
sampler2D s6=sampler_state { Texture=<texs6>; };
sampler2D s7=sampler_state { Texture=<texs7>; };
sampler2D s15=sampler_state { Texture=<texs15>; };
sampler2D s0 = sampler_state
{
    Texture   = <texs0>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D s1 = sampler_state
{
    Texture   = <texs1>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D s3 = sampler_state
{
    Texture   = <texs3>;
	MinFilter = LINEAR;//
	MagFilter = LINEAR;//
	MipFilter = NONE;//NONE;//LINEAR;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

sampler2D s13 = sampler_state
{
	Texture   = <texs13>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = NONE;
	AddressU  = Clamp;
	AddressV  = Clamp;
	SRGBTexture=FALSE;
	MaxMipLevel=0;
	MipMapLodBias=0;
};

float4 PS_C215BE6E(VS_OUTPUT_POST IN) : COLOR
{
	float4 _oC0=0.0; //output
	float4 _c0=float4(0, 0.212500006, 0.715399981, 0.0720999986);
	float4 _c1=float4(0.25, 1, 256, 0);
	float4 _c2=float4(0, 2, 4, 8);
	float4 _c3=float4(58.1640015, 47.1300011, 0, 0);
	float4 _c4=float4(-6, -1.5, 1.5, 0.5);
	float4 _c5=float4(2, -1, 0.125, 0);
	float4 _c6=float4(256, 2, 4, 8);
	float4 _c7=float4(1.0, 0.1, 0.8, 1.0);
	float4 _c8=float4(0.0, 0.1, 0.8, 0.333);
	float4 _c9=float4(0.06, 0.1, 0.8, 0.1);
	float4 _c10=float4(0.01, 1.4, 0.0, 0.32);
	float4 _c11=float4(0.333333, 1.0, 0.0, 0.0);
	float4 _c12=float4(0.27, 0.67, 0.06, 0.0);
	float4 _c13=float4(0.0, 0.0, 0.0, 0.00001);
	float4 _c150=float4(0.55, 0.9, 0.85, 0.9);
	float4 _c195=float4(0.0, 0.0, 0.0, 0.07);//0.7
	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float4 r10;
	float4 r11;

	float4 _v0=0.0;
	_v0.xy=IN.txcoord0.xy;
	
	r1=tex2D(s2, _v0.xy); //HDRSampler
	r0=tex2D(s1, _v0.xy); //GBufferTextureSampler3
	r0.y=-_c77.x + _c77.y; //-dofProj.x + dofProj.y
	r0.y=1.0/r0.y;
	r0.z=r0.y * _c77.y; //dofProj.y
	r0.z=r0.z * -_c77.x; //dofProj.x
	r0.x=_c77.y * -r0.y + r0.x;
	r0.x=1.0/r0.x;
	r0.y=r0.z * r0.x;
	r0.w=abs(_c79.w);
	
	float	depth=r0.z * r0.x - _c78.w; //dofDist.w
	depth+=_c78.y * -0.5; //dofDist.y

#include "dof_config.txt"
#ifdef DEPTH_OF_FIELD
	float2	pixelSizeHigh;
	float2	pixelSizeLow;

	#ifdef SSAA_ENABLE
		pixelSizeHigh.xy=2.0 / _c44.xy;
	#else
		pixelSizeHigh.xy=1.0 / _c44.xy;
	#endif	

	pixelSizeLow.xy=pixelSizeHigh.xy;

	depth=max(depth, 0); //fix zoom bug


	float	centerDepth;

	if(depth < FocalPlaneDepth)
	    centerDepth=(depth - FocalPlaneDepth)/(FocalPlaneDepth - NearBlurDepth);
	else
	{
	    centerDepth=(depth - FocalPlaneDepth)/(FarBlurDepth - FocalPlaneDepth);
		centerDepth=clamp(centerDepth, 0.0, MaxBlurAmount);
	}

    centerDepth=centerDepth * 0.5 + 0.5;

	float	blurAmount=abs(centerDepth * 2.0 - 1.0);

	float	discRadius=blurAmount * float(DEPTH_OF_FIELD_QUALITY);
	float	discRadiusLow=discRadius * RadiusSacleMultipiler;
	
	r2.w=dot(r1.xyz, 0.3333);
	r2.w= max((r2.w - BokehBrightnessThreshold) * BokehBrightnessMultipiler, 0.0);
	r1.xyz*=1.0 + r2.w*blurAmount;
	
	r1.w=1.0;

	int sampleCycle=0;
	int sampleCycleCounter=0;
	int sampleCounterInCycle=0;
	
	#ifdef POLYGONAL_BOKEH
	
	float	basedAngle=360.0 / POLYGON_NUM;
	float2	currentVertex;
	float2	nextVertex;
		
	int	dofTaps=DEPTH_OF_FIELD_QUALITY * (DEPTH_OF_FIELD_QUALITY + 1) * POLYGON_NUM / 2.0;
	
	#else
	
	int	dofTaps=DEPTH_OF_FIELD_QUALITY * (DEPTH_OF_FIELD_QUALITY + 1) * 4;
	
	#endif
	
	for(int i=0; i < dofTaps; i++)
	{
		if(sampleCounterInCycle % sampleCycle == 0) 
		{			
			sampleCounterInCycle=0;
			sampleCycleCounter++;
		
			#ifdef POLYGONAL_BOKEH
			
			sampleCycle+=POLYGON_NUM;
			currentVertex.xy=float2(1.0 , 0.0);
			sincos(basedAngle* 0.017453292, nextVertex.y, nextVertex.x);
				
			#else	
			
			sampleCycle+=8;
			
			#endif
		}
		sampleCounterInCycle++;
		
		#ifdef POLYGONAL_BOKEH
		
		float	sampleAngle=basedAngle / float(sampleCycleCounter) * sampleCounterInCycle;
		float	remainAngle=frac(sampleAngle / basedAngle) * basedAngle;
		
		if(remainAngle == 0)
		{
			currentVertex=nextVertex;
			sincos((sampleAngle +  basedAngle) * 0.017453292, nextVertex.y, nextVertex.x);
		}

		float2	sampleOffset=lerp(currentVertex.xy, nextVertex.xy, remainAngle / basedAngle);
			
		#else
		
		float	sampleAngle=0.78539816 / float(sampleCycleCounter) * sampleCounterInCycle;
		float2	sampleOffset;
		sincos(sampleAngle, sampleOffset.y, sampleOffset.x);
			
		#endif	
		
		
		sampleOffset*=sampleCycleCounter / float(DEPTH_OF_FIELD_QUALITY);
		float2  coordLow=_v0.xy + (pixelSizeLow.xy * sampleOffset.xy * discRadiusLow);
		float2  coordHigh=_v0.xy + (pixelSizeHigh.xy * sampleOffset.xy * discRadius);
		
		#ifdef DOF_DISTORTION
			float4	tapLow=texDistorted(s2, coordLow.xy, DoFDistortionAmount*blurAmount);
		#else
			float4	tapLow=tex2D(s2, coordLow.xy);
		#endif
	    float4	tapHigh=tex2D(s2, coordHigh.xy);
		
		

		
	    float4	tdepth=tex2D(s1, coordHigh.xy); //GBufferTextureSampler3
		
	    tdepth.y=-_c77.x + _c77.y; //-dofProj.x + dofProj.y
	    tdepth.y=1.0 / tdepth.y;
	    tdepth.z=tdepth.y * _c77.y; //dofProj.y
	    tdepth.z=tdepth.z * -_c77.x; //dofProj.x
	    tdepth.x=_c77.y * -tdepth.y + tdepth.x;
	    tdepth.x=1.0 / tdepth.x;

	    tdepth.w=tdepth.z * tdepth.x - _c78.w; //dofDist.w
	    tdepth.w+=_c78.y * -0.5; //dofDist.y

	    tdepth.w=max(tdepth.w, 0); //fix zoom bug
		

		if(tdepth.w < FocalPlaneDepth)
			tapHigh.w=(tdepth.w - FocalPlaneDepth)/(FocalPlaneDepth - NearBlurDepth);
		else
		{
			tapHigh.w=(tdepth.w - FocalPlaneDepth)/(FarBlurDepth - FocalPlaneDepth);
			tapHigh.w=clamp(tapHigh.w, 0.0, MaxBlurAmount);
		}

    	tapHigh.w=tapHigh.w * 0.5 + 0.5;
		
		
	    tapLow.w=tapHigh.w;

		
				
	    float  tapBlur=abs(tapHigh.w * 2.0 - 1.0);
	    float4  tap=lerp(tapHigh, tapLow, tapBlur);
	    
		tap.w=(tap.w >= centerDepth) ? 1.0 : abs(tap.w * 2.0 - 1.0);
		
		float luma=dot(tap.xyz, 0.3333);
		float brightMultipiler=max((luma - BokehBrightnessThreshold) * BokehBrightnessMultipiler, 0.0);
		tap.xyz*=1.0 + brightMultipiler*tap.w;
	
		tap.xyz*=1.0 + BokehBias * pow(float(sampleCycleCounter)/float(DEPTH_OF_FIELD_QUALITY), BokehBiasCurve);
		
	
	    r1.xyz+=tap.xyz * tap.w;
	    r1.w+=tap.w;

	}

	
	r1.xyz /= r1.w;	
#endif
	
	r3=r1;
	r0.x=1.0;

	r4.x=_v0.y * _c5.x + _c5.y;
	r4.y=_v0.x * _c5.x + _c5.y;
	r4.z=_v0.y * _c5.x + _c5.y;
	r0.z=r4.y * _c77.z; //dofProj.z
	r0.z=r0.y * r0.z;
	r1.w=-r4.x * _c77.w; //dofProj.w
	r1.w=r0.y * r1.w;

	r5.xyz=r1.w * _c73.xyz; //motionBlurMatrix.2
	r5.xyz+=r0.z * _c72.xyz; //motionBlurMatrix.1
	r5.xyz+=-r0.y * _c74.xyz; //motionBlurMatrix.3
	r5.xyz+=_c75.xyz; //motionBlurMatrix.4
	
	r0.y=-r5.z * _c77.z; //dofProj.z
	r0.y=1.0/r0.y;
	r6.x=r5.x * r0.y;
	r0.y=r5.z * _c77.w; //dofProj.w
	r0.y=1.0/r0.y;
	r6.y=r5.y * r0.y;
	r0.yz=-r4.yz + r6.xy;

#include "mb_config.txt"
	r0.y=r0.y * _c80.x; //gDirectionalMotionBlurLength.x
	r0.z=r0.z * _c80.x;

	int mb_samples;
	if (MOTION_BLUR_QUALITY == -1) mb_samples = 0;
	if (MOTION_BLUR_QUALITY == 0) mb_samples = 5;
	if (MOTION_BLUR_QUALITY == 1) mb_samples = 25;
	if (MOTION_BLUR_QUALITY == 2) mb_samples = 50;
	if (MOTION_BLUR_QUALITY == 3) mb_samples = 100;
	if (MOTION_BLUR_QUALITY == 4) mb_samples = 150;
	int motionBlurSamples=int(pow(_c80.x, 0.5) * mb_samples);
	r4.xy=r0.yz / (float(motionBlurSamples) + 1);

	r5=tex2D(s6, _v0.xy); 
	r1.w=r5.x - _c85.x; //PLAYER_MASK.x
	r4.zw=r3.xy * _c2.w; //8.0
	r4.zw=_v0.xy * _c3.xy + r4.zw;
	r5=tex2D(s5, r4.zw);
	r4.zw=r4.xy * (r5.x - (float(motionBlurSamples) + 1.0)*0.5) + _v0.xy;
	
	r5.xyz=r3.xyz;
	r2.w=_c1.y; //1.0
	r3.w=_c1.y; //1.0
	
	for(int iii=0; iii < motionBlurSamples; iii++)
	{
		float4 tempuv;
		tempuv.xy=r4.xy * r3.w + r4.zw;
		tempuv.zw=0;
		r7=tex2Dlod(s6, tempuv);
		r5.w=r7.x - _c85.x;
		if (r5.w<-0.3)
		{
			r5.w=_c1.y; //1.0
		} else r5.w=_c1.w; //0.0
		r6=tex2Dlod(s2, tempuv);
		r5.xyz=r6.xyz * r5.w + r5.xyz;
		r2.w=r2.w + r5.w;
		r3.w=r3.w + _c1.y; //1.0
	}	

	r2.w=1.0/r2.w;
	r0.y=r0.y * _c44.x; //globalScreenSize
	r0.z=r0.z * _c44.y; //globalScreenSize
	r0.y=dot(r0.yz, r0.yz);//dp2
	r0.y=pow(r0.y, _c4.w); //0.5
	r0.y=r0.y * _c4.w; //0.5
	r0.x=r0.x + _c1.y; //1.0
	r0.x=1.0/r0.x;
	
	r0.x=saturate(r0.y * r0.x * 0.15);
	r4.xyz=r5.xyz * r2.w - r3.xyz;
	r0.xyz=r0.x * r4.xyz + r3.xyz;
	if (-r1.w<0.0) r0.xyz=r3.xyz;
	if (-r0.w<0.0) r0.xyz=r1.xyz;

r11=r0;

#include "godrays_config.txt"
#ifdef GODRAYS
	float2 sunpos = 0.5;
	float2 _v1 = 0;
	float maxi = 0;
	int count = 0;
	float4 ratio = 0.1;
	float deltax = 0.04 / ratio;
	int samplex = 25 * ratio;
	int gr_samples = 100;

	if(GODRAYS_QUALITY == 0) gr_samples = 32;
	if(GODRAYS_QUALITY == 1) gr_samples = 64;
	if(GODRAYS_QUALITY == 2) gr_samples = 100;
	if(GODRAYS_QUALITY == 3) gr_samples = 164;
	if(GODRAYS_QUALITY == 4) gr_samples = 200;

	for(int i = 1; i <= 25; i++)
	{
		for(int j = 1; j <= samplex; j++)
		{	
			r2 = tex2D(s2, _v1.xy);
			r2.x = saturate(cross(r5.xyz, 0.003) - 10.0);
			if((r5.x >= maxi) && r5.x) 
			{
				maxi = r5.x;
				sunpos.xy += _v1.xy;
				count ++;
			}
			_v1.x += deltax ;
		}
		_v1.x = 0.32;
		_v1.y += 0.015;
	}

	if(maxi) sunpos.xy /= count--;

	float4 color;
	//r0=tex2D(s2, _v0.xy);//hdr color
	r11=r0 + r11; 
	//color.xyz=0.0;


	float2	ScreenLightPos;

	ScreenLightPos.xy = sunpos.xy;

	float2	texCoord = _v0;
	float2	deltaTexCoord = (texCoord.xy - ScreenLightPos.xy);
		
	deltaTexCoord *= 1.0 / gr_samples * Density;
	
	float	illuminationDecay = 1.0;

	if(maxi)
	{
		for(int x = 0; x < gr_samples; x++)
		{
	   	 	texCoord -= deltaTexCoord;
	    		float4 sample = tex2D(s0, texCoord.xy);
	    		if(sample.w) sample.xyz = 0.0;
	    	else
	    	{
			sample = tex2D(s2, texCoord.xy);
			sample.w = saturate(dot(sample.xyz, 0.333) - 9);
			if(sample.w == 0) sample.xyz = 0.0;
			sample.r *= GodRays_Color_R;
			sample.g *= GodRays_Color_G;
			sample.b *= GodRays_Color_B;
	    	}
	    	    
	    	sample *= illuminationDecay * Weight;
	    	r11 += sample;
	    	illuminationDecay *= Decay;
		}

	}

	r11 *= Exposure;
#endif

	r1=tex2D(s4, _c0.x); //AdapLumSampler , 0.0
	r0.w=1.0/r1.x;
	r0.w=r0.w * _c81.y; //ToneMapParams.y
	r1.x=1.0/r0.w;
	r1.x=r1.x * _c81.x; //ToneMapParams.x
	r1.xyz=r2 * _c66.x - r1.x; //Exposure.x
	r2.xyz=max(r1, _c0.x); //0.0
	r1.xyz=r2 * _c81.z; //ToneMapParams.z
	r1.xyz=r1 * _c1.x; //0.25
	r0.xyz=r0 * _c66.x + r1; //Exposure.x
	r1.xyz=r0.w * r0;
	r1.x=dot(r1.xyz, _c0.yzw); //0.2125, 0.7154, 0.0721
	r0.xyz=r0 * r0.w - r1.x;
	r0.xyz=_c82.x * r0 + r1.x; //deSatContrastGamma.x
	r0.w=r1.x * _c84.w; //ColorShift.w
	r1.yzw=r0.w * _c84.xxyz; //ColorShift

	//darken as DarkeningAmount, but keeps colors
	r2.x=saturate(r0.w);
	r0.xyz=r0.xyz - _c84.xyz * r0.w; //ColorShift
	r0.xyz=r2.x * r0.xyz + r1.yzww;

	//coloring (green, brown, ...)
	r0.xyz=2.0 * r0.xyz * _c83.xyz; //ColorCorrect

	//keeps colors, changes luma
	r1.x=saturate(r1.x);
	r0.w=_c82.z - r8.y; //deSatContrastGamma.z
	r2.x=pow(r1.x, r0.w);

	_oC0.xyz=r0.xyz * r2.x; 
	_oC0.w=_c1.y; //1.0


	r5=tex2D(s4, _c0.x);//adaptation luminance
	r0=tex2D(s2, _v0.xy);
	r0=r11;
	r5.w=r5.x;
	r5.w=Brightness/r5.w;
	r0.xyz=r0 * r5.w;
	r3.xy=_c10.xwxw;
	r3.xy=r3.xy * r5.w;
	float4 dirt=tex2D(s13, _v0.xy);
	r7=tex2D(s3, _v0.xy);
	r7.xyz+=r7.xyz*dirt.xyz*LensDirt;
	r0=r7 * Bloom2 + r0; //0.05 
	r10=dot(r0.xyz, _c12.xyz);
	r9.x=r10.x * 1.50;//c199.x;
	r10.x=1.0/r10.x;
	r10=r10 * r9.x;
	r0=r0 * r10.x;
	r0=r0 * _c7.y; 
	r1=r0 * _c7.z;
	r1=r1 + _c7.w;
	r1.xyz=1.0/r1.xyz;
	r0=r0 * r1;
	
	float gris=dot(r0.xyz, 0.333);
	float3 SaturatedColor=pow(r0.xyz, Saturation);
	float Niveaudegris=dot(SaturatedColor.xyz, 0.333);
	float3 Resultat=SaturatedColor.xyz*gris/(Niveaudegris+0.0001);
	float4 Mix=lerp(1, 0.75, saturate(pow(depth/1000.0, 1)));
	r0.xyz = pow(Resultat,Mix);
	
	r0.xyz = lerp(r0.xyz, 0.5 * (1 + sin((r0.xyz - 0.5)*3.1415926)), Contrast);
	r0=Bloom1*r7 * r3.x + r0;
	
	

	r0.w = depth;
	r0.w *= 1/(r0.w + 0.5);
	
	
	
	float	focus;
	float2	centerscreen;
	centerscreen.x=_v0.x-0.5;
	centerscreen.y=0.5-_v0.y;
	focus = length(centerscreen.xy * 1.41);
	focus = pow(focus, 4.0);
	r0.xyz -= focus * Vignette;

	_oC0=r0;
	return _oC0;
}


technique Shader_C215BE6E
{
    pass p0 
    {
		PixelShader  = compile ps_3_0 PS_C215BE6E();
	}
}
