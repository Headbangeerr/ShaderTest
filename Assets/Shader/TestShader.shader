Shader "Unlit/TestShader"
{
	Properties
	{
		_Diffuse("DiffuseColor",Color)=(1,1,1,1)
	}
	SubShader{
		Pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma	fragment frag

			fixed4 _Diffuse;//float 32bit,half 16bit,fixed 11bit
			struct a2v{
				float4 vertex :POSITION;//POSITION 语义 gpu在哪里存取数据
				float3 normal :NORMAL;
			};
			struct v2f{
				float3  worldPos:SV_POSITION;
				fixed3 color :COLOR;
			};
			
			ENDCG
		}


	}
	
}
