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
		editor.TexturePropertySingleLine(
			MakeLabel(mainTex, "Albedo (RGB)"), mainTex, FindProperty("_Tint")
		);
        DoNormals():
		editor.TextureScaleOffsetProperty(mainTex);
	}

    MaterialProperty FindProperty(string name){
        return FindProperty(name, properties);
    }

    static GUIContent staticLabel = new GUIContent();
	
	static GUIContent MakeLabel (
		MaterialProperty property, string tooltip = null
	) {
		staticLabel.text = property.displayName;
		staticLabel.tooltip = tooltip;
		return staticLabel;
	}

    void DoNormals(){
        MaterialProperty map = FindProperty("_NormalMap");
        editor.TexturePropertySingleLine(
			MakeLabel(map), map,
			map.textureValue ? FindProperty("_BumpScale") : null
		);
    }
}