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

    void DoMain(){
        GUILayout.Label("Main Maps", EditorStyles.boldLabel);

        MaterialProperty mainTex = FindProperty("_MainTex", properties);
        GUIContent albedoLabel = new GUIContent(mainTex.displayName, "Albedo (RGB)");
        MaterialProperty tint = FindProperty("_Tint", properties);
        editor.TexturePropertySingleLine(albedoLabel, mainTex, tint);
        editor.TextureScaleOffsetProperty(mainTex);
    }
}