Shader "ImageEffect/Chromatic"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RGBsplit ("RGB Split", float) = 0
        _ChromaticPower ("Chromatic Power", float) = 2
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _RGBsplit;
            float _ChromaticPower;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col;
                float2 expandTexcoord = i.uv * 2 - 1; // -1 ~ +1
                float radialGradient = dot(expandTexcoord, expandTexcoord); //  크기가 같은 벡터의 내적은, 벡터의 제곱이다! :: expandTexcoord.x^2 + expandTexcoord.y^2
                      radialGradient = saturate(pow(radialGradient, _ChromaticPower));

                half colR = tex2D(_MainTex, i.uv + float2(_RGBsplit, _RGBsplit) * 0.1).r;
                // half colR = tex2D(_MainTex, i.uv + float2(_RGBsplit, _RGBsplit) * radialGradient).r;
                half colG = tex2D(_MainTex, i.uv).g;
                half colB = tex2D(_MainTex, i.uv - float2(_RGBsplit, _RGBsplit) * 0.1).b;
                // half colB = tex2D(_MainTex, i.uv - float2(_RGBsplit, _RGBsplit) * radialGradient).b;

                col.rgb = float3(colR, colG, colB);

                // radialGradient을 리턴하면 uv맵을 볼 수 있다?
                return col;
            }
            ENDCG
        }
    }
}
