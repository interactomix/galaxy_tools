#!/bin/sh

tmp_outdir=$(mktemp -d /interactomix/outputs-tools/VD2OCK/XXXXXX)

PERL5LIB="/interactomix/bin-tool/VD2OCK:$PERL5LIB" perl run_vd2ock.pl \
	$1 \
	$2 \
	$(dirname $tmp_outdir) \
	$(basename $tmp_outdir) \
	$3 \
	$4 \

cat $(ls $tmp_outdir/out_rot_* | grep -Ev -e ".*\.sp" -e ".*\.zr\.out") > $5
cat $tmp_outdir/out_rot*.sp > $6
cat $tmp_outdir/out_rot*.zr.out > $7
