#!/bin/sh
PERL="/usr/bin/perl"
VORFFIP="/interactomix/bin-tools/VORFFIP/run.pl"
LS="/bin/ls"
ECHO="/bin/echo"
CP="/bin/cp"
RM="/bin/rm"
MKTEMP="/usr/bin/mktemp"

PERL5LIB="/interactomix/bin-tools/VORFFIP"

# Vorffip expects the file to have either no file extension, or an extension
# .pdb.  To appease it, copy the input file to a temporary location with the correct
# extension...

tmp_pdbfile="$($MKTEMP galaxy_tmpXXXXXX.pdb)"
$CP $1 $tmp_pdbfile 

run_output=$(sg interactomix -c "PERL5LIB=$PERL5LIB $PERL $VORFFIP $tmp_pdbfile 2> /dev/null")
if [ $? -ne 0 ]; then
	exit 1
fi

$RM $tmp_pdbfile

output_dir=$run_output

fb_result=$($LS "${output_dir}"/RESULTS/fb_results_PROTEIN*)
pdb_result=$($LS "${output_dir}"/PDB/RESULT/PROTEIN_*.pdb)
#xls_result=

if [ $($ECHO $fb_result | wc -w) -ne 1 ]; then
	exit 1
fi 
if [ $($ECHO $pdb_result | wc -w) -ne 1 ]; then
	exit 1
fi 
#if [ $($ECHO $xls_result | wc -w) -ne 1 ]; then
#	exit 1
#fi 

$CP "$fb_result" "$2"
$CP "$pdb_result" "$3"
#$CP "$xls_result" "$4"
