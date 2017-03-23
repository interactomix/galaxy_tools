#!/bin/sh
PERL="/usr/bin/perl"
MVORFFIP="/interactomix/bin-tools/MVORFFIP/run.pl"
LS="/bin/ls"
ECHO="/bin/echo"
CP="/bin/cp"
RM="/bin/rm"
MKTEMP="/usr/bin/mktemp"

PERL5LIB="/interactomix/bin-tools/MVORFFIP"

# Vorffip expects the file to have either no file extension, or an extension
# .pdb.  To appease it, copy the input file to a temporary location with the correct
# extension...

tmp_pdbfile="$($MKTEMP galaxy_tmpXXXXXX.pdb)"
$CP $1 $tmp_pdbfile 

cd $(dirname ${tmp_pdbfile})
run_output=$(sg interactomix -c "PERL5LIB=$PERL5LIB $PERL $MVORFFIP $(basename $tmp_pdbfile) 2> /dev/null")
if [ $? -ne 0 ]; then
	exit 1
fi

$RM $tmp_pdbfile

output_dir=$run_output

pbs_tab_result="${output_dir}/XLS/pbs_prediction.tab"
ebs_tab_result="${output_dir}/XLS/ebs_prediction.tab"
dbs_tab_result="${output_dir}/XLS/dbs_prediction.tab"
rbs_tab_result="${output_dir}/XLS/rbs_prediction.tab"

pbs_result=$(ls "${output_dir}/PDB/RESULT/*.pbs.pdb")
ebs_result=$(ls "${output_dir}/PDB/RESULT/*.ebs.pdb")
dbs_result=$(ls "${output_dir}/PDB/RESULT/*.dbs.pdb")
rbs_result=$(ls "${output_dir}/PDB/RESULT/*.rbs.pdb")

for f in $pbs_tab_result $ebs_tab_result $dbs_tab_result $rbs_tab_result $pbs_result $ebs_result $dbs_result $rbs_result; do
  if [ -f "${f}"]; then
    cp "${f}" "$2"
  else
    exit 1
  fi
done
