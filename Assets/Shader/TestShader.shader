// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/TestShader"
{
	Properties
	{
		_Diffuse("DiffuseColor",Color)=(1,1,1,1)
	}
	SubShader{
		Pass{
			Tags{"LightMode"="ForwardBase"}//不写这个光源方向是反的
			CGPROGRAM
			#pragma vertex vert
			#pragma	fragment frag
			#include "Lighting.cginc"//使用_LightColor0需要引用该头文件 

			fixed4 _Diffuse;//float 32bit,half 16bit,fixed 11bit
			struct a2v{
				float4 vertex :POSITION;//POSITION 语义 gpu在哪里存取数据
				float3 normal :NORMAL;
			};
			struct v2f{
				float4 worldPos:SV_POSITION;//SV_POSITION可以用POSITION代替，SV_TARGET可以用COLOR代替。SV_TARGET特指片源着色器的输出颜色
				fixed3 color :COLOR;
			};
			v2f vert(a2v v){//顶点程序
				v2f o;
				o.worldPos=UnityObjectToClipPos(v.vertex);//从模型空间变化到裁剪空间
				fixed3 nDir=normalize( mul((float3x3)unity_ObjectToWorld,v.normal));//顶点法线从模型空间变换到世界空间,

				fixed3 lDir=normalize(_WorldSpaceLightPos0.xyz);//光源方向，这里只适用于平行光，这里光源方向就是从光源位置减去原点

				fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.xyz;

				fixed diffuse =_LightColor0*_Diffuse * saturate(dot(nDir,lDir));//saturate框定值为0-1，
				o.color=ambient+diffuse;//Ambient指的环境光  颜色相加越加越白
				return o;				
			}
			fixed4 frag(v2f IN):SV_TARGET{
				return fixed4(IN.color,1.0);
			}
			ENDCG
		}


	}
	
}
