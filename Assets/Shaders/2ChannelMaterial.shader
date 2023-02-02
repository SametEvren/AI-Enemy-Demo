// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "2ChannelMaterial"
{
	Properties
	{
		_AlbedoBase("AlbedoBase", 2D) = "white" {}
		_TattoAlpha("Tatto Alpha", 2D) = "white" {}
		_ColorTint("Color Tint", Color) = (1,1,1,0)
		_Tatto("Tatto", Range( 0 , 1)) = 0
		_TattooColor("Tattoo Color", Color) = (1,0,0,0)
		_TattooEmissive("Tattoo Emissive", Float) = 0
		_TattooEmissiveColor("Tattoo Emissive Color", Color) = (0,0,0,0)
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
		};

		uniform float4 _ColorTint;
		uniform sampler2D _AlbedoBase;
		uniform float4 _AlbedoBase_ST;
		uniform sampler2D _TattoAlpha;
		uniform float4 _TattoAlpha_ST;
		uniform float4 _TattooColor;
		uniform float _Tatto;
		uniform float _TattooEmissive;
		uniform float4 _TattooEmissiveColor;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_AlbedoBase = i.uv_texcoord * _AlbedoBase_ST.xy + _AlbedoBase_ST.zw;
			float4 temp_output_30_0 = ( _ColorTint * tex2D( _AlbedoBase, uv_AlbedoBase ) );
			float2 uv2_TattoAlpha = i.uv2_texcoord2 * _TattoAlpha_ST.xy + _TattoAlpha_ST.zw;
			float4 tex2DNode13 = tex2D( _TattoAlpha, uv2_TattoAlpha );
			float DecalMask23 = tex2DNode13.r;
			float4 lerpResult11 = lerp( temp_output_30_0 , ( ( temp_output_30_0 * ( 1.0 - tex2DNode13.r ) ) + ( DecalMask23 * _TattooColor ) ) , _Tatto);
			o.Albedo = lerpResult11.rgb;
			o.Emission = ( ( DecalMask23 * _TattooEmissive ) * _TattooEmissiveColor ).rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18921
435;246;1198;665;926.2479;1112.7;2.041038;True;False
Node;AmplifyShaderEditor.SamplerNode;13;-1183.586,-627.2899;Inherit;True;Property;_TattoAlpha;Tatto Alpha;1;0;Create;True;0;0;0;False;0;False;-1;3cf4942e6558a504a8056bf0e874cd18;3cf4942e6558a504a8056bf0e874cd18;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-873.1237,-429.1896;Inherit;False;DecalMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-1197.373,-913.8032;Inherit;True;Property;_AlbedoBase;AlbedoBase;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;31;-1088.224,-1121.263;Inherit;False;Property;_ColorTint;Color Tint;3;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-612.8682,-840.6899;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;24;-1358.226,-150.1857;Inherit;False;23;DecalMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-1571.177,-48.58599;Inherit;False;Property;_TattooColor;Tattoo Color;5;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;16;-681.4407,-622.6492;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;113.1591,-135.9375;Inherit;False;Property;_TattooEmissive;Tattoo Emissive;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-1143.192,-94.82928;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-428.3506,-688.4089;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;89.44684,-238.477;Inherit;False;23;DecalMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-923.8622,295.8434;Inherit;False;Property;_Tatto;Tatto;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;303.1656,-234.8643;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;29;127.0336,-7.92725;Inherit;False;Property;_TattooEmissiveColor;Tattoo Emissive Color;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-178.6833,-581.9938;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;10;-969.9745,85.16742;Inherit;True;Property;_Decal;Decal;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;11;346.3032,-865.0905;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;491.1519,-178.9766;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;384,-640;Inherit;False;Property;_Metallic;Metallic;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;384,-544;Inherit;False;Property;_Smoothness;Smoothness;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;32;1047.888,-798.2903;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;2ChannelMaterial;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;13;1
WireConnection;30;0;31;0
WireConnection;30;1;9;0
WireConnection;16;0;13;1
WireConnection;14;0;24;0
WireConnection;14;1;15;0
WireConnection;17;0;30;0
WireConnection;17;1;16;0
WireConnection;26;0;22;0
WireConnection;26;1;21;0
WireConnection;18;0;17;0
WireConnection;18;1;14;0
WireConnection;11;0;30;0
WireConnection;11;1;18;0
WireConnection;11;2;12;0
WireConnection;27;0;26;0
WireConnection;27;1;29;0
WireConnection;32;0;11;0
WireConnection;32;2;27;0
WireConnection;32;3;20;0
WireConnection;32;4;19;0
ASEEND*/
//CHKSM=2D17FF1F40A6502C285226DC5EB91D311A728BE7