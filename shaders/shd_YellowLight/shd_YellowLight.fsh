varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec2 uv = v_vTexcoord;

    float glow = 0.0;

    for (int x = -3; x <= 3; x++) {
        for (int y = -3; y <= 3; y++) {
            vec2 offset = vec2(x, y) * 0.004;

            vec4 col = texture2D(gm_BaseTexture, uv + offset);

            // detect your exact yellow (#FFF200)
            float matchR = smoothstep(0.9, 1.0, col.r);
            float matchG = smoothstep(0.85, 1.0, col.g);
            float matchB = 1.0 - smoothstep(0.05, 0.2, col.b);

            float yellow = matchR * matchG * matchB;

            glow += yellow;
        }
    }

    glow /= 49.0;

    // nice yellow glow color
    vec3 glowColor = vec3(1.0, 0.95, 0.2);

    gl_FragColor = vec4(vec3(glow * 20.0), glow * 20.0);
}