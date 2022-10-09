#!/bin/bash
declare directorio

function uno {
    echo $(du $directorio)
}

function dos {
    echo $(ls $directorio | wc -l)
}

function tres {
    echo $(find $directorio -maxdepth 1 -type f | wc -l )
}

function cuatro {
    echo $(du -ac --time $directorio | sort -nr | head -n 2)
}

if [ $# -gt 1 ]; then
    echo "Error. Has pasado dos o mas argumentos."
    exit
fi

if [ $# == 0 ]; then
    directorio=$(pwd)
    #echo $directorio
fi

if [ $# -eq 1 ]; then
    directorio=$1
    #echo $directorio
fi

echo "¿Que informacion desea?"
echo "1) Total disk used"
echo "2) Number of directories"
echo "3) Number of regular files"
echo "4) Biggest file"
echo "5) Smallest file"
echo "6) Number of files with read permission for owner"
echo "7) Number of files with write permission for group"
echo "8) Number of files with execution permission for the rest of users"
echo "9) Number of files with execution permission for everyone"
echo "10) Exit"

read opcion;
case $opcion in
    1) uno;;
    2) dos;;
    3) tres;;
    4) cuatro;;
    10) exit
esac


