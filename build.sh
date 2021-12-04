git pull
nasm -fbin src/boot.asm -o boot
nasm -fbin src/kernel.asm -o kernel
cat boot.asm kernel.asm > myos
qemu-system-i386 -fda myos 
