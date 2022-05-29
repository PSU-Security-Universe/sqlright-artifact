import os
import re
import click
import json
from pathlib import Path
from loguru import logger
from rich.progress import track
from itertools import combinations
from collections import defaultdict

TOKENS = [
    "PARTITION",
    "FLOAT",
    "CHAR",
    "RENAME",
    "DISTINCT",
    "GLOB",
    "INTERSECT",
    "ANALYZE",
    "DESC",
    "MATCH",
    "NOTHING",
    "BY",
    "CASE",
    "UNIQUE",
    "NATURAL",
    "UPDATE",
    "COMPOSER",
    "TOTAL_CHANGES",
    "ALWAYS",
    "ASCSELECT",
    "ZIPFILE",
    "GENERATED",
    "LONG",
    "EXCEPT",
    "DETACH",
    "UNLIKELY",
    "CHECK",
    "GROUP",
    "INS",
    "ROUND",
    "ABORT",
    "AS",
    "VARCHAR",
    "IN",
    "ROWID",
    "UPPER",
    "AND",
    "WITHOUT",
    "TYPEOF",
    "BOOL",
    "ROWIDINSERT",
    "LIKE",
    "INSERT",
    "INT2STR",
    "VIEW",
    "DATABASE",
    "PAGE_COUNT",
    "ZEROBLOB",
    "USING",
    "VACUUM",
    "SET",
    "IFNULL",
    "NTILE",
    "JOURNAL_MODE=MEMORY",
    "NUM",
    "EXISTS",
    "SELECT",
    "KEY",
    "NULLIF",
    "CREATE",
    "TOTAL",
    "CUME_DIST",
    "PRINTF",
    "NULLSELECT",
    "AVG",
    "HEX",
    "TABLE",
    "INTO",
    "BEGIN",
    "REPLACE",
    "INT",
    "DELETE",
    "COALESCE",
    "FOREIGN",
    "ABS",
    "SQLITE_COMPILEOPTION_GET",
    "INDEX",
    "WHERE",
    "FTS4",
    "LEAD",
    "ALBUM",
    "RANDSTR",
    "INTEGER",
    "CAST",
    "NOT",
    "PRAGMA",
    "LAST_INSERT_ROWID",
    "NULLS",
    "ORDER",
    "DESCSELECT",
    "NULL",
    "COLUMN",
    "END",
    "ON",
    "VDBE_DEBUG",
    "THEN",
    "COLLATE",
    "FIRST",
    "FOR",
    "JOIN",
    "BLOB",
    "RTREE",
    "TEXT",
    "ALTER",
    "OR",
    "INDEXED",
    "COUNT",
    "SQLITE_COMPILEOPTION_USED",
    "FAIL",
    "WHEN",
    "VIRTUAL",
    "HAVING",
    "LENGTH",
    "REFERENCES",
    "SQLITE_MASTER",
    "DOUBLE",
    "OUTER",
    "MIN",
    "IS",
    "DENSE_RANK",
    "ROW_NUMBER",
    "TOINTEGER",
    "DEFAULT",
    "INSTR",
    "QUOTE",
    "SUM",
    "PRIMARY",
    "IGNORE",
    "PAGE_SIZE",
    "SUBSTR",
    "VALUE",
    "CHANGES",
    "LAST",
    "NTH_VALUE",
    "WITH",
    "LEFT",
    "TRUE",
    "ATTACH",
    "CROSS",
    "ISNULL",
    "INNER",
    "VALUES",
    "ASC",
    "BETWEEN",
    "FILTER",
    "DO",
    "OVER",
    "CONFLICT",
    "DATETIME",
    "MAIN",
    "FROM",
    "LOWER",
    "DATEADD",
    "UNION",
    "ELSE",
    "LIKELIHOOD",
    "MAX",
    "FALSE",
]

TOKEN_PATTERN = re.compile("|".join(TOKENS))


