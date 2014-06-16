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

-- Help text
local instructions = [[
Press return key to copy to clipboard.
Type in the text you want to insert.
Press tab key to toggle between prefix and suffix.
Press right control key to toggle between 16x16 and 64x64 mode.

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

-- Canvas 1
local canvas1 = {}
-- Canvas 1 width
canvas1.width = 16
-- Canvas 1 height
canvas1.height = 16
-- Actual canvas
canvas1.canvas = {}

-- Canvas 2
local canvas2 = {}
-- Canvas 2 width
canvas2.width = 64
-- Canvas 2 height
canvas2.height = 64
-- Actual canvas
canvas2.canvas = {}

-- Current Canvas
local currentCanvas = canvas1
-- Canvas scale
local CanvasScale = 10

function love.load()
   -- Initialize prefix and suffix text
   text["prefix"] = ""
   text["suffix"] = ""
   -- Initialize canvas
   for i=1,canvas1.height do
      canvas1.canvas[i] = {}
      for j=1,canvas1.width do
         canvas1.canvas[i][j] = 0
      end
   end
   for i=1,canvas2.height do
      canvas2.canvas[i] = {}
      for j=1,canvas2.width do
         canvas2.canvas[i][j] = 0
      end
   end
end

function love.update(dt)
   -- Increment time of notification
   if messageTime < 1 then
      messageTime = messageTime + dt
   end
   -- Draw while mouse down
   x, y = love.mouse.getPosition()
   if x < CanvasScale*currentCanvas.width and y < CanvasScale*currentCanvas.height then
      local gridX = math.floor(x/CanvasScale) + 1
      local gridY = math.floor(y/CanvasScale) + 1
      if currentMode == "draw" then
         currentCanvas.canvas[gridY][gridX] = 1
      elseif currentMode == "erase" then
         currentCanvas.canvas[gridY][gridX] = 0
      end
   end
end

function love.draw()
   -- Draw canvas
   for i=1,currentCanvas.height do
      for j=1,currentCanvas.width do
         if currentCanvas.canvas[i][j] == 1 then
            love.graphics.setColor(0, 0, 0)
         else
            love.graphics.setColor(255, 255, 255)
         end
         love.graphics.rectangle(
            "fill",
            CanvasScale*(j-1), CanvasScale*(i-1),
            CanvasScale, CanvasScale)
      end
   end

   -- Print prefix and suffix
   love.graphics.print(
      prefixDesc..text["prefix"].."\n"..suffixDesc..text["suffix"],
      CanvasScale*currentCanvas.width+1, 0)
   -- Print the instructions
   love.graphics.print(instructions, 1, CanvasScale*currentCanvas.height)
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
   if x < CanvasScale*currentCanvas.width and y < CanvasScale*currentCanvas.height then
      local gridX = math.floor(x/CanvasScale) + 1
      local gridY = math.floor(y/CanvasScale) + 1
      -- Calculate the tile to flip
      if currentCanvas.canvas[gridY][gridX] == 0 then
         currentMode = "draw"
         currentCanvas.canvas[gridY][gridX] = 1
      else
         currentMode = "erase"
         currentCanvas.canvas[gridY][gridX] = 0
      end
   end
end

function love.mousereleased(x, y, button)
   -- End a stroke
   currentMode = nil
end

function love.keypressed(key)
   if key == "return" then
      -- Dump data to clipboard
      local data = ""
      for i=1,currentCanvas.height do
         -- Expand macro in prefix
         local prefix = string.gsub(text["prefix"], "%%line%%", i)
         prefix = string.gsub(prefix, "%%line%-1%%", i-1)
         -- Append prefix
         data = data..prefix
         -- Append data
         for j=1,currentCanvas.width do
            data = data..currentCanvas.canvas[i][j]
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
   elseif key == "rctrl" or key == "lctrl" then
      -- Toggle current Canvas
      if currentCanvas == canvas1 then
         currentCanvas = canvas2
         love.window.setMode(960,640)
      else
         currentCanvas = canvas1
         love.window.setMode(480,320)
      end
   end
end

function love.textinput(t)
   -- Append character to current editing text
   text[current] = text[current]..t
end
