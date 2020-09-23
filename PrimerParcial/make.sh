#!/bin/bash
nasm -f elf32 lib32.asm
gcc -c -m32 main.c
gcc -m32 -fno-builtin lib32.o main.o -o sort