def get_all_token():
    bug_reports = Path("second_unique_reports")
    all_tokens = set()
    for json_bug_report in bug_reports.rglob("*.json"):
        with open(json_bug_report) as f:
            report = json.load(f)
            database_queries = report["original_database_query"]
            first_oracle_query = report["first_oracle"]
            second_oracle_query = report["second_oracle"]

        full_query = (
            database_queries.replace(";", "")
            + "\n"
            + first_oracle_query.replace(";", "")
            + second_oracle_query.replace(";", "")
        )
        full_query = full_query.replace("\n", " ")
        tokens = set(full_query.split())
        all_tokens |= tokens

    bug_reports = Path("all_unique_reports")
    for json_bug_report in bug_reports.rglob("*.json"):
        with open(json_bug_report) as f:
            report = json.load(f)
            database_queries = report["database_query"]
            first_oracle_query = report["first_oracle"]
            second_oracle_query = report["second_oracle"]

        full_query = (
            database_queries.replace(";", "")
            + "\n"
            + first_oracle_query.replace(";", "")
            + second_oracle_query.replace(";", "")
        )
        full_query = full_query.replace("\n", " ")
        tokens = set(full_query.split())
        all_tokens |= tokens

    # print(len(all_tokens))
    true_tokens = set()
    for token in all_tokens:
        token = token.upper().strip()
        if token.isdigit() or token.replace(".", "").isdigit():
            continue

        try:
            token = int(float(token))
        except:
            true_tokens.add(token)

    for token in true_tokens:
        print(token)


def distance(t0, t1):
    """LCS distance."""
    if t0 is None:
        raise TypeError("Argument t0 is NoneType.")
    if t1 is None:
        raise TypeError("Argument t1 is NoneType.")
    if t0 == t1:
        return 0
    return len(t0) + len(t1) - 2 * length(t0, t1)


def length(t0, t1):
    """LCS length."""
    if t0 is None:
        raise TypeError("Argument t0 is NoneType.")
    if t1 is None:
        raise TypeError("Argument t1 is NoneType.")

    t0_len, t1_len = len(t0), len(t1)
    x, y = t0[:], t1[:]
    matrix = [[0] * (t1_len + 1) for _ in range(t0_len + 1)]
    for i in range(1, t0_len + 1):
        for j in range(1, t1_len + 1):
            if x[i - 1] == y[j - 1]:
                matrix[i][j] = matrix[i - 1][j - 1] + 1
            else:
                matrix[i][j] = max(matrix[i][j - 1], matrix[i - 1][j])
    return matrix[t0_len][t1_len]


def tokenize(target):
    with open(target) as f:
        query = [line.strip() for line in f.readlines() if not line.startswith("--")]
        query = " ".join(query)
        query = query.upper()

    query_tokens = TOKEN_PATTERN.findall(query)
    return query_tokens


