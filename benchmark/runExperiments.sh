#!/bin/bash

ROOT_DIR=$1
MODEL=$2
MZN_PATH='/Applications/MiniZincIDE.app/Contents/Resources/minizinc'

mkdir -p $ROOT_DIR/results/subsuming
mkdir -p $ROOT_DIR/results/soft
mkdir -p $ROOT_DIR/results/hard

TIME_LIMIT=$3

run_hard () {
  for f in $ROOT_DIR/fzn/*.fzn; do
    local ARGS="--solver gecode.soft --output-time -t $TIME_LIMIT";
    $MZN_PATH $ARGS --fzn-flags "-soften false" $f > "$ROOT_DIR/results/hard/$(basename $f .fzn).txt";
  done
}


run_soft () {
  for f in $ROOT_DIR/fzn/*.fzn; do
    mkdir -p "$ROOT_DIR/results/soft/$(basename $f .fzn)"
    local ARGS="--solver gecode.soft --output-time -t $TIME_LIMIT"
    for i in {1..10}; do
      $MZN_PATH $ARGS --fzn-flags "-restart constant -r $RANDOM -selfsubsuming false" $f > "$ROOT_DIR/results/soft/$(basename $f .fzn)/$i.txt" &
    done
    wait
  done
}

run_subsuming () {
  for f in $ROOT_DIR/fzn/*.fzn; do
    mkdir -p "$ROOT_DIR/results/subsuming/$(basename $f .fzn)"
    local ARGS="--solver gecode.soft --output-time -t $TIME_LIMIT"
    for i in {1..10}; do
      $MZN_PATH $ARGS --fzn-flags "-restart constant -r $RANDOM" $f > "$ROOT_DIR/results/subsuming/$(basename $f .fzn)/$i.txt"&
    done
    wait
  done
}

if [ $# -lt 4 ] || [ "$4" == "" ]; then
  echo "no mode specified. Exiting..."
elif [ "$4" == "subsuming" ] ; then
  run_subsuming
elif [ "$4" == "soft" ] ; then
  run_soft
elif [ "$4" == "hard" ] ; then
  run_hard
else
  echo "Unknown mode. Exiting..."
fi

#run_subsuming

#for f in $ROOT_DIR/fzn/*.fzn; do
#  ARGS="--solver gecode.soft --output-time -t $TIME_LIMIT"
#  $MZN_PATH $ARGS --fzn-flags "-soften false" $f > "$ROOT_DIR/results/hard/$(basename $f .fzn).txt"
#  $MZN_PATH $ARGS --fzn-flags "-restart constant -r $RANDOM -selfsubsuming false" $f > "$ROOT_DIR/results/soft/$(basename $f .fzn).txt"
#  $MZN_PATH $ARGS --fzn-flags "-restart constant -r $RANDOM" $f > "$ROOT_DIR/results/subsuming/$(basename $f .fzn).txt"
#done
