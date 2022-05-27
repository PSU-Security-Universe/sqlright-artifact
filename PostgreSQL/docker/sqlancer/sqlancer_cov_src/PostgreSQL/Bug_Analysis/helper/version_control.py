from logging import log
from git.objects import commit
from git import Repo
import os
import json
import shutil
import subprocess

from Bug_Analysis.bi_config import *
from Bug_Analysis.helper.data_struct import log_out_line


def execute_command_with_timeout(cmd_l, timeout=300):
    
    child = subprocess.Popen(
        cmd_l,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        stdin=subprocess.PIPE,
        errors="replace",
    )
    try:
        _ = child.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        child.kill()
        log_out_line("ERROR: Failed to run configure.\n")
        return "TIMEOUT"

    return child.returncode


def apply_copy_file_range_patch():
    cwd = os.getcwd()
    os.system("cp {} {}".format(POSTGRE_COMPILE_PATCH, POSTGRE_DIR))

    os.chdir(POSTGRE_DIR)
    os.system("patch -p1 -N --dry-run < {}".format(POSTGRE_COMPILE_PATCH))

    os.chdir(cwd)

def mayby_need_patch():
    postgre_copy_file_range_file = os.path.join(POSTGRE_DIR, "src/bin/pg_rewind/copy_fetch.c")
    return os.path.exists(postgre_copy_file_range_file)

