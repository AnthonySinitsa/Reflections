using UnityEngine;
using UnityEditor;

public class MyLightingShaderGUI : ShaderGUI{

    public override void OnGUI(
        MaterialEditor materialEditor, MaterialProperty[] properties
    ){
        DoMain();
    }

    void DoMain(){
        GUILayout.Label("Main Maps", EditorStyles.boldLabel);
    }
}