set -e

sudo apt install cppcheck

if [ ! -d build ] ; then
	mkdir build
fi

cmake -B build . 
cmake --build build -v

./build/my_executable
