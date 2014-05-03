--[[
   main.lua - Pixel Art Maker Main File

   Written in 2014 by Jack Force <jack1243star@gmail.com>

   To the extent possible under law, the author(s) have dedicated all
   copyright and related and neighboring rights to this software to the
   public domain worldwide. This software is distributed without any
   warranty.

   You should have received a copy of the CC0 Public Domain Dedication
   along with this software. If not, see
   <http://creativecommons.org/publicdomain/zero/1.0/>.
]]--

-- The canvas
local canvas = {}
-- Help text
local instructions = [[
Press return key to copy to clipboard.
Type in the text you want to insert.
Press tab key to toggle between prefix and suffix.
Text macros available:
   %line%   %line-1%
]]
-- Prefix and suffix text
local text = {}
-- Current editing text
local current = "prefix"
-- Notification text
local message = ""
-- Notification timer
local messageTime = 1
-- Description for prefix text
local prefixDesc = "Prefix: (Editing)\n"
-- Description for suffix text
local suffixDesc = "Suffix:\n"

function love.load()
   -- Initialize prefix and suffix text
   text["prefix"] = ""
   text["suffix"] = ""
   -- Initialize canvas
   for i=1,256 do
      canvas[i] = 0
   end
end

function love.update(dt)
   -- Increment time of notification
   if messageTime < 1 then
      messageTime = messageTime + dt
   end
end

function love.draw()
   -- Draw canvas
   for i=1,256 do
      if canvas[i] == 1 then
         love.graphics.setColor(0, 0, 0)
      else
         love.graphics.setColor(255, 255, 255)
      end
      love.graphics.rectangle(
         "fill",
         10*math.floor((i-1)/16), 10*((i-1)%16),
         10, 10)
   end
   -- Print prefix and suffix
   love.graphics.print(
      prefixDesc..text["prefix"].."\n"..suffixDesc..text["suffix"],
      161, 0)
   -- Print the instructions
   love.graphics.print(instructions, 1, 160)
   -- Print notification
   if messageTime < 1 then
      love.graphics.setColor(255, 0, 0)
      love.graphics.rectangle("fill", 0, 0, 320, 14)
      love.graphics.setColor(255, 255, 255)
      love.graphics.print(message, 1, 0)
   end
end

function love.mousepressed(x, y, button)
   -- Check if cursor is inside the canvas
   if x < 160 and y < 160 then
      local gridX = math.floor(x/10)
      local gridY = math.floor(y/10)
      -- Calculate the tile to flip
      if canvas[gridX*16+gridY+1] == 0 then
         canvas[gridX*16+gridY+1] = 1
      else
         canvas[gridX*16+gridY+1] = 0
      end
   end
end

function love.keypressed(key)
   if key == "return" then
      -- Dump data to clipboard
      local data = ""
      for i=1,16 do
         -- Expand macro in prefix
         local prefix = string.gsub(text["prefix"], "%%line%%", i)
         prefix = string.gsub(prefix, "%%line%-1%%", i-1)
         -- Append prefix
         data = data..prefix
         -- Append data
         for j=1,16 do
            data = data..canvas[(j-1)*16+i]
         end
         -- Expand macro in suffix
         local suffix = string.gsub(text["suffix"], "%%line%%", i)
         suffix = string.gsub(suffix, "%%line%-1%%", i-1)
         -- Append suffix
         data = data..suffix
         -- Append newline
         data = data.."\r\n"
      end
      love.system.setClipboardText(data)
      -- Show notification
      message = "Data copied to clipboard!"
      messageTime = 0
   elseif key == "backspace" then
      -- Remove last character from current editing text
      text[current] = string.sub(text[current],1,-2)
   elseif key == "tab" then
      -- Toggle current editing text
      if current == "suffix" then
         current = "prefix"
         prefixDesc = "Prefix: (Editing)\n"
         suffixDesc = "Suffix:\n"
      else
         current = "suffix"
         prefixDesc = "Prefix:\n"
         suffixDesc = "Suffix: (Editing)\n"
      end
   end
end

function love.textinput(t)
   -- Append character to current editing text
   text[current] = text[current]..t
end
