import os

CUR_WORKDIR = "/home/sqlite/bisecting"

SQLITE_DIR = "/home/sqlite/sqlite/"
# Change to your own sqlite3 repo root dir.
SQLITE_BLD_DIR = os.path.join(SQLITE_DIR, "bld")
SQLITE_BRANCH = "master"

# Change to your own query_samples dir.
BUG_SAMPLE_DIR = os.path.join(CUR_WORKDIR, "bug_samples/")

LOG_OUTPUT_DIR = os.path.join(CUR_WORKDIR, "Bug_Analysis/")
LOG_OUTPUT_FILE = os.path.join(LOG_OUTPUT_DIR, "bisecting_sqlite_log.txt")
UNIQUE_BUG_OUTPUT_DIR = os.path.join(LOG_OUTPUT_DIR, "unique_bug_output")

COMPILE_THREAD_COUNT = 20
COMMIT_SEARCH_RANGE = 1

BEGIN_COMMIT_ID = ""  # INCLUDED!!!   Earlier commit.
END_COMMIT_ID = "3ddc3809bf6148d09ea02345deade44873b9064f"  # INCLUDED!!!   Latest commit or the bug triggering commit.
