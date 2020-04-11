pushd src
cmake \
    -DCMAKE_C_COMPILER:FILEPATH="$(which clang)" \
    -DCMAKE_CXX_COMPILER:FILEPATH="$(which clang++)" \
    -DCMAKE_C_FLAGS="${C_FLAGS?}" \
    -DCMAKE_CXX_FLAGS="${CXX_FLAGS?}" \
    -DWITH_GFLAGS=OFF \
    -DBUILD_SHARED_LIBRARIES=OFF \
    -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY:FILEPATH=../.libs \
    ..
make -j8
popd
