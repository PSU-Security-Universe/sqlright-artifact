from distutils.version import LooseVersion
from typing import List

import constants
import git
import mysql
import utils

_all_commits_hexsha = []
_all_sorted_tags = []


def get_first_commit():
    cmd = 'git log --no-pager --pretty="%H" --reverse | head -1'
    commit, _, _ = utils.execute_command(cmd, cwd=constants.MYSQL_CHECKOUT_ROOT)
    return commit.strip()


def get_commits_between_tags(left_tag, right_tag):
    cmd = f'git --no-pager log --pretty="%H" {left_tag}...{right_tag}'
    commits, _, _ = utils.execute_command(cmd, cwd=constants.MYSQL_CHECKOUT_ROOT)
    commits = commits.splitlines()
    commits = list(map(lambda c: c.strip(), commits))
    return commits


def get_all_commits_hexsha():
    global _all_commits_hexsha

    if constants.MYSQL_SORTED_COMMITS.exists():
        _all_commits_hexsha = utils.json_load(constants.MYSQL_SORTED_COMMITS)
        return _all_commits_hexsha

    if not _all_commits_hexsha:
        mysql.checkout_mysql_commit("8.0")
        cmd = 'git --no-pager log --pretty="%H"'
        commits, _, _ = utils.execute_command(cmd, cwd=constants.MYSQL_CHECKOUT_ROOT)
        commits = [commit.strip() for commit in commits.splitlines()]
        _all_commits_hexsha = commits

        utils.json_dump(_all_commits_hexsha, constants.MYSQL_SORTED_COMMITS)

    return _all_commits_hexsha


def get_all_sorted_tags():
    global _all_sorted_tags

    if not _all_sorted_tags:
        repo = git.Repo(constants.MYSQL_CHECKOUT_ROOT)
                
        _all_tagrefs = [tagref for tagref in repo.tags if "cluster" not in tagref.name and "ndb" not in tagref.name]
        _all_sorted_tags = [
            tagref
            for tagref in sorted(
                _all_tagrefs, key=lambda tagref: LooseVersion(str(tagref.name))
            )
        ]

        """
        _all_sorted_tags = list(
            filter(
                lambda t: LooseVersion(t.name) >= LooseVersion("REL_10_0"),
                _all_sorted_tags,
            )
        )
        """
        # _all_sorted_tags = _all_sorted_tags[-100:]

    return _all_sorted_tags
