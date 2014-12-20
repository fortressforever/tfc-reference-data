#include <amxmodx>
#include <engine>
#include <tfcx>

#define PLUGIN "Test Restock"
#define VERSION "0.1"
#define AUTHOR "squeek."

#define TEST_RESTOCK_NADES_CVAR "test_restock_nades"
#define TEST_RESTOCK_AMMO_CVAR "test_restock_ammo"
#define TEST_RESTOCK_CLIPS_CVAR "test_restock_clips"

static restocknades, restockammo, restockclips

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)

	restocknades = register_cvar(TEST_RESTOCK_NADES_CVAR, "1")
	restockammo = register_cvar(TEST_RESTOCK_AMMO_CVAR, "1")
	restockclips = register_cvar(TEST_RESTOCK_CLIPS_CVAR, "1")
}

public client_PreThink(id)
{
	if (!is_user_alive(id))
		return

	if (restocknades)
	{
		tfc_setbammo(id, TFC_AMMO_NADE1, 4);
		tfc_setbammo(id, TFC_AMMO_NADE2, 4);
	}

	if (restockammo)
	{
		tfc_setbammo(id, TFC_AMMO_CELLS, 400); 
		tfc_setbammo(id, TFC_AMMO_SHELLS, 400);
		tfc_setbammo(id, TFC_AMMO_ROCKETS, 400);
		tfc_setbammo(id, TFC_AMMO_BULLETS, 400);
	}

	if (restockclips)
	{
		new wpnent1 = find_ent_by_owner(-1, "tf_weapon_rpg", id);
		if (wpnent1 > 0)
			tfc_setweaponammo(wpnent1, 4);
		new wpnent2 = find_ent_by_owner(-1, "tf_weapon_supershotgun", id);
		if (wpnent2 > 0)
			tfc_setweaponammo(wpnent2, 16);
		new wpnent3 = find_ent_by_owner(-1, "tf_weapon_gl", id);
		if (wpnent3 > 0)
			tfc_setweaponammo(wpnent3, 6);
		new wpnent4 = find_ent_by_owner(-1, "tf_weapon_pl", id);
		if (wpnent4 > 0)
			tfc_setweaponammo(wpnent4, 6);
		tfc_setweaponbammo(id, TFC_WPN_AC, 20);			
		tfc_setweaponbammo(id, TFC_WPN_AUTORIFLE, 20);
	}
}