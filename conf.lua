--[[
   conf.lua - Pixel Art Maker Config File

   Written in 2014 by Jack Force <jack1243star@gmail.com>

   To the extent possible under law, the author(s) have dedicated all
   copyright and related and neighboring rights to this software to the
   public domain worldwide. This software is distributed without any
   warranty.

   You should have received a copy of the CC0 Public Domain Dedication
   along with this software. If not, see
   <http://creativecommons.org/publicdomain/zero/1.0/>.
]]--

function love.conf(t)
   t.window.title = "Pixel Art Maker"
   t.window.width = 320;
   t.window.height = 240;

   t.modules.audio = false
   t.modules.event = true
   t.modules.graphics = true
   t.modules.image = false
   t.modules.joystick = false
   t.modules.keyboard = true
   t.modules.math = false
   t.modules.mouse = true
   t.modules.physics = false
   t.modules.sound = false
   t.modules.system = true
   t.modules.timer = true
   t.modules.window = true
end
