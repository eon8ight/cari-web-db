#!/usr/bin/env bash

psql -U postgres -c 'drop database if exists cari'
psql -U postgres -c 'create database cari'

basedir=$(dirname "$0")

schema_files=(
    'aesthetic.sql'
    'media.sql'
    'website.sql'
)

for schema_file in "${schema_files[@]}"
do
    psql -U cari -d cari -f "$basedir/schema/$schema_file" -1
done

data_files=(
    'aesthetic.sql'
    'media.sql'
    'website.sql'
)

for data_file in "${data_files[@]}"
do
    psql -U cari -d cari -f "$basedir/data/$data_file" -1
done