return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`seasonal-hats` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("seasonal-hats", {
			mod_script       = "scripts/mods/seasonal-hats/seasonal-hats",
			mod_data         = "scripts/mods/seasonal-hats/seasonal-hats_data",
			mod_localization = "scripts/mods/seasonal-hats/seasonal-hats_localization",
		})
	end,
	packages = {
		"resource_packages/seasonal-hats/seasonal-hats",
	},
}
