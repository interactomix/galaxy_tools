#!/bin/sh
PCRPI="/interactomix/bin-tools/PCRPI/run.pl"
ECHO="/bin/echo"
GREP="/bin/grep"
SED="/bin/sed"
WATCH="/bin/watch"
CP="/bin/cp"

run_output=$(sg interactomix -c "$PCRPI $1 $2 $3 $4")
if [ $? -ne 0 ]; then
	exit 1
fi

output_dir=$($ECHO "${run_output}" | $GREP "Output dir" | $SED "s/^Output\ dir\ \.\.\.\ //")

$WATCH -g $GREP "'Finish submission at'" "${output_dir}/run.sge.log" 1>/dev/null

for f in "run.sge.log" "input.org.pdb" "input.clean.pdb" "b_factors.pdb" \
	"results.txt" "contacts.csu.txt"; do
	if [ ! -e ${output_dir}/$f ]; then
		exit 1
	fi
done

$CP ${output_dir}/results.txt $5
$CP ${output_dir}/b_factors.pdb $6
