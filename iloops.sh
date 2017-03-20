#!/bin/sh
PYTHON="/interactomix/bin-tools/iLoops/venv/bin/python"
ILOOPS="/interactomix/bin-tools/iLoops/iLoops.py"
# Create a temporary file
output_dir=$(sg interactomix -c "mktemp -d /interactomix/outputs-tools/ILOOPS/XXXXXX")
cd "$output_dir"
sg interactomix -c "$PYTHON $ILOOPS -f $1 -q $2 -j $output_dir -g $3 -d $4 -b -c $5 -x out.xml" 
if [ -f "$output_dir/out.xml" ]; then
  cp "$output_dir/out.xml" "$6"
else
  exit 1
fi
