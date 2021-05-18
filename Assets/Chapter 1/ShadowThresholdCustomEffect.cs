using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class ShadowThresholdCustomEffect : MonoBehaviour
{
    [SerializeField] private Material ShadowMaterial;

    [SerializeField] private Color ShadowColor;
    [Range(0, 1)]
    [SerializeField] private float ShadowThreshold;

    // 모든 렌더링이 끝나고 실행되는 함수
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        ShadowMaterial.SetFloat("_ShadowThreshold", ShadowThreshold);
        ShadowMaterial.SetColor("_ShadowColor", ShadowColor);

        // destination(렌더타겟)의 원래 이미지(source)에 
        // [ShadowMaterial]로 연산해 달라는 함수
        Graphics.Blit(source, destination, ShadowMaterial);
    }
}
