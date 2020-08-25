#!/bin/bash

ROOT=$1
EXP="subsuming"
OUTPUT="$ROOT/$EXP-resultsOPT.txt"
echo -n "" > $OUTPUT
for instance in $ROOT/$EXP/*; do
  INSTANCE=$(basename $instance)
  echo $INSTANCE >> $OUTPUT
  for run in $instance/*.txt; do
    RUN=$(basename $run .txt)
    echo -n "$RUN "  >> $OUTPUT
    if grep -q "==UNKNOWN==" "$run"; then
      echo "-1  -1.0" >> $OUTPUT
    elif grep -q "\-\-\-\-\-\-\-\-\-\-" "$run"; then
      echo -n $(grep "obj" "$run" | sed "s/obj[[:alpha:]]* = //" | sed 's/;//' | tail -1) " "  >> $OUTPUT
      echo $(grep -E -o "[0-9]+\.[0-9]+ s" "$run" | sed 's/ s//' | tail -1)  >> $OUTPUT
    fi
  done
done

EXP="soft"
OUTPUT="$ROOT/$EXP-resultsOPT.txt"
echo -n "" > $OUTPUT
for instance in $ROOT/$EXP/*; do
  INSTANCE=$(basename $instance)
  echo $INSTANCE >> $OUTPUT
  for run in $instance/*.txt; do
    RUN=$(basename $run .txt)
    echo -n "$RUN "  >> $OUTPUT
    if grep -q "==UNKNOWN==" "$run"; then
      echo "-1  -1.0" >> $OUTPUT
    elif grep -q "\-\-\-\-\-\-\-\-\-\-" "$run"; then
      echo -n $(grep "obj" "$run" | sed "s/obj[[:alpha:]]* = //" | sed 's/;//' | tail -1) " "  >> $OUTPUT
      echo $(grep -E -o "[0-9]+\.[0-9]+ s" "$run" | sed 's/ s//' | tail -1)  >> $OUTPUT
    fi
  done
done

EXP="hard"
OUTPUT="$ROOT/$EXP-resultsOPT.txt"
echo -n "" > $OUTPUT
for run in $ROOT/$EXP/*; do
  INSTANCE=$(basename $run)
  echo $INSTANCE >> $OUTPUT
    if grep -q "==UNKNOWN==" "$run"; then
      echo "-1  -1.0" >> $OUTPUT
    elif grep -q "\-\-\-\-\-\-\-\-\-\-" "$run"; then
      echo -n $(grep "obj" "$run" | sed "s/obj[[:alpha:]]* = //" | sed 's/;//' | tail -1) " "  >> $OUTPUT
      echo $(grep -E -o "[0-9]+\.[0-9]+ s" "$run" | sed 's/ s//' | tail -1)  >> $OUTPUT
    fi
done
