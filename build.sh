#!/bin/bash

nasm Inori.asm -o Inori.fdd

for ((i=1; i<4; i++)); do
    nasm test$i.asm -o test$i.com
    dd bs=512 if=test$i.com of=Inori.fdd seek=$i
done


