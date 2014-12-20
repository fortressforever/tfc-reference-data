#include <amxmodx>
#include <engine>
#include <xs>

#define PLUGIN "Test RPG"
#define VERSION "0.1"
#define AUTHOR "squeek."

#define RPG_TEST_RADIUS 120.0
#define RPG_TEST_TARGET_CVAR "test_rpg_target"

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_touch("tf_rpg_rocket", "*", "rocket_touch")

	register_cvar(RPG_TEST_TARGET_CVAR, "1")
}

// redirect rockets to the target ent and log some data
public rocket_touch(rocket_id, victim_id)
{
	teleport_ent_to_ent(rocket_id, get_cvar_num(RPG_TEST_TARGET_CVAR))

	static Float:rocket_origin[3]
	entity_get_vector(rocket_id, EV_VEC_origin, rocket_origin);

	log_message("rocket origin: (%.3f,%.3f,%.3f)", rocket_origin[0], rocket_origin[1], rocket_origin[2])

	static Float:victim_origin[3];
	static ent = -1
	while((ent = find_ent_in_sphere(ent, rocket_origin, RPG_TEST_RADIUS)) != 0)
	{
		if (ent == rocket_id)
			continue

		if (!is_user_connected(ent))
			continue

		entity_get_vector(ent, EV_VEC_origin, victim_origin)
		new Float:distance = vector_distance(rocket_origin, victim_origin)
		static Float:velocity[3]
		entity_get_vector(ent, EV_VEC_velocity, velocity)

		log_message("rocket victim %d origin: (%.3f,%.3f,%.3f) [distance: %.1f] velocity: (%.3f,%.3f,%.3f) [length: %.3f]", ent, victim_origin[0], victim_origin[1], victim_origin[2], distance, velocity[0], velocity[1], velocity[2], xs_vec_len(velocity))
	}
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
