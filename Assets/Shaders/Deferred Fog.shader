Shader "Custom/Deferred Fog" {
	
	Properties {
		_MainTex ("Source", 2D) = "white" {}
	}

	SubShader {
		Cull Off
		ZTest Always
		ZWrite Off

		Pass {
      CGPROGRAM

			#pragma vertex VertexProgram
			#pragma fragment FragmentProgram

			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			sampler2D _MainTex;

			struct VertexData {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Interpolators {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			Interpolators VertexProgram (VertexData v) {
				Interpolators i;
				i.pos = UnityObjectToClipPos(v.vertex);
				i.uv = v.uv;
				return i;
			}

			float4 FragmentProgram (Interpolators i) : SV_Target {
				float3 sourceColor = tex2D(_MainTex, i.uv).rgb;
				return float4(sourceColor, 1);
			}

			ENDCG
		}
	}
}