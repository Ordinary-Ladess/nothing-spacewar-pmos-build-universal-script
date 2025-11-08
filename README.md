This git should contain an action to generate PMOS for the Nothing Phone 1

However, my focus is on making build.sh be more portable as it currently only runs on someone'sm Ubuntu install.
Debian is my first goal, at least.

How to install ?

1. Login to your github account
2. Go to Actions tab
3. Download the most recent build 
4. Extract the archive
5. Flash boot to boot partition
6. Flash rootfs to userdata partition
7. wipe dtbo with i.e. #fastboot erase dtbo 
8. Reboot

Assume all black-screen hangs and random reboots for the next 10 minutes are due to rootfs unpacking itself into the full userdata partition space.

Deleting vendor_boot hasn't been tested by myself as I haven't gone back to Blandroid

