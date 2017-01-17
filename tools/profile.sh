#!/usr/bin/env bash

set -eu

export LOG_TAGS=event_store_http,event_store_http_data
export LOG_LEVEL=warn

echo
echo "Collecting profile data"
echo "= = ="
echo

for file in test/interactive/profile/*.rb; do
  infile=$(basename $file)

  if [ $infile != "profile_init.rb" ]; then
    outfile="$(basename $infile .rb).svg"
    cmd="ruby $file | tools/flamegraph.pl --countname=ms --width=1280 > tmp/$outfile"

    echo "Generating $outfile from $infile"
    echo "- - "
    echo
    echo $cmd
    echo

    eval $cmd
  fi
done
