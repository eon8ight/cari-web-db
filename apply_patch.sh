#!/usr/bin/env bash

user=cari
database=cari
host=localhost
port=5432
patch_file=''

while getopts ":U:d:h:p:f:" opt; do
    case "${opt}" in
        U)
            user="${OPTARG}"
            ;;
        d)
            database="${OPTARG}"
            ;;
        h)
            host="${OPTARG}"
            ;;
        p)
            port="${OPTARG}"
            ;;
        f)
            patch_file="${OPTARG}"
            ;;
    esac
done

if [[ -z "$patch_file" ]]; then
    echo "No patch file provided."
    exit -1
fi

psql -U "$user" -d "$database" -h "$host" -p "$port" -f "$patch_file" -1
