#!/bin/bash

if [[ $# -ne 2 ]]
then
    echo "USAGE: $0 <input_file> <output_file>"
    exit 1
fi

in_hex_file=$1
out_hex_rev_file=$2


hex_instrs=`cat $in_hex_file`

for instr in $hex_instrs
do
    echo ${instr:6:2} >> $out_hex_rev_file
    echo ${instr:4:2} >> $out_hex_rev_file
    echo ${instr:2:2} >> $out_hex_rev_file
    echo ${instr:0:2} >> $out_hex_rev_file
done


