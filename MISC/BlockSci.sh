sudo apt-get update
sudo apt install build-essential cmake libssl-dev libboost-all-dev libsqlite3-dev autogen \
autoconf libleveldb-dev libcurl4-openssl-dev libjsoncpp-dev libjsonrpccpp-dev libjsonrpccpp-tools \
python3-dev python3-pip
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update
sudo apt install gcc-6 g++-6
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6

git clone https://github.com/bitcoin-core/secp256k1
cd secp256k1
./autogen.sh
./configure --enable-module-recovery
make
sudo make install

git clone https://github.com/citp/BlockSci.git
cd BlockSci
git submodule init --recursive update

cd libs/bitcoin-cpp-api
mkdir release
cd release
cmake --DCMAKE_BUILD_TYPE=Release ..
make
sudo make install

cd ../../..
mkdir release
cd release
cmake --DCMAKE_BUILD_TYPE=Release ..
make
sudo make install

sudo -H pip3 install --upgrade pip
sudo -H pip3 install --upgrade multiprocess psutil jupyter pycrypto matplotlib pandas dateparser
