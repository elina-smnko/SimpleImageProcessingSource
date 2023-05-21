//
//  Kernels.metal
//
//  Created by Elina Semenko
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>
using namespace metal;

float2 n2mod289(float2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }

float3 n2mod289(float3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }

float4 n2mod289(float4 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }

float3 permute(float3 x) { return n2mod289(((x * 34.0) + 1.0) * x); }

extern "C" {
    namespace coreimage {
        float4 grayscaleKernel(sample_t s) {
            float gray = (0.2989 * s.r + 0.5870 * s.g + 0.1140 * s.b);
            return float4(gray, gray, gray, s.a);
        }
        
        float4 thresholdKernel(sample_t s, float t) {
            float luminance = (s.r * 0.2126) + (s.g * 0.7152) + (s.b * 0.0722);
            return float4(step(t, luminance));
        }
        
        float2 hash(float2 p) {
            return float2(fract(sin(dot(p, float2(12.9898,78.233))) * 43758.5453123));
        }
        
        float voronoi(float2 p) {
            float2 g = floor(p);
            float2 f = fract(p);
            
            float distanceToClosestFeaturePoint = 1.0;
            for(int y = -1; y <= 1; y++)
            {
                for(int x = -1; x <= 1; x++)
                {
                    float2 latticePoint = float2(x, y);
                    float currentDistance = distance(latticePoint + hash(g+latticePoint), f);
                    distanceToClosestFeaturePoint = min(distanceToClosestFeaturePoint, currentDistance);
                }
            }
            return distanceToClosestFeaturePoint;
        }
        
        float4 voronoiKernel(destination dest) {
            float2 uv = dest.coord() / 100.0;
            float r = smoothstep(0.0, 0.7, voronoi(uv) * 0.5);
            float3 finalColor = float3(r);
            return float4(finalColor, 1.0);
        }
        
        float4 perlin(float2 uv) {
            float2 g = floor(uv);
            float2 f = fract(uv);
            
            float2 blur = smoothstep(0.0, 1.0, f);
            
            return mix(mix(dot(hash(g + float2(0.0,0.0)), f - float2(0.0,0.0)),
                           dot(hash(g + float2(1.0,0.0)), f - float2(1.0,0.0)),blur.x),
                       mix(dot(hash(g + float2(0.0,1.0)), f - float2(0.0,1.0)),
                           dot(hash(g + float2(1.0,1.0)), f - float2(1.0,1.0)),blur.x),blur.y) + 0.5;
        }
        
        float4 perlinKernel(destination dest) {
            float2 uv = dest.coord() / 90.0;
            return perlin(uv);
        }
        
        float simplex(float2 v) {
            const float4 C = float4(0.211324865405187,
                                    0.366025403784439,
                                    -0.577350269189626,
                                    0.024390243902439);
            
            float2 i = floor(v + dot(v, C.yy));
            float2 x0 = v - i + dot(i, C.xx);
            
            float2 i1;
            i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);
            float4 x12 = x0.xyxy + C.xxzz;
            x12.xy -= i1;
            
            i = n2mod289(i);
            float3 p = permute(permute(i.y + float3(0.0, i1.y, 1.0)) + i.x + float3(0.0, i1.x, 1.0));
            float3 m = max(0.5 - float3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
            m = m * m;
            m = m * m;
            
            float3 x = 2.0 * fract(p * C.www) - 1.0;
            float3 h = abs(x) - 0.5;
            float3 ox = floor(x + 0.5);
            float3 a0 = x - ox;
            
            m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
            
            float3 g;
            g.x = a0.x * x0.x + h.x * x0.y;
            g.yz = a0.yz * x12.xz + h.yz * x12.yw;
            return 255 * dot(m, g);
        }

        float4 simplexKernel(destination dest) {
            float2 uv = dest.coord() / 8;
            float r = smoothstep(0.0, 0.8, simplex(uv));
            float3 finalColor = float3(r);
            return float4(finalColor, 1.0);
        }
    }
}
