#!/bin/sh
BIANA="/interactomix/bin-tools/BIANA/generate_netscore_files.py"

sg interactomix -c "PYTHONPATH=$PYTHONPATH:/interactomix/bin/BIANA python2 $BIANA \
  -iseed $1  -radius $2 -stype $3 -ttype $4 \
  -taxid $5 $6 -node $7 -edge $8 -trans $9"
