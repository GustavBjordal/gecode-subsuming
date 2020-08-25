#!/bin/bash

ROOT=$1
EXP="subsuming"
OUTPUT="$ROOT/$EXP-resultsSAT.txt"
echo -n "" > $OUTPUT
for instance in $ROOT/$EXP/*; do
  INSTANCE=$(basename $instance)
  echo $INSTANCE >> $OUTPUT
  for run in $instance/*.txt; do
    RUN=$(basename $run .txt)
    echo -n "$RUN " >> $OUTPUT
    if grep -q "==UNKNOWN==" "$run"; then
      echo "-1.0" >> $OUTPUT
    elif grep -q "\-\-\-\-\-\-\-\-\-\-" "$run"; then
      echo $(grep -E -o -m 1 "[0-9]+\.[0-9]+ s" "$run" | sed 's/ s//') >> $OUTPUT
    fi
  done
done

EXP="soft"
OUTPUT="$ROOT/$EXP-resultsSAT.txt"
echo -n "" > $OUTPUT
for instance in $ROOT/$EXP/*; do
  INSTANCE=$(basename $instance)
  echo $INSTANCE >> $OUTPUT
  for run in $instance/*.txt; do
    RUN=$(basename $run .txt)
    echo -n "$RUN " >> $OUTPUT
    if grep -q "==UNKNOWN==" "$run"; then
      echo "-1.0" >> $OUTPUT
    elif grep -q "\-\-\-\-\-\-\-\-\-\-" "$run"; then
      echo $(grep -E -o -m 1 "[0-9]+\.[0-9]+ s" "$run" | sed 's/ s//') >> $OUTPUT
    fi
  done
done

EXP="hard"
OUTPUT="$ROOT/$EXP-resultsSAT.txt"
echo -n "" > $OUTPUT
for instance in $ROOT/$EXP/*; do
  INSTANCE=$(basename $instance)
    echo -n "$INSTANCE " >> $OUTPUT
    if grep -q "==UNKNOWN==" "$instance"; then
      echo "-1.0" >> $OUTPUT
    elif grep -q "\-\-\-\-\-\-\-\-\-\-" "$instance"; then
      echo $(grep -E -o -m 1 "[0-9]+\.[0-9]+ s" "$instance" | sed 's/ s//') >> $OUTPUT
    fi
done
