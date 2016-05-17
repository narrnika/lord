local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_craftitem("lottfarming:red_mushroom_spore", {
	description = SL("Red Mushroom Spores"),
	inventory_image = "lottfarming_red_mushroom_spore.png",
	on_place = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_spore(itemstack, placer, pointed_thing, "lottfarming:red_mushroom_1")
	end,
})

minetest.register_node("lottfarming:red_mushroom", {
	description = SL("Red Mushroom"),
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_red_mushroom_4.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, mushroom=1, flower=1, color_red=1},
	sounds = default.node_sound_leaves_defaults(),
	inventory_image = "lottfarming_red_mushroom.png",
	on_use = minetest.item_eat(2),
})
minetest.register_node("lottfarming:red_mushroom_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_red_mushroom_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:red_mushroom_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_red_mushroom_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:red_mushroom_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_red_mushroom_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:red_mushroom_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_red_mushroom_4.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:red_mushroom'} },
			{ items = {'lottfarming:red_mushroom'}, rarity = 2},
			{ items = {'lottfarming:red_mushroom'}, rarity = 5},
			{ items = {'lottfarming:red_mushroom_spore'} },
			{ items = {'lottfarming:red_mushroom_spore'}, rarity = 2},
			{ items = {'lottfarming:red_mushroom_spore'}, rarity = 5},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

local chance = 10
local interval = 30

minetest.register_abm({
	nodenames = "lottfarming:red_mushroom_1",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "lottfarming:decay_tree" then
			return
		end
		pos.y = pos.y+1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 8 then
			return
		end
		minetest.set_node(pos, {name='lottfarming:red_mushroom_2'})
	end
})
minetest.register_abm({
	nodenames = "lottfarming:red_mushroom_2",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "lottfarming:decay_tree" then
			return
		end
		pos.y = pos.y+1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 8 then
			return
		end
		minetest.set_node(pos, {name='lottfarming:red_mushroom_3'})
	end
})
minetest.register_abm({
	nodenames = "lottfarming:red_mushroom_3",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "lottfarming:decay_tree" and minetest.get_node(pos).name ~= "default:tree" then
			return
		end
		pos.y = pos.y+1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 8 then
			return
		end
		minetest.set_node(pos, {name='lottfarming:red_mushroom_4'})
	end
})

num = PseudoRandom(111)

minetest.register_abm({
	nodenames = "lottfarming:red_mushroom_3",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.x = pos.x-1
		local x = num:next(1, 3)
		if x > 1 then
			pos.x = pos.x+1
			if x > 2 then
				pos.x = pos.x+1
			end
		end
		pos.z=pos.z-1
		local z = num:next(1, 3)
		if z > 1 then
			pos.z = pos.z+1
			if z > 2 then
				pos.z = pos.z+1
			end
		end
		local name = ""
		if minetest.get_node(pos).name=="air" then
			pos.y = pos.y-1
			name = minetest.get_node(pos).name
			if name=="default:tree" then
				pos.y=pos.y+1
				minetest.set_node(pos, {name='lottfarming:red_mushroom_3'})
			end
			if name=="air" then
				pos.y=pos.y-1
				name = minetest.get_node(pos).name
				if name=="default:tree" then
					pos.y=pos.y+1
					minetest.set_node(pos, {name='lottfarming:red_mushroom_3'})
				end
			end
		end
		pos.y=pos.y+1
		if minetest.get_node(pos).name=="air" then
			pos.y = pos.y-1
			name = minetest.get_node(pos).name
			if name=="default:tree" then
				pos.y=pos.y+1
				minetest.set_node(pos, {name='lottfarming:red_mushroom_3'})
			end
		end
	end
})
