#!/bin/bash -e

gcc -nostdlib quine.S -o quine
objdump -M intel -d quine
echo
echo "Code hexdump:"
objcopy -O binary --only-section=.text quine >(xxd)
echo
echo "Output hexdump:"
./quine | xxd
echo

# Extras
# Dump bytecode after push in 4-byte little-endian words
#   objcopy -O binary --only-section=.text quine >(xxd -g 4 -e)