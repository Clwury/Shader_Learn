Shader "Chapter 6/HalfLambert"
{
    Properties
    {
//        _MainTex ("Texture", 2D) = "white" {}
        _Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
//        Tags { "RenderType"="Opaque" }
//        LOD 100

        Pass
        {
            Tags
            {
                "LightMode" = "ForwardBase"
            }
                
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            // #pragma multi_compile_fog

            // #include "UnityCG.cginc"
            #include "Lighting.cginc"

            // struct appdata
            // {
            //     float4 vertex : POSITION;
            //     float2 uv : TEXCOORD0;
            // };
            struct a2v
            {
                float4 vertex: POSITION;
                float3 normal: NORMAL;
            };

            struct v2f
            {
                // float2 uv : TEXCOORD0;
                // UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float3 worldNormal: TEXCOORD0;
            };

            // sampler2D _MainTex;
            fixed4 _Diffuse;
            // float4 _MainTex_ST;

            v2f vert (a2v v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                // o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                // fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                // UNITY_APPLY_FOG(i.fogCoord, col);
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                
                fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 worldNormal = normalize(i.worldNormal);
                // half Lambert
                fixed halfLambert = 0.5 * dot(worldNormal, worldLight) + 0.5;
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLambert;
                fixed3 color = ambient + diffuse;
                return fixed4(color, 1.0);
                // return col;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
