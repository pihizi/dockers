#!/bin/bash
srcDIR=/data/parsing/
tmpDIR=/data/tmp/
destDIR=/data/parsed/
backupRawDIR=/data/backup/
pendingDIR=/data/pending/

deleteSRCFile="${GENEE_DEL_SRC_FILE}"
slicelen=12

/bin/bash /porter.sh $pendingDIR $srcDIR &

/usr/bin/inotifywait -mrq --format '%f' -e create ${srcDIR} -e moved_to ${srcDIR} | while read file
do
    if [ -f ${srcDIR}${file} ]; then
        echo "Start to convert: ${srcDIR}${file}"
        mdir=$(echo $file | awk -F. '{print $1}')
        mpath=${mdir:0:4}
        set -e
            mkdir -p ${tmpDIR}${file}
            ffmpeg -i ${srcDIR}${file} -vf "select=eq(n\,0)" -vframes 1 ${tmpDIR}${file}/main-%2d.jpg >/dev/null 2>/dev/null
            ffmpeg -i ${srcDIR}${file} -map 0 -c copy -f segment -segment_list ${tmpDIR}${file}/slice.m3u8 -segment_time ${slicelen} ${tmpDIR}${file}/slice%06d.ts >/dev/null 2>/dev/null
            mkdir -p ${destDIR}${mpath}/${mdir}
            mv ${tmpDIR}${file}/* ${destDIR}${mpath}/${mdir}/
            if [ "${deleteSRCFile}" == "1" ]; then
                rm ${srcDIR}${file}
            else
                mv ${srcDIR}${file} ${backupRawDIR}${file}
            fi
            rm -rf ${tmpDIR}${file}
        set +e
        echo "file converted: ${srcDIR}${file}"
    fi
done
