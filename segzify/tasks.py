#!/usr/bin/env python3
"""Tasks."""
import glob
import os
import subprocess
import sys
from shlex import quote

from segzify import Segzify

tasks = {}


def run(command: str, capture_output=False, text=None) -> subprocess.CompletedProcess:
    """Run command."""
    command = command.strip()
    print("+ ", command)
    env = os.environ.copy()
    return subprocess.run(
        command,
        capture_output=capture_output,
        check=True,
        env=env,
        shell=True,
        text=text,
    )


def task(function):
    """Define a task."""
    if function.__doc__:
        tasks[function.__name__] = function.__doc__

    def wrapper():
        function()

    return wrapper


@task
def format():
    """Format all files."""
    run("poetry run isort *.py segzify tests")
    run("poetry run black *.py segzify tests")
    for filename in glob.glob("*.md"):
        if Segzify().force_file(filename):
            print("Segzify", filename, "!")
        else:
            print("Segzify", filename)
        run("npx prettier --write {}".format(quote(filename)))


@task
def setup():
    """Setup this project."""
    run("poetry install")


@task
def test():
    """Test."""
    run("poetry check")
    run("poetry run isort -c *.py segzify tests")
    run("poetry run black --check *.py segzify tests")
    run("poetry run flake8 .")
    run("poetry run mypy *.py")
    run("poetry run coverage erase")
    run("poetry run coverage run -m unittest discover -s tests")
    run("poetry run coverage report -m")


@task
def upgrade():
    """Upgrade dependencies."""
    run("poetry update")


if __name__ == "__main__":
    if len(sys.argv) == 1 or sys.argv[1] == "help":
        for task_name, describe in tasks.items():
            print(f"{task_name.ljust(16)}\t{describe}")
        exit(0)
    for task_name in sys.argv[1:]:
        locals()[task_name]()
