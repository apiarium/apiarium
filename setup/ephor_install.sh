#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp -R $DIR/../../ephor /opt/

if [ $# -ne 1 ]; 
then
    echo "ephor_install - installer for ephor"
    echo " "
    echo "ephor_install application"
    echo " "
    echo "options:"
    echo "-h, --help                show brief help"
    exit 0
fi

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "ephor_install - installer for ephor"
            echo " "
            echo "ephor_install application"
            echo " "
            echo "options:"
            echo "-h, --help                show brief help"
            echo "web                       install the web part of ephor"
            echo "range                     install the range part of ephor"
            exit 0
            ;;
        *)
            if [ $1 == "range" ]; then
                # install dependencies
                bash $DIR/install_dependencies.sh
                cp $DIR/ephor-range.conf /etc/init/
            fi
            if [ $1 == "web" ]; then
                # install dependencies
                bash $DIR/install_dependencies.sh
                cp $DIR/ephor-web.conf /etc/init/
            fi
            break
            ;;
    esac
done
