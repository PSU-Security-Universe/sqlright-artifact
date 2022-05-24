from enum import Enum
from pathlib import Path

PROJECT_SOURCE_ROOT = Path(__file__).absolute().parents[2]

SQLRIGHT_POSTGRESQL = PROJECT_SOURCE_ROOT / "PostgreSQL"

BUG_ANALYSIS_FOLDER = SQLRIGHT_POSTGRESQL / "Bug_Analysis"
BISECTING_BUG_SAMPLES = BUG_ANALYSIS_FOLDER / "bug_samples"
LOG_OUTPUT_FILE = BUG_ANALYSIS_FOLDER / "logs/{time}.txt"
UNIQUE_BUG_OUTPUT_DIR = BUG_ANALYSIS_FOLDER / "unique_bug_output"
FAILED_COMPILE_COMMITS = BUG_ANALYSIS_FOLDER / "assets/failed_compiled_commits.txt"
POSTGRES_COMPILE_PATCH = BUG_ANALYSIS_FOLDER / "assets/copy-file-range.patch"
POSTGRES_SORTED_COMMITS = BUG_ANALYSIS_FOLDER / "assets/sorted-commits.json"

POSTGRESQL_SOURCE = BUG_ANALYSIS_FOLDER / "postgres"
# POSTGRESQL_SOURCE_BACKUP = POSTGRESQL_SOURCE / "backup"
# POSTGRESQL_CHECKOUT_ROOT = POSTGRESQL_SOURCE / "checkout"
# POSTGRESQL_BUILD_ROOT = POSTGRESQL_SOURCE / "build"
POSTGRESQL_SOURCE_BACKUP = Path("/data/liusong/postgres_origin")
POSTGRESQL_CHECKOUT_ROOT = Path("/data/liusong/postgres_test")
POSTGRESQL_BUILD_ROOT = Path("/data/liusong/postgres_build")

COMPILE_THREAD_COUNT = 40
COMMIT_SEARCH_RANGE = 1

# For fuzzing
CORE_ID_BEGIN = 0
MAX_FUZZING_INSTANCE = 1
FUZZING_ROOT_DIR = SQLRIGHT_POSTGRESQL
POSTGRE_MASTER_COMMIT_ID = "bafad2c5b261a1449bed60ebac9e7918ebcc42b4"
POSTGRE_FUZZING_BINARY_PATH = (
    POSTGRESQL_BUILD_ROOT / POSTGRE_MASTER_COMMIT_ID / "bin/postgres"
)

FUZZING_COMMAND = (
    "AFL_SKIP_CPUFREQ=1 "
    "AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 "
    "../afl-fuzz -i ./inputs/ -o ./ -E "
)


class RESULT(Enum):
    PASS = 1
    FAIL = 0
    ERROR = -1
    ALL_ERROR = -1
    FAIL_TO_COMPILE = -2
    SEG_FAULT = -2

    @classmethod
    def has_value(cls, value):
        return value in cls._value2member_map_


class BisectingResults:
    query = []
    first_buggy_commit_id: str = "Unknown"
    first_corr_commit_id: str = "Unknown"
    final_res_flag: RESULT = RESULT.PASS
    is_error_returned_from_exec: bool = False
    last_buggy_res_str_l = []
    last_buggy_res_flags_l = []
    unique_bug_id_int = "Unknown"
    is_bisecting_error: bool = False
    bisecting_error_reason: str = ""
