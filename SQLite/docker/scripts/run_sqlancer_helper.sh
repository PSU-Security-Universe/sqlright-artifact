#!/bin/bash -e

# This file is used for start the SQLRight sqlite fuzzing inside the Docker env.
# entrypoint: bash

chown -R sqlite:sqlite /home/sqlite/sqlancer

SCRIPT_EXEC=$(cat << EOF

cd /home/sqlite/sqlancer

python3 run_sqlancer_and_log_cov.py

EOF
)

su -c "$SCRIPT_EXEC" sqlite

echo "Finished running the sqlancer test. "
