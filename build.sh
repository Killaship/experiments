sudo rm boot
sudo rm mikeos.flp
if test "`whoami`" != "root" ; then
	echo "You must be logged in as root to build (for loopback mounting)"
	echo "Enter 'su' or 'sudo bash' to switch to root"
	exit
fi

git pull


bash mOSbuild.sh


qemu-system-i386 -fda mikeos.flp

