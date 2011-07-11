#!/bin/bash
# Listen file change events and create plantuml files with given file prefix
# You need inotify-tools package to use this

CURPATH=$1
PLANTUML_JAR="/home/yuxel/Desktop/ply_arch/plantuml.jar"
FILE_EXT=".plantuml"

BASE=`pwd`

inotifywait -mr -e close_write $CURPATH | while read dir event file; do
    dir=`echo $dir | sed 's/.\(.*\)/\1/'` #remove first dot
    filePath=${BASE}${dir}${file}

    if [ -e $filePath ]
    then
        isPlantuml=`echo $filePath | grep -q $FILE_EXT ; echo $?`
        if [ $isPlantuml -eq 0 ] 
        then
            echo $filePath
            java -jar $PLANTUML_JAR $filePath 2> /dev/null
        fi
    fi
done
