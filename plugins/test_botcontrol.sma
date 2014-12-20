#include <amxmodx>
#include <engine>

#define PLUGIN "Test Bot Control"
#define VERSION "0.1"
#define AUTHOR "squeek."

#define TEST_BOT_DONTMOVE_CVAR "test_bot_dontmove"

static dontmove

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)

	dontmove = register_cvar(TEST_BOT_DONTMOVE_CVAR, "1")
}

public client_PreThink(id)
{
	if (!is_user_bot(id))
		return

	if (dontmove != 0)
	{
		static Float:zero_velocity[3] = {0.0}
		entity_set_vector(id, EV_VEC_velocity, zero_velocity)
	}
}

public client_PostThink(id)
{
	if (!is_user_bot(id))
		return

	if (dontmove != 0)
	{
		static Float:old_origin[3]
		entity_get_vector(id, EV_VEC_oldorigin, old_origin)
		entity_set_vector(id, EV_VEC_origin, old_origin)
	}
}