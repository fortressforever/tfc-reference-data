#include <amxmodx>
#include <engine>

#define PLUGIN "Test Pipes"
#define VERSION "0.1"
#define AUTHOR "squeek."

#define TEST_PIPE_TARGET_CVAR "test_pipe_target"
#define TEST_PIPE_RADIUS_CVAR "test_pipe_radius"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_think("tf_gl_pipebomb", "gren_think")

	register_cvar(TEST_PIPE_TARGET_CVAR, "1")
	register_cvar(TEST_PIPE_RADIUS_CVAR, "0")
}

// teleport grenades to the origin of the target
public gren_think(gren_id)
{
	if (get_cvar_num(TEST_PIPE_TARGET_CVAR) < 0)
		return

	teleport_ent_to_ent(gren_id, get_cvar_num(TEST_PIPE_TARGET_CVAR))
	static Float:zero_velocity[3] = {0.0}
	entity_set_vector(gren_id, EV_VEC_velocity, zero_velocity)
}

// move entity to the origin of the target
public teleport_ent_to_ent(ent_id, target_id)
{
	if (!is_valid_ent(target_id) || !is_valid_ent(ent_id))
		return

	static Float:target_origin[3]
	entity_get_vector(target_id, EV_VEC_origin, target_origin)
	target_origin[0] = target_origin[0] + get_cvar_num(TEST_PIPE_RADIUS_CVAR)
	entity_set_vector(ent_id, EV_VEC_origin, target_origin)
}