Build PostMarketOS for NothingPhomne 1 SpaceWar <br>

Builds images on:<br>
Debian Trixie<br>
(Rest to be tested)<br><br>

On debian Trixie, the following need installing at least (I might of missed something, will suss that on a VM later):<br>
sudo apt-get install flex bison kpartx git<br>
and at least a GCC, presumably the latest.<br>#
<br>
How to use (Debian Trixie):<br>
1 - Download this GitHub repo as a zip,<br>
2 - extract contents of zip into it's own folder<br>
3 - open a terminal in that folder and make build.sh executable; chmod +x build.sh<br>
4 - run the script: ./build.sh<br>
5 - if all goes well, you should have the boot and root-fs images.<br>
6 - cd into the 'out' folder<br>
7 - Plug in phone entered into FastBoot mode,<br>
8 - in the terminal run: ./flashpmos.sh<br>
<br>
The flashpmos.sh will do all the intermediate stages so you're not interrupted if you want to do other things whilst waiting.<br>
<br>
For pre-built images, visit the original project this is forked from but use my ./flashpmos.sh in<br>
the same folder as the images to flash the phone with.<br>

CoC:<br>
No ai!<br>
Yes I use dashes as seperators in bullet points and numbering, I'll not accuse others of Ai-ing for doing the same.
