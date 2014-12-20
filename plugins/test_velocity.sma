#include <amxmodx>
#include <engine>
#include <xs>

#define PLUGIN "Test Velocity"
#define VERSION "0.1"
#define AUTHOR "squeek."

#define MAX_CLIENTS       32

#define TEST_VELOCITY_THRESHOLD_CVAR "test_velocity_threshold"

new Float:gLastVelocities[ MAX_CLIENTS + 1 ][ 3 ]

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)

	register_cvar(TEST_VELOCITY_THRESHOLD_CVAR, "300")
}

public server_frame()
{
	check_velocities()
}

public check_velocities()
{
	static i
	static Float:delta_len
	static Float:velocity[3]
	static Float:velocity_delta[3]
	static Float:origin[3]

	for(i=1; i<=MAX_CLIENTS; i++)
	{
		if(!is_user_connected(i)) continue

		entity_get_vector(i, EV_VEC_velocity, velocity)
		entity_get_vector(i, EV_VEC_origin, origin)

		xs_vec_sub(gLastVelocities[i], velocity, velocity_delta)
		delta_len = xs_vec_len(velocity_delta)
		
		if (floatcmp(delta_len, get_cvar_float(TEST_VELOCITY_THRESHOLD_CVAR)) >= 0)
		{
			log_message("player %d velocity changed: (%.3f,%.3f,%.3f) to (%.3f,%.3f,%.3f) [delta: %.3f (%.3f,%.3f,%.3f)] [origin: (%.3f,%.3f,%.3f)]", i, gLastVelocities[i][0], gLastVelocities[i][1], gLastVelocities[i][2], velocity[0], velocity[1], velocity[2], delta_len, velocity_delta[0], velocity_delta[1], velocity_delta[2], origin[0], origin[1], origin[2])
		}

		gLastVelocities[i] = velocity
	}
}
