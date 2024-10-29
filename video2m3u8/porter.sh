#!/bin/bash

pendingDIR=$1
srcDIR=$2

function emv()
{
    while true
    do
        local isEmpty=$(find ${srcDIR} -maxdepth 0 -empty)
        if [ "${isEmpty}" == "" ]; then
            sleep 1
            continue
        fi
        local pendingFile=$(find ${pendingDIR} -maxdepth 1 -type f ! -name '.*' | head -n 1)
        if [ "${pendingFile}" == "" ]; then
            sleep 1
            continue
        fi
        local tmpfilename=$(basename $pendingFile)
        echo "mv ${pendingDIR}${tmpfilename} ${srcDIR}${tmpfilename}"
        mv ${pendingDIR}${tmpfilename} ${srcDIR}${tmpfilename}
    done
}

sleep 10
emv
