#!/bin/bash

ROOT_DIR=$1
MODEL=$2
MZN_PATH='/Applications/MiniZincIDE.app/Contents/Resources/minizinc'

mkdir $ROOT_DIR/fzn/

for f in $ROOT_DIR/dzn/*.dzn; do
  #echo "$(basename -- $f)";
  ARGS="-c --solver gecode.soft --fzn $ROOT_DIR/fzn/$(basename $f .dzn).fzn $MODEL $f"
  echo $MZN_PATH $ARGS
  $MZN_PATH $ARGS 
done


