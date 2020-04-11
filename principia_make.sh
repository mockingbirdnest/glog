mkdir -p build
pushd build
cmake \
    -DCMAKE_C_COMPILER:FILEPATH="$(which clang)" \
    -DCMAKE_CXX_COMPILER:FILEPATH="$(which clang++)" \
    -DCMAKE_C_FLAGS="${C_FLAGS}" \
    -DCMAKE_CXX_FLAGS="${CXX_FLAGS}" \
    -DWITH_GFLAGS=OFF \
    -DBUILD_SHARED_LIBRARIES=OFF \
    ..
make -j8
popd
