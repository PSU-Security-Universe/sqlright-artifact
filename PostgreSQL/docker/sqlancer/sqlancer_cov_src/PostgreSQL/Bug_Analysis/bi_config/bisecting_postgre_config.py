import os

SQUIRREL_POSTGRE_DIR = "/data/liusong/Squirrel_DBMS/PostgreSQL"
POSTGRE_COMPILE_PATCH = os.path.join(SQUIRREL_POSTGRE_DIR, "copy-file-range.patch")
FAILED_COMPILE_COMMITS = os.path.join(SQUIRREL_POSTGRE_DIR, "failed_compiled_commits.txt")

POSTGRE_DIR = "/data/liusong/postgres_test"
POSTGRE_PURE_DIR = "/data/liusong/postgres_origin"
# Change to your own postgre repo root dir.
POSTGRE_BLD_DIR = "/data/liusong/postgres_build"
POSTGRE_BRANCH = "master"

# Change to your own query_samples dir.
QUERY_SAMPLE_DIR = os.path.join(SQUIRREL_POSTGRE_DIR, "Bug_Analysis/bug_samples/")

LOG_OUTPUT_DIR = os.path.join(SQUIRREL_POSTGRE_DIR, "Bug_Analysis/")
LOG_OUTPUT_FILE = os.path.join(LOG_OUTPUT_DIR, "bisecting_postgre_log.txt")
UNIQUE_BUG_OUTPUT_DIR = os.path.join(LOG_OUTPUT_DIR, "unique_bug_output")

COMPILE_THREAD_COUNT = 40
COMMIT_SEARCH_RANGE = 1

BEGIN_COMMIT_ID = ""  # INCLUDED!!!   Earlier commit.
END_COMMIT_ID = ""  # EXCLUDED!!!   Later commit.


# For fuzzing
CORE_ID_BEGIN = 0
MAX_FUZZING_INSTANCE = 1
FUZZING_ROOT_DIR = SQUIRREL_POSTGRE_DIR
POSTGRE_MASTER_COMMIT_ID = "bafad2c5b261a1449bed60ebac9e7918ebcc42b4"
POSTGRE_FUZZING_BINARY_PATH = os.path.join(
    POSTGRE_BLD_DIR, "/%s/bin/psql" % POSTGRE_MASTER_COMMIT_ID
)
FUZZING_COMMAND = "AFL_SKIP_CPUFREQ=1 AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1  ../afl-fuzz -i ./inputs/ -o ./ -E "
