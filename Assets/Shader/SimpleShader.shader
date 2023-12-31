Shader "Chapter 5/SimpleShader"
{
    Properties
    {
        _Color ("Color Tint", Color) = (1.0, 1.0, 1.0, 1.0)
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            fixed4 _Color;
            
            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;
            };

            // float4 vert(float4 v: POSITION) : SV_POSITION
            // {
            //     // return mul(UNITY_MATRIX_MVP, v);
            //     return UnityObjectToClipPos(v);
            // }
            v2f vert(a2v v)
            {
                // return UnityObjectToClipPos(v.vertex);
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }

            // fixed4 frag() : SV_Target
            // {
            //     return fixed4(1.0, 1.0, 1.0, 1.0);
            // }
            fixed4 frag(v2f i) : SV_Target
            {
                fixed3 c = i.color;
                c *= _Color.rgb;
                return fixed4(c, 1.0);
            }

            ENDCG
        }
    }
}
