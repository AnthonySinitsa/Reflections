#if !defined(MY_SHADOWS_INCLUDED)
#define MY_SHADOWS_INCLUDED

#include "UnityCG.cginc"

struct VertexData {
	float4 position : POSITION;
	float3 normal : NORMAL;
};

struct Interpolators {
	float4 position : SV_POSITION;
	#if defined(SHADOWS_CUBE)
		float3 lightVec : TEXCOORD0;
	#endif
};

	Interpolators MyShadowVertexProgram (VertexData v) {
		Interpolators i;
		#if defined(SHADOWS_CUBE)
			i.position = UnityObjectToClipPos(v.position);
			i.lightVec =
				mul(unity_ObjectToWorld, v.position).xyz - _LightPositionRange.xyz;
		#else
			i.position = UnityClipSpaceShadowCasterPos(v.position.xyz, v.normal);
			i.position = UnityApplyLinearShadowBias(i.position);
		#endif
		return i;
	}

	float4 MyShadowFragmentProgram (Interpolators i) : SV_TARGET {
		#if defined(SHADOWS_CUBE)
			float depth = length(i.lightVec) + unity_LightShadowBias.x;
			depth *= _LightPositionRange.w;
			return UnityEncodeCubeShadowDepth(depth);
		#else
			return 0;
		#endif
	}
#else
	float4 MyShadowVertexProgram (VertexData v) : SV_POSITION {
		float4 position =
			UnityClipSpaceShadowCasterPos(v.position.xyz, v.normal);
		return UnityApplyLinearShadowBias(position);
	}

	half4 MyShadowFragmentProgram () : SV_TARGET {
		return 0;
	}

#endif