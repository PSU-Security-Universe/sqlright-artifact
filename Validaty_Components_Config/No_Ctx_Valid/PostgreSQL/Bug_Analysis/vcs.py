from distutils.version import LooseVersion
from typing import List

import constants
import git
import pgs
import utils

_all_commits_hexsha = []
_all_sorted_tags = []


def get_first_commit() -> str:
    cmd = "git rev-list --max-parents=0 HEAD"
    commit, _, _ = utils.execute_command(cmd, cwd=constants.POSTGRESQL_CHECKOUT_ROOT)
    return commit.strip()


def get_commits_between_tags(left_tag, right_tag) -> List[str]:
    cmd = f'git --no-pager log --pretty="%H" {left_tag}...{right_tag}'
    commits, _, _ = utils.execute_command(cmd, cwd=constants.POSTGRESQL_CHECKOUT_ROOT)
    commits = commits.splitlines()
    commits = list(map(lambda c: c.strip(), commits))
    return commits


def get_all_commits_hexsha():
    global _all_commits_hexsha

    if constants.POSTGRES_SORTED_COMMITS.exists():
        _all_commits_hexsha = utils.json_load(constants.POSTGRES_SORTED_COMMITS)
        return _all_commits_hexsha

    if not _all_commits_hexsha:
        pgs.checkout_postgresql_commit("master")

        head_commit = "HEAD"
        tail_commit = get_first_commit()

        all_sorted_tags = get_all_sorted_tags()
        all_sorted_tags = [tagref.commit for tagref in all_sorted_tags]
        all_sorted_tags = all_sorted_tags + [head_commit]

        for i in range(len(all_sorted_tags)):
            if i + 1 == len(all_sorted_tags):
                break
            left_tag = all_sorted_tags[i]
            right_tag = all_sorted_tags[i + 1]
            commits = get_commits_between_tags(left_tag, right_tag)
            commits.reverse()
            _all_commits_hexsha = _all_commits_hexsha + commits

        _all_commits_hexsha = [tail_commit] + _all_commits_hexsha

        utils.json_dump(_all_commits_hexsha, constants.POSTGRES_SORTED_COMMITS)

    return _all_commits_hexsha


def get_all_sorted_tags() -> List[git.TagReference]:
    global _all_sorted_tags

    if not _all_sorted_tags:
        unwant_tags_name = ["release-6-3"]
        repo = git.Repo(constants.POSTGRESQL_CHECKOUT_ROOT)
        _all_sorted_tags = [
            tagref
            for tagref in sorted(
                repo.tags, key=lambda tagref: LooseVersion(tagref.name)
            )
            if tagref.name not in unwant_tags_name
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
