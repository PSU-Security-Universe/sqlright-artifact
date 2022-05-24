import bisecting
import click
import constants
import pgs
import reports
import utils
import vcs
from loguru import logger


def setup_logger(debug_level):
    logger.add(
        constants.LOG_OUTPUT_FILE,
        format="{time} {level} {message}",
        level=debug_level,
        rotation="100 MB",
    )


def enter_bisecting_mode():
    all_commits = vcs.get_all_commits_hexsha()
    logger.info(f"Getting {len(all_commits)} number of commits.")

    logger.info("Beginning processing files in the target folder.")

    for sample, sample_queries in reports.read_queries_from_files():
        for sample_query in sample_queries:
            _ = bisecting.start_bisect(sample_query)
        # utils.remove_file(sample)


def setup_env():
    # remove and re-create the unique bug output directory.
    utils.remove_directory(constants.UNIQUE_BUG_OUTPUT_DIR)
    constants.UNIQUE_BUG_OUTPUT_DIR.mkdir(parents=True)

    # Use the backup of PostgreSQL source code.
    if constants.MYSQL_CHECKOUT_ROOT.exists():
        utils.remove_directory(constants.MYSQL_CHECKOUT_ROOT)
        utils.copy_directory(
            constants.MYSQL_SOURCE_BACKUP, constants.MYSQL_CHECKOUT_ROOT
        )

    pgs.clone_mysql_source()


@click.command()
@click.option(
    "--debug-level",
    default="DEBUG",
    type=click.Choice(["DEBUG", "INFO"]),
    help="specify the debug level for the log file.",
)
def main(debug_level):

    setup_logger(debug_level)
    setup_env()

    enter_bisecting_mode()


if __name__ == "__main__":
    main()
