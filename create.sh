#!/usr/bin/env bash
if [[ $# == 0 ]]
then
	echo "Need an archive name"
	exit 1
fi

sudo rm -rf chrootdir
mkdir chrootdir
sudo tar xfJ $1 -C chrootdir

sudo cp `which qemu-aarch64-static` chrootdir/usr/bin
sudo mkdir -p chrootdir/go/src/github.com/ethereum/go-ethereum
sudo rsync -a $GOPATH/src/github.com/ethereum chrootdir/go/src/github.com/ethereum/go-ethereum

sudo chroot chrootdir qemu-aarch64-static /bin/bash
