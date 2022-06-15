import os

CUR_WORKDIR = "/home/sqlite/bisecting"

SQLITE_DIR = "/home/sqlite/sqlite_bisecting_binary/"
# Change to your own sqlite3 repo root dir.
SQLITE_BLD_DIR = os.path.join(SQLITE_DIR, "bld")
SQLITE_BRANCH = "master"

# Change to your own query_samples dir.
BUG_SAMPLE_DIR = os.path.join(CUR_WORKDIR, "bug_samples/")

LOG_OUTPUT_FILE = os.path.join(CUR_WORKDIR, "bisecting_sqlite_log.txt")
UNIQUE_BUG_OUTPUT_DIR = os.path.join(BUG_SAMPLE_DIR, "unique_bug_output")

COMPILE_THREAD_COUNT = 1
COMMIT_SEARCH_RANGE = 1

BEGIN_COMMIT_ID = ""  # INCLUDED!!!   Earlier commit.
END_COMMIT_ID = "384f5c26f48b92e8bfcb168381d4a8caf3ea59e7"  # INCLUDED!!!   Latest commit or the bug triggering commit.
