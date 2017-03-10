#!/bin/sh
# Create a temporary file
output_dir=$(sg interactomix -c "mktemp -d /interactomix/outputs-tools/BADOCK/XXXXXX")
cd "$output_dir"
sg interactomix -c "python2.7 /interactomix/bin-tools/BADock/BADock.py -a $1 -b $2 -o ./ -x xml_out 1>/dev/null 2>&1" 
if [ -f "$output_dir/xml_out.xml" ]; then
  cp "$output_dir/xml_out.xml" "$3"
else
  exit 1
fi
