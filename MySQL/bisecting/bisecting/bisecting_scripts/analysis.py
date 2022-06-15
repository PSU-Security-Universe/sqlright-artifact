import bisecting
import click
import constants
import reports
import utils
from loguru import logger
import os
from pathlib import Path


def setup_logger(debug_level):
    logger.add(
        constants.LOG_OUTPUT_FILE,
        format="{time} {level} {message}",
        level=debug_level,
        rotation="100 MB",
    )


def enter_bisecting_mode(oracle_str: str):

    all_commits = utils.json_load(constants.MYSQL_SORTED_COMMITS)
    logger.info(f"Getting {len(all_commits)} number of commits.")

    logger.info("Beginning processing files in the target folder.")

    for sample, sample_queries in reports.read_queries_from_files():
        for sample_query in sample_queries:
            _ = bisecting.start_bisect(sample_query, all_commits, oracle_str)
        # utils.remove_file(sample)


def setup_env():
    # remove and re-create the unique bug output directory.
    utils.remove_directory(constants.UNIQUE_BUG_OUTPUT_DIR)
    os.mkdir(constants.UNIQUE_BUG_OUTPUT_DIR)

    ## Use the backup of PostgreSQL source code.
    #if constants.MYSQL_CHECKOUT_ROOT.exists():
    #    utils.remove_directory(constants.MYSQL_CHECKOUT_ROOT)
    #    utils.copy_directory(
    #        constants.MYSQL_SOURCE_BACKUP, constants.MYSQL_CHECKOUT_ROOT
    #    )
    #pgs.clone_mysql_source()


@click.command()
@click.option(
    "--debug-level",
    default="DEBUG",
    type=click.Choice(["DEBUG", "INFO"]),
    help="specify the debug level for the log file.",
)
def main(debug_level):

    oracle_str = "NOREC"
    try:
        opts, args = getopt.getopt(sys.argv[1:], "O:", ["oracle="])
    except getopt.GetoptError:
        print("Arguments parsing error")
        exit(1)
    for opt, arg in opts:
        if opt in ("-O", "--oracle"):
            oracle_str = arg
            print("Using oracle: %s " % (oracle_str))
        else:
            print("Error. Input arguments not supported. \n")
            exit(1)

    setup_logger(debug_level)
    setup_env()

    enter_bisecting_mode(oracle_str)


if __name__ == "__main__":
    main()
