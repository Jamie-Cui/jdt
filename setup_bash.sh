#!/bin/bash

# ------------------------------------------------------------------
# Useful information about this script
# ------------------------------------------------------------------
# VERSION=0.1.0
# SUBJECT=some-unique-id
USAGE="Usage: ./setup_bash.sh -hv args"

# ------------------------------------------------------------------
# Bash Settings
# ------------------------------------------------------------------
set -o errexit  # abort on nonzero exitstatus
set -o nounset  # abort on unbound variable
set -o pipefail # don't hide errors within pipes

# if nothing, print usage
if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

. ./shflags

DEFINE_string 'aparam' 'adefault' 'First parameter'
DEFINE_string 'bparam' 'bdefault' 'Second parameter'

# parse command line
FLAGS "$@" || exit 1
eval set -- "${FLAGS_ARGV}"

shift $(($OPTIND - 1))

param1=$1
param2=$2

# --- Locks -------------------------------------------------------
LOCK_FILE=/tmp/${SUBJECT}.lock

if [ -f "$LOCK_FILE" ]; then
echo "Script is already running"
exit
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE

# -- Body ---------------------------------------------------------
#  SCRIPT LOGIC GOES HERE
echo "Param A: $FLAGS_aparam"
echo "Param B: $FLAGS_bparam"
echo $param1
echo $param2
# -----------------------------------------------------------------
