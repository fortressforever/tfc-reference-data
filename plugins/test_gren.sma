#include <amxmodx>
#include <engine>

#define PLUGIN "Test Grenades"
#define VERSION "0.1"
#define AUTHOR "squeek."

#define TEST_GREN_TARGET_CVAR "test_gren_target"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_think("tf_weapon_normalgrenade", "gren_think")

	register_cvar(TEST_GREN_TARGET_CVAR, "1")
}

// teleport grenades to the origin of the target
public gren_think(gren_id)
{
	teleport_ent_to_ent(gren_id, get_cvar_num(TEST_GREN_TARGET_CVAR))
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
	entity_set_vector(ent_id, EV_VEC_origin, target_origin)
}