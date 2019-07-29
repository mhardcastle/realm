# realm

Multi-user game played on various systems in the late 80s to early 90s.

Original coding by Martin Hardcastle; design by Martin Hardcastle, Tim
Hardcastle, Darrell Rowbottom and others; port to Linux by Pete Chown.

Requires a C compiler, make and p2c for Pascal to C conversion.

p2c can be found at https://github.com/FranklinChen/p2c.git

To build, install p2c and edit the first few lines of the Makefile to
point to the installation. Then run 'make build'.

Run the executable ./realm and telnet to port 2000 from a local or
remote host.

The installation will create one immortal user Coder, with password coder.
You may use this to manage the game.
