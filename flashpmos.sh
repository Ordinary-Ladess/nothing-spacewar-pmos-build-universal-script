#!/bin/bash

#clear DTBO to avoid boot issues and wait 2 seconds for phone to write (I just sync out of habit)
echo clearing boot data partition DTBO...
fastboot erase dtbo
sync
sleep 1

echo flashing boot...
fastboot flash boot_a boot-nothing-spacewar.img
sleep 1
fastboot flash boot_b boot-nothing-spacewar.img
sync
sleep 3

echo flashing the root file system to userdata...
fastboot flash userdata rootfs-nothing-spacewar.img
sync
echo waiting 10 seconds to allow phone to finish writing:
echo  reboot in 10 seconds.....
sleep 2
echo  reboot in 8 seconds....
sleep 2
echo  reboot in 6 seconds...
sleep 2
echo  reboot in 4 seconds..
sleep 2
echo  reboot in 2 seconds.
sleep 2
echo rebooting phone...
fastboot reboot
