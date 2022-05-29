import os

SQUIRREL_SQLITE_DIR = "/home/sqlite/fuzz_test"

SQLITE_DIR = "/home/sqlite/sqlite/sqlite/"
# Change to your own sqlite3 repo root dir.
SQLITE_BLD_DIR = os.path.join(SQLITE_DIR, "bld")
SQLITE_BRANCH = "master"

# Change to your own query_samples dir.
QUERY_SAMPLE_DIR = os.path.join(SQUIRREL_SQLITE_DIR, "Bug_Analysis/bug_samples/")

LOG_OUTPUT_DIR = os.path.join(SQUIRREL_SQLITE_DIR, "Bug_Analysis/")
LOG_OUTPUT_FILE = os.path.join(LOG_OUTPUT_DIR, "bisecting_sqlite_log.txt")
UNIQUE_BUG_OUTPUT_DIR = os.path.join(LOG_OUTPUT_DIR, "unique_bug_output")

COMPILE_THREAD_COUNT = 12
COMMIT_SEARCH_RANGE = 1

BEGIN_COMMIT_ID = ""  # INCLUDED!!!   Earlier commit.
END_COMMIT_ID = ""  # EXCLUDED!!!   Later commit.


# For fuzzing
CORE_ID_BEGIN = 0
MAX_FUZZING_INSTANCE = 1
FUZZING_ROOT_DIR = SQUIRREL_SQLITE_DIR
SQLITE_MASTER_COMMIT_ID = "3ddc3809bf6148d09ea02345deade44873b9064f"
SQLITE_FUZZING_BINARY_PATH = os.path.join(
    SQLITE_DIR, "bld/%s/sqlite3" % SQLITE_MASTER_COMMIT_ID
)
FUZZING_COMMAND = "AFL_SKIP_CPUFREQ=1 AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1  ../afl-fuzz -i ./inputs/ -o ./ -E "
