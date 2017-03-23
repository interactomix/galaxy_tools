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
echo $run_output
if [ $? -ne 0 ]; then
	exit 1
fi

$RM $tmp_pdbfile

output_dir=$run_output

pbs_tab_result="${output_dir}/XLS/pbs_prediction.tab"
ebs_tab_result="${output_dir}/XLS/ebs_prediction.tab"
dbs_tab_result="${output_dir}/XLS/dbs_prediction.tab"
rbs_tab_result="${output_dir}/XLS/rbs_prediction.tab"

pbs_result=$(ls "${output_dir}"/PDB/RESULT/*_pbs.pdb)
ebs_result=$(ls "${output_dir}"/PDB/RESULT/*_ebs.pdb)
dbs_result=$(ls "${output_dir}"/PDB/RESULT/*_dbs.pdb)
rbs_result=$(ls "${output_dir}"/PDB/RESULT/*_rbs.pdb)

for f in $pbs_tab_result $ebs_tab_result $dbs_tab_result $rbs_tab_result $pbs_result $ebs_result $dbs_result $rbs_result; do
  if [ -f "${f}" ]; then
    true
  else
    exit 1
  fi
done

$CP $pbs_tab_result $2
$CP $ebs_tab_result $3
$CP $dbs_tab_result $4
$CP $rbs_tab_result $5

$CP $pbs_result $6
$CP $ebs_result $7
$CP $dbs_result $8
$CP $rbs_result $9
