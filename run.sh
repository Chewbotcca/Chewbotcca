#!/bin/bash

BOB=$(cat config.yaml | shyaml get-value shards)

for ((i=1;i<=BOB;i++)); do
     ruby run.rb "${i}" &
done

wait