@click.command()
@click.argument("unique-reports", type=click.Path(exists=True))
def calc_similarity_by_lcs(unique_reports):
    # t0 = ["UNIQUE", "test", "SELECT"]
    # t1 = ["UNIQUE", "asd", "SELECT", "test"]
    # print(length(t0, t1))

    reports_root = Path(unique_reports)
    reports = [
        report
        for report in reports_root.rglob("*.sql")
        if ".min" not in str(report) and "cluster" not in str(report)
    ]

    total = len(list(combinations([0] * len(reports), 2)))
    print("{} reports, {} combinations".format(len(reports), total))

    result = defaultdict(list)
    for cb in track(combinations(reports, 2), total=total):

        n0 = str(cb[0].relative_to(reports_root))
        n1 = str(cb[1].relative_to(reports_root))

        t0 = tokenize(cb[0])
        t1 = tokenize(cb[1])

        result[distance(t0, t1)].append(f"{n0}<=>{n1}")

    result = dict(sorted(result.items()))

    with open(reports_root / "similarity.json", "w") as f:
        json.dump(result, f, indent=2)

    cluster = []

    def find_cluster(pair):
        for idx, pair_set in enumerate(cluster):
            if pair & pair_set:
                return idx
        return -1

    for dist in range(11):
        if dist not in result:
            continue
        for line in result[dist]:
            f0, f1 = line.split("<=>")
            f0 = f0.strip()
            f1 = f1.strip()
            pair = set([f0, f1])

            idx = find_cluster(pair)
            if idx == -1:
                cluster.append(pair)
            else:
                cluster[idx] |= pair

    new_cluster = []
    unique_files = set()
    for pair in cluster:
        new_cluster.append(list(pair))
        unique_files |= pair
    print("{} clusters, {} files.".format(len(cluster), len(unique_files)))

    with open(reports_root / "classifaction.json", "w") as f:
        json.dump(new_cluster, f, indent=2)

    for idx, files in enumerate(new_cluster):
        outdir = reports_root / "cluster" / f"{idx}"
        outdir.mkdir(parents=True, exist_ok=True)
        for file in files:
            path = reports_root / file
            dst_file = outdir / file.replace("/", "_")
            os.system("cp {} {}".format(path, dst_file))

    all_reports = set(
        [
            str(report.relative_to(reports_root))
            for report in reports_root.rglob("*.sql")
            if ".min" not in str(report) and "cluster" not in str(report)
        ]
    )

    non_cluster_reports = all_reports - unique_files
    non_cluster_reports = list(non_cluster_reports)
    with open(reports_root / "non-classifaction.json", "w") as f:
        json.dump(non_cluster_reports, f, indent=2, sort_keys=True)

    outdir = reports_root / "unique"
    outdir.mkdir(exist_ok=True, parents=True)
    for report in non_cluster_reports:
        os.system("cp {} {}".format(reports_root / report, outdir))


@click.command()
@click.argument("bug-samples", type=click.Path(exists=True))
def calc_similarity_by_commit_range(bug_samples):
    """Deduplicate bug reports by commit range."""
    bug_samples = Path(bug_samples)

    bug_reports = [report for report in bug_samples.glob("*")]

    commit_range_files = defaultdict(list)
    for report in bug_reports:
        with open(report) as f:
            contents = f.read()
            buggy_commit = contents[
                contents.find("First buggy commit ID:")
                + len("First buggy commit ID:") : contents.find(
                    "First correct (or crashing) commit ID:"
                )
            ]
            correct_commit = contents[
                contents.find("First correct (or crashing) commit ID:")
                + len("First correct (or crashing) commit ID:") :
            ]

            buggy_commit = buggy_commit.strip()
            correct_commit = correct_commit.strip()
            unique_commit_range = f"{correct_commit}_{buggy_commit}"
            commit_range_files[unique_commit_range].append(report.name)

    with open("same_buggy_commits.json", "w") as f:
        json.dump(commit_range_files, f, indent=2)

    print("{} types.".format(len(commit_range_files)))

    fun_range = 0
    unique_files = set()
    for commit_range, files in commit_range_files.items():
        if len(files) == 1:
            continue
        fun_range += 1
        unique_files |= set(files)
    print(
        "{} different ranges, {} files, shrink {} files".format(
            fun_range, len(unique_files), len(unique_files) - fun_range
        )
    )


def count_similar_reports_within_distance_10():
    with open("similarity.json") as f:
        data = json.load(f)

    files = set()

    for i in range(11):
        if str(i) not in data:
            continue

        for line in data[str(i)]:
            f0, f1 = line.split("<=>")
            f0 = f0.strip()
            f1 = f1.strip()
            files.add(f0)
            files.add(f1)

    print(len(files))


if __name__ == "__main__":
    # get_all_token()
    calc_similarity_by_lcs()
    # count_similar_reports_within_distance_10()
    # calc_similarity_by_commit_range()
