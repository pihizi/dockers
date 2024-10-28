#!/bin/bash
srcDIR=/data/upload/
tmpDIR=/data/tmp/
destDIR=/data/parsed/

slicelen=12
/usr/bin/inotifywait -mrq --format '%f' -e create ${srcDIR} -e moved_to ${srcDIR} | while read file
do
    echo "Start to convert: ${srcDIR}${file}"
    mkdir -p ${tmpDIR}${file}
    ffmpeg -i ${srcDIR}${file} -vf "select=eq(n\,0)" -vframes 1 ${tmpDIR}${file}/main-%2d.jpg >/dev/null 2>/dev/null
    ffmpeg -i ${srcDIR}${file} -map 0 -c copy -f segment -segment_list ${tmpDIR}${file}/slice.m3u8 -segment_time ${slicelen} ${tmpDIR}${file}/slice%06d.ts >/dev/null 2>/dev/null
    #ffmpeg -i ${srcDIR}${file} -force_key_frames "expr:gte(t,n_forced*${slicelen})" -strict -${slicelen} -c:a aac -c:v libx264 -hls_time ${slicelen} -f hls ${tmpDIR}${file}/slice.m3u8 >/dev/null 2>/dev/null
    mpath=${file:0:4}
    mdir=$(echo $file | awk -F. '{print $1}')
    mkdir -p ${destDIR}${mpath}/${mdir}
    mv ${tmpDIR}${file}/* ${destDIR}${mpath}/${mdir}/
    rm -rf ${tmpDIR}${file}
    echo "file converted: ${srcDIR}${file}"
done
