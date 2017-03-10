#!/bin/sh
# Create a temporary file
output_dir=$(mkdemp -d /interactomix/output-tools/BADOCK/XXXXXX)
cd "$output_dir"
python2.7 /interactomix/bin/BADock/BADock.py -a $1 -b $2 -o ./ -x xml_out 
if [ -f "$output_dir/xml_out.xml" ]; then
  cp "$output_dir/xml_out.xml" "$3"
else
  exit 1
fi
