Shader "Custom/DeferredShading" {
  
  Properties {
  }
  
	SubShader {
    
    UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);

    Pass {
      Blend One One
			Cull Off
			ZTest Always
			ZWrite Off
      
			CGPROGRAM
      
			#pragma vertex VertexProgram
			#pragma fragment FragmentProgram
      
			#pragma exclude_renderers nomrt
      
      #pragma multi_compile_lightpass
			#pragma multi_compile _ UNITY_HDR_ON
      
			#include "MyDeferredShading.cginc"
      
			ENDCG
		}

		Pass {
			Cull Off
			ZTest Always
			ZWrite Off

			Stencil {
				Ref [_StencilNonBackground]
				ReadMask [_StencilNonBackground]
				CompBack Equal
				CompFront Equal
			}

			CGPROGRAM

			#pragma target 3.0
			#pragma vertex VertexProgram
			#pragma fragment FragmentProgram

			#pragma exclude_renderers nomrt

			#include "UnityCG.cginc"

			sampler2D _LightBuffer;

			struct VertexData {
				float4 vertex : POSITION;
        float3 normal : NORMAL;
			};

			struct Interpolators {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
        float3 ray : TEXCOORD1;
			};

			Interpolators VertexProgram (VertexData v) {
				Interpolators i;
				i.pos = UnityObjectToClipPos(v.vertex);
				i.uv = ComputeScreenPos(i.pos)
        i.ray = v.normal;
				return i;
			}

			float4 FragmentProgram (Interpolators i) : SV_Target {
        float2 uv = i.uv.xy / i.uv.w;

        float depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv);
	      depth = Linear01Depth(depth);

        float3 rayToFarPlane = i.ray * _ProjectionParams.z / i.ray.z;
        float3 viewPos = rayToFarPlane * depth;
	      float3 worldPos = mul(unity_CameraToWorld, float4(viewPos, 1)).xyz;

        return 0;
			}

			ENDCG
		}
	}
}