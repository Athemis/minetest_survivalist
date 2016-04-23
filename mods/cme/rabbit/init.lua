--= Rabbit for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 Athemis <alexander.minges@gmail.com>
--
-- init.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--

local normal = {
	name = "creatures:rabbit",
	stats = {
		hp = 8,
		lifetime = 450, -- 7,5 Minutes
		can_jump = 1,
		can_swim = true,
		can_burn = true,
		can_panic = true,
		has_falldamage = true,
		has_kockback = true,
	},

	model = {
		mesh = "creatures_rabbit.b3d",
		textures = {"creatures_rabbit_white.png"},
		collisionbox = {-0.268, -0.5, -0.268, 0.268, 0.167, 0.268},
		rotation = -90.0,
		animations = {
			idle = {start = 1, stop = 15, speed = 15},
			walk = {start = 16, stop = 24, speed = 18},
			walk_long = {start = 16, stop = 24, speed = 18},
		},
	},

	sounds = {
		on_damage = {name = "creatures_rabbit", gain = 1.0, distance = 10},
		on_death = {name = "creatures_rabbit", gain = 1.0, distance = 10},
		swim = {name = "creatures_splash", gain = 1.0, distance = 10,},
		random = {
			idle = {name = "creatures_rabbit", gain = 0.6, distance = 10, time_min = 23},
		},
	},

	modes = {
		idle = {chance = 0.5, duration = 10, update_yaw = 8},
		walk = {chance = 0.14, duration = 4.5, moving_speed = 1.3},
		walk_long = {chance = 0.11, duration = 8, moving_speed = 1.3, update_yaw = 5},
                attack = {chance = 0, moving_speed = 2.5},
		-- special modes
		follow = {chance = 0, duration = 20, radius = 4, timer = 5, moving_speed = 1, items = {"farming:carrot"}},
	},

	drops = function(self)
		local items = {{"creatures:flesh"}}
		creatures.dropItems(self.object:getpos(), items)
	end,

	spawning = {
		abm_nodes = {
			spawn_on = {"default:dirt_with_grass"},
		},
		abm_interval = 55,
		abm_chance = 6000,
		max_number = 3,
		number = {min = 1, max = 10},
		time_range = {min = 5100, max = 18300},
		light = {min = 10, max = 15},
		height_limit = {min = 0, max = 25},

		spawn_egg = {
			description = "Rabbit Spawn-Egg",
			texture = "creatures_egg_rabbit.png",
		},

		spawner = {
			description = "Rabbit Spawner",
			range = 8,
			player_range = 20,
			number = 6,
		}
	},

	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
			if item then
				local name = item:get_name()
				if name == "farming:carrot" then
					self.target = clicker
					self.mode = "follow"
					self.modetimer = 0

					if not self.tamed then
						self.fed_cnt = (self.fed_cnt or 0) + 1
					end

					-- play eat sound?
					item:take_item()
				end
				if not core.setting_getbool("creative_mode") then
					clicker:set_wielded_item(item)
				end
			end
		return true
	end,

	on_step = function(self, dtime)
		if self.fed_cnt and self.fed_cnt > 4 then
			self.tamed = true
			self.fed_cnt = nil
		end
	end,

        on_activate = function(self)
                if self and self.object then
                        local color = creatures.rnd({
                            white = {chance = 0.3}, -- 30 % chance of brown rabbits
                            brown = {chance = 0.7}, -- 70 % chance of white rabbit
                        })
                        self.object:set_properties({textures = {"creatures_rabbit_" .. color .. ".png"}})
                end
        end
}



local evil = {
	name = "creatures:rabbit_evil",
	stats = {
		hp = 100,
		lifetime = 450, -- 7,5 Minutes
		can_jump = 1,
		can_swim = true,
		can_burn = true,
		has_falldamage = true,
		has_kockback = true,
                hostile = true,
	},

	modes = {
		idle = {chance = 0.5, duration = 10, update_yaw = 8},
		walk = {chance = 0.14, duration = 4.5, moving_speed = 1.3},
		walk_long = {chance = 0.11, duration = 8, moving_speed = 1.3, update_yaw = 5},
                -- special modes
                attack = {chance = 0, moving_speed = 2.5},
        },

	model = {
		mesh = "creatures_rabbit.b3d",
		textures = {"creatures_rabbit_evil.png"},
		collisionbox = {-0.268, -0.5, -0.268, 0.268, 0.167, 0.268},
		rotation = -90.0,
		animations = {
			idle = {start = 1, stop = 15, speed = 15},
			walk = {start = 16, stop = 24, speed = 18},
			walk_long = {start = 16, stop = 24, speed = 18},
                        attack = {start = 16, stop = 24, speed = 25},
		},
	},

	sounds = {
		on_damage = {name = "creatures_rabbit", gain = 1.0, distance = 10},
		on_death = {name = "creatures_rabbit", gain = 1.0, distance = 10},
		swim = {name = "creatures_splash", gain = 1.0, distance = 10,},
		random = {
			idle = {name = "creatures_rabbit", gain = 0.6, distance = 10, time_min = 23},
		},
	},

        combat = {
            attack_damage = 10,
            attack_speed = 0.6,
            attack_radius = 1.2,

            search_enemy = true,
            search_timer = 2,
            search_radius = 12,
            search_type = "player",
        },

	drops = function(self)
		local items = {{"creatures:flesh"}}
		creatures.dropItems(self.object:getpos(), items)
	end,

	spawning = {
		abm_nodes = {
			spawn_on = {"default:dirt_with_grass"},
		},
		abm_interval = 300,
		abm_chance = 100000,
		max_number = 1,
		number = {min = 1, max = 1},
		time_range = {min = 5100, max = 18300},
		light = {min = 10, max = 15},
		height_limit = {min = 0, max = 25},

		spawn_egg = {
			description = "Evil Rabbit Spawn-Egg",
			texture = "creatures_egg_rabbit.png",
		},

		spawner = {
			description = "Evil Rabbit Spawner",
			range = 8,
			player_range = 20,
			number = 6,
		}
	},

	on_rightclick = function(self, clicker)
		return true
	end
}

creatures.register_mob(normal)
creatures.register_mob(evil)
