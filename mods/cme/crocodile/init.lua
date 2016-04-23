--= Oerrki for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2016 BlockMen <blockmen2015@gmail.com>
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


local def = {
  name = "creatures:crocodile",
  stats = {
    hp = 25,
    lifetime = 540, -- 9 Minutes
    can_jump = 0,
    can_swim = true,
    can_burn = true,
    can_panic = false,
    has_falldamage = true,
    has_kockback = true,
    sneaky = true,
    hostile = true,
  },

  model = {
    mesh = "creatures_crocodile.x",
    textures = {"creatures_crocodile.png"},
    collisionbox = {-0.85, -0.30, -0.85, 0.85, 1.5, 0.85},
    rotation = -90.0,
    scale = {x=4, y=4},
    animations = {
      idle = {start = 0, stop = 80, speed = 15},
      walk = {start = 81, stop = 170, speed = 24},
      walk_long = {start = 81, stop = 170, speed = 24},
      attack = {start = 205, stop = 220, speed = 24},
    },
  },

  sounds = {
      on_damage = {name = "creatures_crocodile", gain = 1.0, distance = 10},
      on_death = {name = "creatures_crocodile", gain = 1.0, distance = 10},
      swim = {name = "creatures_splash", gain = 1.0, distance = 10},
      random = {
        idle = {name = "creatures_crocodile", gain = 1.0, distance = 25},
        attack = {name = "creatures_crocodile", gain = 1.0, distance = 20},
      },
  },

  modes = {
    idle = {chance = 0.59, duration = 3, update_yaw = 8},
    walk = {chance = 0.3, duration = 5.5, moving_speed = 1.5},
    walk_long = {chance = 0.11, duration = 8, moving_speed = 1.3, update_yaw = 5},

    -- special modes
    attack = {chance = 0, moving_speed = 2.9},
  },

  combat = {
    attack_damage = 8,
    attack_speed = 0.6,
    attack_radius = 3,

    search_enemy = true,
    search_timer = 1.6,
    search_radius = 15,
    search_type = "player",
  },

  spawning = {
    abm_nodes = {
      spawn_on = {"default:dirt_with_grass", "default:dirt", "default:jungle_grass", "default:water_flowing", "default:water_source", "default:papyrus"},
    },
    abm_interval = 55,
    abm_chance = 60000,
    max_number = 1,
    number = {min = 1, max = 3},
    time_range = {min = 18500, max = 5100},
    light = {min = 0, max = 8},
    height_limit = {min = -200, max = 50},

    spawn_egg = {
      description = "Crocodile Spawn-Egg",
      texture = "creatures_egg_crocodile.png",
    },

    spawner = {
      description = "Crocodile Spawner",
      range = 8,
      player_range = 20,
      number = 6,
      light = {min = 0, max = 8},
    }
  },
}

creatures.register_mob(def)
