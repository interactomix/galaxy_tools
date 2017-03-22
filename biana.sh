#!/bin/sh
BIANA="/interactomix/bin-tools/BIANA/generate_netscore_files.py"

sg interactomix -c "PYTHONPATH=$PYTHONPATH:/usr/lib/python2.7/site-packages:/interactomix/bin/BIANA python2 $BIANA \
  -iseed $1  -radius $2 -stype $3 -ttype $4 \
  -taxid $5 -node $6 -edge $7 -trans $8 $9"
