#!/bin/bash

for ((i=0; i<$(nproc); i++)); do
    echo "Processing CPU $i"
    profile-bpfcc -F 99 -C $i -adf 5 > out.profile-folded-$i & # might be called /usr/share/bcc/tools/profile
done

wait
for ((i=0; i<$(nproc); i++)); do
    echo "Creating flamegraphs CPU $i"
    ./FlameGraph/flamegraph.pl --colors=java out.profile-folded-$i > profile-$i.svg
done
