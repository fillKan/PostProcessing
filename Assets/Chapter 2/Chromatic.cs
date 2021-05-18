using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class Chromatic : MonoBehaviour
{
    [SerializeField] private Material ChromaticMaterial;

    [Range(0f,0.5f)]
    [SerializeField] private float rgbSplit;
    [SerializeField] private float ChromaticPower;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        ChromaticMaterial.SetFloat("_ChromaticPower", ChromaticPower);
        ChromaticMaterial.SetFloat("_RGBsplit", rgbSplit);

        Graphics.Blit(source, destination, ChromaticMaterial);
    }
}
