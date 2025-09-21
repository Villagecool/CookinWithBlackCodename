#pragma header

uniform float leftSkew;   // Range: -1.0 to 1.0
uniform float rightSkew;  // Range: -1.0 to 1.0

void main() {
    // Normalized texture coordinates
    vec2 uv = openfl_TextureCoordv;

    // Vertical skew factor interpolated from left to right
    float skewAmount = mix(leftSkew, rightSkew, uv.x);

    // Apply vertical warp based on horizontal position
    vec2 warpedUV = vec2(uv.x, uv.y + (0.5 - uv.x) * skewAmount);

    // Clamp to avoid sampling outside the texture
    warpedUV = clamp(warpedUV, 0.0, 1.0);

    gl_FragColor = texture2D(bitmap, warpedUV) * openfl_Alphav;
}
