using UnityEngine;

[ExecuteInEditMode]
public class DeferredFogEffect : MonoBehaviour {

    void OnRenderImage (RenderTexture source, RenderTexture destination) {
        Graphics.Blit (source, destination);
	}
}