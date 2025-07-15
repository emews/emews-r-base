#!/bin/sh

# DEACTIVATE SH
# See activate.sh

if [ ${CONDA_VERBOSITY:-0} > 0 ]
then
  echo "emews-r deactivate.sh: unsetting R_LIBS_USER"
fi

if [[ ! -z ${R_LIBS_USER_BACKUP+x} ]]; then
  export R_LIBS_USER="$R_LIBS_USER_BACKUP"
  unset R_LIBS_USER_BACKUP
else
  unset R_LIBS_USER
fi
