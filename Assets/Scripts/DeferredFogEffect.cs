using UnityEngine;
using System;

[ExecuteInEditMode]
public class DeferredFogEffect : MonoBehaviour {

    public Shader deferredFog;

    [NonSerialized]
    Material fogMaterial;

    [ImageEffectOpaque]
    void OnRenderImage (RenderTexture source, RenderTexture destination) {
        if (fogMaterial == null) {
			fogMaterial = new Material(deferredFog);
		}
        Graphics.Blit (source, destination, fogMaterial);
	}
}