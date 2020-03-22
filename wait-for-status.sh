#!/bin/bash

usage()
{
    cat << USAGE >&2
Usage:
    ${0##*/} [-t timeout] [-s status_code] url
    -t TIMEOUT      timeout in seconds [default: 10]
    -s STATUS_CODE  expected status_code [default: 200]
    -h              show this help

USAGE
    exit 1
}


TIMEOUT=10
STATUS_CODE=200

while [[ $# -gt 0 ]]
do
    case "$1" in
        *:* ) 
            URL=(${1})
            shift 1
            ;;
        -s)
            STATUS_CODE="$2"
            shift 2
            ;;
        --status_code=*)
            STATUS_CODE="${1#*=}"
            shift 1
            ;;
        -t)
            TIMEOUT="$2"
            shift 2
            ;;
        --timeout=*)
            TIMEOUT="${1#*=}"
            shift 1
            ;;
        --)
            shift
            COMMAND=("$@")
            break
            ;;
        -h)
            usage
            ;;
        *)
            echoerr "Unknown argument: $1"
            usage
            ;;
    esac
done


SECONDS=0


if [[ $URL == "" ]]; then
    usage
fi

while [[ $(curl -o /dev/null -s -w "%{http_code}\n" $URL) -ne $STATUS_CODE ]]; do
    if [[ "$SECONDS" -gt "$TIMEOUT" ]]; then
        exit 1
    fi
    sleep 5
    SECONDS=$(expr $SECONDS + 5)
done

exec "${COMMAND[@]}"
