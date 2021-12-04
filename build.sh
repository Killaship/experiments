git pull
nasm -fbin src/boot.asm -o boot
qemu-system-i386 -fda boot 
