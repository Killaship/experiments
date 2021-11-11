if test "`whoami`" != "root" ; then
	echo "You must be logged in as root to build (for loopback mounting)"
	echo "Enter 'su' or 'sudo bash' to switch to root"
	exit
fi

git pull
nasm -fbin src/boot.asm -o boot
qemu-system-i386 -fda boot
bash mOSbuild.sh
