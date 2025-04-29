
# SETUP COMPILERS
# source this to set up compilers
# Used by build.sh
# Can also be used interactively

export CC=$(  which clang    )
export CXX=$( which clang++  )
export FC=$(  which gfortran )
# For clang-15
export CPP=$( which clang-cpp )
export CXXCPP=$CPP

export FC=$CONDA_PREFIX/bin/gfortran
export CPPFLAGS="-I$CONDA_PREFIX/include -I$CONDA_PREFIX/include/readline"
# export CFLAGS="-Wno-nullability-completeness"
export CFLAGS="$CPPFLAGS"
export LDFLAGS="-L$CONDA_PREFIX/lib -Wl,-rpath,$CONDA_PREFIX/lib"
# Possible fix for linking issue:  Need RPATH in libR.so !
export SHLIB_LDFLAGS="-L$CONDA_PREFIX/lib -Wl,-rpath,$CONDA_PREFIX/lib"

echo
echo "COMPILERS:"
show CC CXX FC CPP
echo
echo "COMPILER SETTINGS:"
show CPPFLAGS CFLAGS LDFLAGS SHLIB_LDFLAGS
echo

echo "CC version"
$CC --version
echo "CXX version"
$CXX --version
echo "CPP version"
$CPP --version
