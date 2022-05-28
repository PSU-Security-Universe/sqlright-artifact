from enum import Enum
from pathlib import Path


PROJECT_SOURCE_ROOT = Path(__file__).absolute().parents[2]

SQLRIGHT_MYSQL = PROJECT_SOURCE_ROOT / "MySQL"

BUG_ANALYSIS_FOLDER = SQLRIGHT_MYSQL / "Bug_Analysis"
BISECTING_BUG_SAMPLES = BUG_ANALYSIS_FOLDER / "bug_samples"
LOG_OUTPUT_FILE = BUG_ANALYSIS_FOLDER / "logs/{time}.txt"
UNIQUE_BUG_OUTPUT_DIR = BUG_ANALYSIS_FOLDER / "unique_bug_output"
FAILED_COMPILE_COMMITS = BUG_ANALYSIS_FOLDER / "assets/failed_compiled_commits.json"
MYSQL_SORTED_COMMITS = BUG_ANALYSIS_FOLDER / "assets/sorted-commits.json"

# MYSQL_SOURCE = BUG_ANALYSIS_FOLDER / "mysql_source"
MYSQL_SOURCE = Path("/data1/liusong") / "mysql_source"
MYSQL_SOURCE_BACKUP = MYSQL_SOURCE / "backup"
MYSQL_CHECKOUT_ROOT = MYSQL_SOURCE / "checkout"
MYSQL_BUILD_ROOT = MYSQL_SOURCE / "build"
MYSQL_BOOST_SOURCE = MYSQL_SOURCE / "boost_1_73_0"
MYSQL_ORIGIN_DATA = MYSQL_SOURCE / "orig_data"
MYSQL_SERVER_PORT = 9300
MYSQL_CONNECT_SOCKET = Path("/tmp/mysql_bisect.sock")

COMPILE_THREAD_COUNT = 40
COMMIT_SEARCH_RANGE = 1


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
