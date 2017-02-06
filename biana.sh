#!/bin/sh
BIANA="/interactomix/bin-tools/BIANA/run.pl"

sg interactomix -c "$BIANA -iseed $1  -radius $2 -stype $3 -ttype $4 \
  -taxid $5 $6 -node $7 -edge $8 -trans $9"
