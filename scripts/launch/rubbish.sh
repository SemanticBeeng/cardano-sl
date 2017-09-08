#!/usr/bin/env bash

# This helper script facilitates work with cardano-rubbish.
# If you run 'demo.sh' (or demo with wallet), you can this script.
# Usage: scripts/launch/rubbish.sh [COMMAND] args
#
# COMMAND can be:
# 'init-dev' – initialize rubbish for dev mode.
# If COMMAND is not passed, 'args' are passed directly to cardano-rubbish.

base=$(dirname "$0")
. "$base"/../common-functions.sh

ensure_logs

dht_conf=" --peer 127.0.0.1:3000 --peer 127.0.0.1:3001 --peer 127.0.0.1:3002 --peer 127.0.0.1:3003 "
logs_conf=$(logs rubbish.log)
binary=$(find_binary cardano-rubbish)
template="$binary $dht_conf $logs_conf \
                 --db-path run/rubbish-db --rebuild-db \
                 --flat-distr \"(4, 100000)\" \
                 --system-start 100500"  # random value, not used, but mandatory

if [[ $1 == "init-dev" ]]; then
    commands="add-key-pool 0,add-key-pool 1,add-key-pool 2,add-key-pool 3"
fi

if [[ "$commands" != "" ]]; then
    suffix=" cmd --commands=\"$commands\""
else
    suffix=$@
fi

to_exec="$template $suffix"

echo "$to_exec"

eval $to_exec
