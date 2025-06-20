Some exploits need to be compiled with the same version of gcc as the target to run. 

## Usual solution is to compile the c file on the machine using THAT compiler, but in the event that can't be done...

Here's how to install them on Kali:

Review the gcc versions here: https://gcc.gnu.org/releases.html

Download the gcc version from here (UK mirrors): https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/

Create directory:
```
mkdir /opt/gcc-x # replace x with version
```
Move the downloaded gcc version to the folder and extract:
```
tar -xvf gcc-x.x.tar.gz
```
```
cd gcc-x.x
```
Configure make file:
```
./configure --prefix=/opt/gcc-x --enable-languages=c,c++ --disable-multilib
```
Create file:
```
make
```
```
sudo make install
```
Confirm it works:
```
/opt/gcc-x/bin/gcc --version
```
Link it:
```
sudo ln -s /opt/gcc-x/bin/gcc /usr/local/bin/gcc-x
```
Confirm the link works:
```
gcc-x --version
```
