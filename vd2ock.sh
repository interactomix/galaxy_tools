#!/bin/sh

tmp_outdir=$(mktemp -d /interactomix/outputs-tools/VD2OCK/XXXXXX)

PERL5LIB="/interactomix/bin-tools/VD2OCK:$PERL5LIB" perl /interactomix/bin-tools/VD2OCK/run_vd2ock.pl \
	$1 \
	$2 \
	$(dirname $tmp_outdir) \
	$(basename $tmp_outdir) \
	$3 \
	$4 \

cat $(ls $tmp_outdir/out_rot_* | grep -Ev -e ".*\.sp" -e ".*\.zr\.out") > $5
if [ $4 -eq "1" -o $4 -eq "3" ]; then
    cat $tmp_outdir/out_rot*.zr.out > $7
fi

if [ $4 -eq "2" -o $4 -eq "3" ]; then
    cat $tmp_outdir/out_rot*.sp > $6
fi
