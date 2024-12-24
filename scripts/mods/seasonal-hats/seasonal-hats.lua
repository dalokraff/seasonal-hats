local mod = get_mod("seasonal-hats")

-- Your mod code goes here.
-- https://vmf-docs.verminti.de

-- festag items
local festag_items = {
    festag_hat_01 = {
        name = "festag_hat_01",
        count = 1,
        {
            unit_extension_template = "ai_helmet_unit",
            unit_name = "units/santa_hat/Hat_Fur_01",
            drop_reasons = {
                death = true
            },
            attachment_node_linking = {
                {
                    source = "j_head",
                    target = 0,
                },
            },
        }
    },
    festag_hat_02 = {
        name = "festag_hat_02",
        count = 1,
        {
            unit_extension_template = "ai_helmet_unit",
            unit_name = "units/santa_hat/Hat_Fur_02",
            drop_reasons = {
                death = true
            },
            attachment_node_linking = {
                {
                    source = "a_helmet",
                    target = 0,
                },
            },
        }
    },
    festag_hat_boss_01 = {
        name = "festag_hat_boss_01",
        count = 1,
        {
            unit_name = "units/santa_hat/Hat_Fur_boss_01",
            drop_reasons = {
                death = true
            },
            attachment_node_linking = {
                {
                    source = "j_head",
                    target = 0,
                },
            },
        }
    },
    festag_hat_boss_02 = {
        name = "festag_hat_boss_02",
        count = 1,
        {
            unit_name = "units/santa_hat/Hat_Fur_boss_02",
            drop_reasons = {
                death = true
            },
            attachment_node_linking = {
                {
                    source = "j_head",
                    target = 0,
                },
            },
        }
    }
}

local inventories_to_change = {
    empty = 'festag_hat_01',
    warpfiregun = 'festag_hat_01',
    halberd = 'festag_hat_01',
    stormvermin_sword_and_shield = 'festag_hat_01',
    skaven_clan_rat_sword_and_shield = 'festag_hat_01',
    skaven_clan_rat_sword = 'festag_hat_01',
    opt_skaven_clan_rat_sword = 'festag_hat_01',
    opt_skaven_clan_rat_spear = 'festag_hat_01',
    gutter_runner = 'festag_hat_01',
    loot_rat_sack = 'festag_hat_01',
    pack_master = 'festag_hat_01',
    dual_sword = 'festag_hat_01',
    ratlinggun = 'festag_hat_01',
    skaven_slave_sword = 'festag_hat_01',
    skaven_slave_spear = 'festag_hat_01',
    opt_skaven_slave_sword = 'festag_hat_01',
    opt_skaven_slave_spear = 'festag_hat_01',
    beastmen_gor_1h = 'festag_hat_01',
    beastmen_bestigor_2h_axe = 'festag_hat_01',
    beastmen_standard_bearer_dual_setup = 'festag_hat_01',
    beastmen_ungor_archer_bow_and_spear = 'festag_hat_01',
    beastmen_ungor_spear = 'festag_hat_01',
    berzerker_dual_axes = 'festag_hat_02',
    fanatic = 'festag_hat_02',
    raider_axe_2h = 'festag_hat_02',
    warrior_axe = 'festag_hat_02',
    warrior_axe_blk_shadow_lieutenant = 'festag_hat_02',
    chaos_bulwark = 'festag_hat_02',
    exalted_axe = 'festag_hat_02',
    marauder_sword_and_shield = 'festag_hat_02',
    marauder_mace = 'festag_hat_02',
    chaos_sorcerer_vortex = 'festag_hat_boss_02',
    chaos_sorcerer = 'festag_hat_boss_02',
    rat_ogre = 'festag_hat_boss_01',
    stormfiend_warpfire = 'festag_hat_boss_01',
    chaos_troll = 'festag_hat_boss_02',
    beastmen_minotaur_dual_axes = 'festag_hat_boss_02',
}

local old_inventory = {}

local function has_helmet_item(inventory)
    for k,item_slot in pairs(inventory.items) do
        if type(item_slot) =="table" then
            for _,item in pairs(item_slot) do
                if type(item) == "table" then
                    if item.unit_extension_template == "ai_helmet_unit" then
                        return true, k
                    end
                end
            end
        end
    end
    return false, nil
end

local function replace_inventory(inventory_name, seasonal_item)
    local inventory = InventoryConfigurations[inventory_name]
    if inventory then
        if inventory.items then
            local num_items = #inventory.items
            local has_helmet, helmet_index = has_helmet_item(inventory)
            if has_helmet then
                local helmet_item = inventory.items[helmet_index]
                -- old_inventory[inventory_name] = table.shallow_copy(helmet_item)
                inventory.items[helmet_index] = festag_items[seasonal_item]
            else
                inventory.items[num_items+1] = festag_items[seasonal_item]
                inventory.items_n = inventory.items_n + 1
            end
        elseif inventory.multiple_configurations then
            for _,new_inventroy in pairs(inventory.multiple_configurations) do
                replace_inventory(new_inventroy, seasonal_item)
            end
        end
    else
        mod:error(inventory_name)
    end
end

for inv_name, seasonal_item in pairs(inventories_to_change) do
    replace_inventory(inv_name, seasonal_item)
end
