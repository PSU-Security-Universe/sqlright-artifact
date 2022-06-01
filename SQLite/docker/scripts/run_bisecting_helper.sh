#!/bin/bash -e

# This file is used for start the SQLRight sqlite fuzzing inside the Docker env.
# entrypoint: bash

chown -R sqlite:sqlite /home/sqlite/bisecting

SCRIPT_EXEC=$(cat << EOF

cd /home/sqlite/

python3 bisecting $@

EOF
)

su -c "$SCRIPT_EXEC" sqlite

echo "Finished running the bisecting. "
