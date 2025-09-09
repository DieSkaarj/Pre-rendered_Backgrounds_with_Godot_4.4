shader_type spatial;
render_mode unshaded,ambient_light_disabled,depth_draw_always,shadows_disabled,cull_disabled;

uniform sampler2D DEPTH_TEXTURE : hint_depth_texture;

void vertex() {
	// Called for every vertex the material is visible on.
	POSITION = vec4( VERTEX.xy,1.,1. );
}

float get_linear_map( float t_depth,vec2 t_scr_uv,mat4 t_matrix ){
	
	#if CURRENT_RENDERER == RENDERER_COMPATIBILITY
	vec3 this_ndc = vec3(t_scr_uv, t_depth) * 2.0 - 1.0;
	#else
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, t_depth);
	#endif
	vec4 view = t_matrix * vec4(this_ndc, 1.0);
	
	view.xyz /= view.w;
	
	float linear_depth = view.z*0.01;
	return linear_depth;
}

void fragment(){
	// Called for every pixel the material is visible on.
	float depth = texture( DEPTH_TEXTURE, SCREEN_UV).x;
	float linear_depth = get_linear_map( depth, SCREEN_UV, INV_PROJECTION_MATRIX );
	
	ALBEDO.rgb = vec3( fract( linear_depth ) );
}