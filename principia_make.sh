./autogen.sh
./configure \
    CC=clang \
    CXX=clang++ \
    CFLAGS="${C_FLAGS?}" \
    CXXFLAGS="${CXX_FLAGS?}" \
    LDFLAGS="${LD_FLAGS?}" \
    LIBS="-lc++ -lc++abi"
make -j8
