#!/usr/bin/env bash

user=cari
database=cari
host=localhost
port=5432

while getopts ":U:d:h:p" opt; do
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
    esac
done

read -r -d '' cmd_drop <<SQL
DO \$\$ DECLARE
    drop_command TEXT;
BEGIN
    FOR drop_command in (
        select 'drop table ' || quote_ident( tablename ) || ' cascade'
          from pg_tables
         where schemaname = current_schema()
         union all
        select 'drop sequence ' || quote_ident( sequencename ) || ' cascade'
          from pg_sequences
         where schemaname = current_schema()
     ) LOOP
        raise notice '%', drop_command;
        execute drop_command;
    END LOOP;
END \$\$;
SQL

psql -U "$user" -d "$database" -h "$host" -p "$port" -c "$cmd_drop"

basedir=$(dirname "$0")

schema_files=(
    'aesthetic.sql'
    'media.sql'
    'website.sql'
)

for schema_file in "${schema_files[@]}"; do
    psql -U "$user" -d "$database" -h "$host" -p "$port" -f "$basedir/schema/$schema_file" -1
done
