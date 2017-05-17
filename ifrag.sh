#!/bin/sh
PERL="/usr/bin/perl"
LS="/bin/ls"
ECHO="/bin/echo"
CP="/bin/cp"
RM="/bin/rm"
MKTEMP="/usr/bin/mktemp"
IFRAG="/interactomix/bin-tools/IFRAGS/run_ifrags.pl"

cd /interactomix/bin-tools/IFRAGS
run_output=$(sg interactomix -c "$PERL $IFRAG $1 $2 $3 $4 $5 $6")

if [ $? -ne 0 ]; then
	exit 1
fi

output_dir=$(echo $run_output | sed 's/Output\ dir:\ //g')

code=$(awk '{print $3}' "$output_dir/codes_ifraq.txt")

out1="$output_dir/$code/interactionID.output"
out2="$output_dir/$code/$code.output"

for f in $out1 $out2; do
  if [ ! -f $f]; then
    exit 1;
  fi
done

cp "$out1" "$7"
cp "$out2" "$8"
