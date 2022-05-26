#!/bin/bash

DATABASE=x
POSTGRE_ROOT_DIR=/home/server1/liusong/software/postgres
POSTGRE_COMMIT_ID=8f73ed6b659464274eb9cc8358588b569960d0be
POSTGRE_INSTALL_DIR=${POSTGRE_ROOT_DIR}/bld/${POSTGRE_COMMIT_ID}

# 1. Run initdb to generate new data directory for Postgre.
${POSTGRE_INSTALL_DIR}/bin/initdb -D ${POSTGRE_INSTALL_DIR}/data 

# 2. Change the default statement_timeout value from 0 to 10000.
sed -i 's/\#statement\_timeout = 0/statement\_timeout = 10000/' ${POSTGRE_INSTALL_DIR}/data/postgresql.conf

# 3. Start a new postgres instance bind to POSTGRE_BIND_PORT.
${POSTGRE_INSTALL_DIR}/bin/pg_ctl --silent -D ${POSTGRE_INSTALL_DIR}/data  start

# 4. Create a database named 'x'
${POSTGRE_INSTALL_DIR}/bin/createdb ${DATABASE}

# 5. Stop instance to avoid conflict when execute ./bin/postgres in single mode.
${POSTGRE_INSTALL_DIR}/bin/pg_ctl --silent -D ${POSTGRE_INSTALL_DIR}/data stop

# 6. Now you can run 
# ${POSTGRE_INSTALL_DIR}/bin/postgres  --single -D ${POSTGRE_INSTALL_DIR}/data ${DATABASE}