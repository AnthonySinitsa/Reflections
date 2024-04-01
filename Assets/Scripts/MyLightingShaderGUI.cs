using UnityEngine;
using UnityEditor;

public class MyLightingShaderGUI : ShaderGUI{

    MaterialEditor editor;
    MaterialProperty[] properties;

    public override void OnGUI(
        MaterialEditor materialEditor, MaterialProperty[] properties
    ){
        this.editor = editor;
        this.properties = properties;
        DoMain();
    }

    void DoMain () {
		GUILayout.Label("Main Maps", EditorStyles.boldLabel);

		MaterialProperty mainTex = FindProperty("_MainTex");
		GUIContent albedoLabel =
			new GUIContent(mainTex.displayName, "Albedo (RGB)");
		editor.TexturePropertySingleLine(
			albedoLabel, mainTex, FindProperty("_Tint")
		);
		editor.TextureScaleOffsetProperty(mainTex);
	}

    MaterialProperty FindProperty(string name){
        return FindProperty(name, properties);
    }
}