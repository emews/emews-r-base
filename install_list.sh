#!/bin/bash
set -eu
set -o pipefail

# INSTALL APPS

# This passes all non-flag arguments to the R script
# pass CONFIRM=0 via command line for by passing options,
#      default is CONFIRM=1
: ${CONFIRM:=1}

while getopts ":y" OPTION
do
  case $OPTION in
    y) CONFIRM=0 ;;
    -) break     ;;
    *) # The shell error message was disabled above
       echo "install_list.sh: unknown option: $*"
       exit 1
       ;;
  esac
done
shift $(( OPTIND - 1 ))
if (( ${#} == 0 ))
then
  echo "install_list.sh: provide a list of packages!"
  exit 1
fi

echo "This will install multiple R packages."
echo

if ! command which R > /dev/null
then
  echo "No R found!"
  exit 1
fi

echo "variables:"
set +u  # These variables may be unset
for var in CC CPP CXX FC
do
  printf "using %-3s = %s\n" $var ${!var}
done
echo
set -u

# On Mac, these should be clang, clang++, gfortran,
#         from the Anaconda installation!
: ${CC:=gcc} ${CPP:=g++} ${CXX:=g++} ${FC:=gfortran}

echo "tools:"
for tool in $CC $CPP $CXX $FC R
do
  if which $tool 2>&1 > /dev/null
  then
    printf "using %-15s %s\n" "${tool}:" $( which $tool )
  else
    echo "not found: $tool"
  fi
done
R --version | head -1
echo

if (( ${CONFIRM:-0} == 1 ))
then
  sleep 1
  echo "Press enter to confirm, or Ctrl-C to cancel."
  read _
fi

THIS=$( dirname $0 )

# Do it!
nice Rscript $THIS/install_list.R ${*} 2>&1 | tee install-apps.log