class VerCon:

    all_commits_hexsha = []
    all_tags = []
    all_history_commits = []
    all_tags_sorted = {}

    @classmethod
    def get_all_commits(cls, repo: Repo):
        if len(cls.all_commits_hexsha) != 0 or len(cls.all_tags) != 0:
            return cls.all_commits_hexsha, cls.all_tags

        cls._checkout_commit("master")

        cls.all_commits_hexsha = repo.git.rev_list('--all').splitlines()

        all_tags_commit = {tagref: tagref.commit for tagref in repo.tags}
        all_tags_ranked = {}

        dump_tags_commit = {str(tagref): str(tagref.commit) for tagref in repo.tags}
        with open("dump_tags_commit.json", "w") as f:
            json.dump(dump_tags_commit, f, indent=2)

        for tagref, commit in all_tags_commit.items():
            commit = str(commit)
            all_tags_ranked[tagref] = cls.all_commits_hexsha.index(commit)
        cls.all_tags_sorted = {k: v for k, v in sorted(all_tags_ranked.items(), key=lambda item: item[1])}

        
        if END_COMMIT_ID != "":
            end_index = cls.all_commits_hexsha.index(END_COMMIT_ID)
            cls.all_commits_hexsha = cls.all_commits_hexsha[:end_index]
        if BEGIN_COMMIT_ID != "":
            begin_index = cls.all_commits_hexsha.index(BEGIN_COMMIT_ID)
            cls.all_commits_hexsha = cls.all_commits_hexsha[begin_index:]

        all_tags = sorted(repo.tags, key=lambda t: t.commit.committed_date)
        cls.all_tags = []
        for tag in all_tags:
            if tag.commit.hexsha in cls.all_commits_hexsha:
                cls.all_tags.append(tag)
        return cls.all_commits_hexsha, cls.all_tags

    @staticmethod
    def _checkout_commit(hexsha: str):
        os.system(f"rsync -avz -q -hH --delete {POSTGRE_PURE_DIR}/ {POSTGRE_DIR}")

        os.chdir(POSTGRE_DIR)
        with open(os.devnull, "wb") as devnull:
            subprocess.check_call(
                ["git", "checkout", hexsha, "--force"],
                stdout=devnull,
                stderr=subprocess.STDOUT,
            )
        log_out_line("Checkout commit completed. \n")

    @staticmethod
    def _compile_postgre_binary(CACHED_INSTALL_DEST_DIR: str) -> bool:
        if not os.path.isdir(CACHED_INSTALL_DEST_DIR):
            os.mkdir(CACHED_INSTALL_DEST_DIR)
        os.chdir(CACHED_INSTALL_DEST_DIR)
        with open(os.devnull, "wb") as devnull:
            result = subprocess.getstatusoutput(f"chmod +x {POSTGRE_DIR}/configure")
            if result[0] != 0:
                log_out_line("Compilation failed. Reason: %s. \n" % (result[1]))

            # result = execute_command_with_timeout(["../../configure", f"--prefix={CACHED_INSTALL_DEST_DIR}"])
            # if result == "TIMEOUT":
            #     log_out_line("Compilation failed. Reason: configure timeout. \n")
            #     return -1

            # if result != 0:
            #     log_out_line("Compilation failed. \n")
            #     return 1

            log_out_line(f"{POSTGRE_DIR}/configure --prefix={CACHED_INSTALL_DEST_DIR}")
            # os.system(f"{POSTGRE_DIR}/configure --prefix={CACHED_INSTALL_DEST_DIR}")
            result = subprocess.getstatusoutput(
                f"{POSTGRE_DIR}/configure --prefix={CACHED_INSTALL_DEST_DIR}"
            )
            if result[0] != 0:
                log_out_line("Compilation failed. Reason: %s. \n" % (result[1]))
                return 1

            log_out_line("make -j" + str(COMPILE_THREAD_COUNT))
            # os.system("make -j" + str(COMPILE_THREAD_COUNT))
            result = subprocess.getstatusoutput("make -j" + str(COMPILE_THREAD_COUNT))
            if result[0] != 0:
                log_out_line("Compilation failed. Reason: %s. \n" % (result[1]))
                return 1

            log_out_line("make install")
            # os.system("make install")
            result = subprocess.getstatusoutput("make install")
            if result[0] != 0:
                log_out_line("Installation failed. Reason: %s. \n" % (result[1]))
                return 1

        # if os.path.exists(os.path.join(CACHED_INSTALL_DEST_DIR, "bin/psql")):
        #     log_out_line("Compilation completed. ")
        #     return 0
        # else:
        #     return 1
        log_out_line("Compilation completed. ")
        return 0

    @classmethod
    def setup_POSTGRE_with_commit(cls, hexsha: str):
        """
        Given the Postgre commit ID, check out the commit and compile the Postgre source code.
        If succeed, return the Postgre binary directory (not included the binary name) str;
        if failed, return empty str.
        """
        log_out_line("Setting up Postgre with commitID: %s. \n" % (hexsha))
        if not os.path.isdir(POSTGRE_BLD_DIR):
            os.mkdir(POSTGRE_BLD_DIR)
        
        if os.path.exists(FAILED_COMPILE_COMMITS):
            with open(FAILED_COMPILE_COMMITS) as f:
                failed_compile_commits = set([commit.strip() for commit in f.readlines()])

            if hexsha in failed_compile_commits:
                return ""

        # INSTLL_DEST_DIR is not from the config file. It is being generated and immediately return in this function.
        INSTALL_DEST_DIR = os.path.join(POSTGRE_BLD_DIR, hexsha)
        if not os.path.isdir(INSTALL_DEST_DIR):  # Not precompiled.
            cls._checkout_commit(hexsha=hexsha)
            result = cls._compile_postgre_binary(
                CACHED_INSTALL_DEST_DIR=INSTALL_DEST_DIR
            )
            if result != 0:
                if not mayby_need_patch():
                    with open(FAILED_COMPILE_COMMITS, 'a') as f:
                        f.write(hexsha + '\n')
                    return ""

                # Compile failed, try to apply patch.
                log_out_line("Retry compiling postgre with copy-file-range.patch")
                apply_copy_file_range_patch()
                result = cls._compile_postgre_binary(
                    CACHED_INSTALL_DEST_DIR=INSTALL_DEST_DIR
                )
                if result != 0:
                    # compile failed.
                    with open(FAILED_COMPILE_COMMITS, 'a') as f:
                        f.write(hexsha + '\n')
                    return ""  

        elif not os.path.isfile(
            os.path.join(INSTALL_DEST_DIR, "bin/psql")
        ):  # Probably not compiled completely.
            log_out_line(
                "Warning: For commit: %s, installed dir exists, but postgre is not compiled probably. "
                % (hexsha)
            )
            shutil.rmtree(INSTALL_DEST_DIR)
            cls._checkout_commit(hexsha=hexsha)
            result = cls._compile_postgre_binary(
                CACHED_INSTALL_DEST_DIR=INSTALL_DEST_DIR
            )
            if result != 0:
                if not mayby_need_patch():
                    with open(FAILED_COMPILE_COMMITS, 'a') as f:
                        f.write(hexsha + '\n')
                    return ""
                    
                # Compile failed, try to apply patch.
                log_out_line("Retry compiling postgre with copy-file-range.patch")
                apply_copy_file_range_patch()
                result = cls._compile_postgre_binary(
                    CACHED_INSTALL_DEST_DIR=INSTALL_DEST_DIR
                )
                if result != 0:
                    # compile failed.
                    with open(FAILED_COMPILE_COMMITS, 'a') as f:
                        f.write(hexsha + '\n')
                    return ""  

        if os.path.isfile(
            os.path.join(INSTALL_DEST_DIR, "bin/psql")
        ):  # Compile successfully.
            return INSTALL_DEST_DIR
        else:  # Compile failed.
            with open(FAILED_COMPILE_COMMITS, 'a') as f:
                        f.write(hexsha + '\n')
            return ""
