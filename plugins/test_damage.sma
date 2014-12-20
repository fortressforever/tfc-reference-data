#include <amxmodx>
#include <engine>
#include <xs>
#include <tfcconst>

#define PLUGIN "Test Damage"
#define VERSION "0.1"
#define AUTHOR "squeek."

#define MAX_CLIENTS       32

#define TEST_DAMAGE_PRINT_CVAR "test_damage_print"
#define TEST_DAMAGE_AUTOHEAL_CVAR "test_damage_autoheal"

new gLastHealth[MAX_CLIENTS + 1]
new gLastArmor[MAX_CLIENTS + 1]

static shouldprint, shouldautoheal

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)

	shouldprint = register_cvar(TEST_DAMAGE_PRINT_CVAR, "1")
	shouldautoheal = register_cvar(TEST_DAMAGE_AUTOHEAL_CVAR, "1")
}

public client_PreThink(i)
{
	new curhealth = get_user_health(i)
	new curarmor = get_user_armor(i)

	if (gLastHealth[i] > 0 && (gLastHealth[i] > curhealth || gLastArmor[i] > curarmor))
	{
		new player_name[32]
		get_user_name(i, player_name, 31)

		new damage = xs_abs((gLastHealth[i] - curhealth) + (gLastArmor[i] - curarmor))

		if (shouldprint)
		{
			client_print(0, print_chat, "%s took %d damage (last %d | %d, current: %d | %d) [%d]", player_name, damage, gLastHealth[i], gLastArmor[i], curhealth, curarmor, floatmul(Float:damage, 1.5))
		}

		static Float:origin[3]
		static Float:velocity[3]
		entity_get_vector(i, EV_VEC_origin, origin)
		entity_get_vector(i, EV_VEC_velocity, velocity)

		log_message("player %d ondamage %d [origin: (%.3f,%.3f,%.3f)] [velocity: %.3f (%.3f,%.3f,%.3f)]", i, damage, origin[0], origin[1], origin[2], xs_vec_len(velocity), velocity[0], velocity[1], velocity[2])

		if (shouldautoheal)
		{
			heal(i)

			curhealth = get_user_health(i)
			curarmor = get_user_armor(i)
		}
	}

	gLastHealth[i] = curhealth
	gLastArmor[i] = curarmor
}

public heal(id)
{
	new classint = entity_get_int(id, EV_INT_playerclass);
	if (classint == TFC_PC_ENGINEER)
	{
		entity_set_float(id, EV_FL_health, 80.0);
		entity_set_float(id, EV_FL_armorvalue, 50.0);	
	}
	else if (classint == TFC_PC_SPY)
	{
		entity_set_float(id, EV_FL_health, 90.0);
		entity_set_float(id, EV_FL_armorvalue, 100.0);	
	}
	else if (classint == TFC_PC_PYRO)
	{
		entity_set_float(id, EV_FL_health, 100.0);
		entity_set_float(id, EV_FL_armorvalue, 150.0);	
	}
	else if (classint == TFC_PC_HWGUY) 
	{
		entity_set_float(id, EV_FL_health, 100.0);
		entity_set_float(id, EV_FL_armorvalue, 300.0);
	}
	else if (classint == TFC_PC_MEDIC) 
	{
		entity_set_float(id, EV_FL_health, 90.0);
		entity_set_float(id, EV_FL_armorvalue, 100.0);	
	}
	else if (classint == TFC_PC_DEMOMAN)
	{
		entity_set_float(id, EV_FL_health, 90.0);
		entity_set_float(id, EV_FL_armorvalue, 120.0);	
	}
	else if (classint == TFC_PC_SOLDIER)
	{
		entity_set_float(id, EV_FL_health, 100.0);
		entity_set_float(id, EV_FL_armorvalue, 200.0);	
	}
	else if (classint == TFC_PC_SNIPER)
	{
		entity_set_float(id, EV_FL_health, 90.0);
		entity_set_float(id, EV_FL_armorvalue, 50.0);	
	}
	else if (classint == TFC_PC_SCOUT)
	{	
		entity_set_float(id, EV_FL_health, 75.0);
		entity_set_float(id, EV_FL_armorvalue, 50.0);	
	}
}