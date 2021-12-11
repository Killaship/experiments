git pull
gcc -c -g -Os -m32 -ffreestanding -Wall -Werror src/boot.c -o test.o
ld -melf_i386 -static -Ttest.ld -nostdlib --nmagic -o test.elf test.o
objcopy -O binary test.elf test.bin
dd if=/dev/zero of=floppy.img bs=512 count=2880
dd if=test.bin of=floppy.img
qemu-system-i386 -fda floppy.img
