Pixel Art Maker
===============

Pixel Art Maker is a simple pixel art editor which outputs the
binary representation of the canvas to clipboard.

Pixel Art Maker is developed using the [LÖVE framework]
(http://love2d.org/).

Features
--------

- Minimalist GUI
- Insert text before and after data with line number

Showcase
----------

Screenshot:

![Pixel Art Maker Screenshot]
(http://m101.nthu.edu.tw/~s101062116/PixelArtMaker/v1.0/screenshot.png)

Output:

    graph[0] = 256'b0000000000000000;
    graph[1] = 256'b0000110000000000;
    graph[2] = 256'b0001111000000000;
    graph[3] = 256'b0000110000000000;
    graph[4] = 256'b0000011000000000;
    graph[5] = 256'b0000011110000000;
    graph[6] = 256'b0000011101000000;
    graph[7] = 256'b0000101100100000;
    graph[8] = 256'b0001001100100000;
    graph[9] = 256'b0000001110000000;
    graph[10] = 256'b0000001010000000;
    graph[11] = 256'b0000010001110000;
    graph[12] = 256'b0000010000001000;
    graph[13] = 256'b0000010000010000;
    graph[14] = 256'b0001100000000000;
    graph[15] = 256'b0000000000000000;

Installation
------------

###Windows

Download the [binary]
(http://m101.nthu.edu.tw/~s101062116/PixelArtMaker/PixelArtMaker.zip),
extract and execute `PixelArtMaker.exe`.

###OSX and other UNIX-like systems

Download [`PixelArtMaker.love`]
(http://m101.nthu.edu.tw/~s101062116/PixelArtMaker/PixelArtMaker.love)
and follow the instructions at [LÖVE's Wiki]
(https://www.love2d.org/wiki/Game_Distribution).

How to Use
----------

- Click on the canvas to add or remove pixels.
- Type in text to add prefix or suffix to the output.
- Press `tab` key to switch between editing prefix or suffix.
- Macros listed on screen will be expanded in the output.
- Press `enter` or `return` key to copy output to clipboard.
- Press `control` key to toggle between 16x16 and 64x64 mode.

Support
-------

If you have any issues or suggestions, please take a look at our
[issue tracker]
(https://github.com/jack1243star/pixel-art-maker/issues).

License
-------

The project is licensed under the [CC0 1.0 Universal]
(https://creativecommons.org/publicdomain/zero/1.0/)
license.
