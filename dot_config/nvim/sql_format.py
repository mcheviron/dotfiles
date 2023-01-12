import shlex
import subprocess
import sys

import sqlparse

query = sys.stdin.read()

echo = subprocess.Popen(
    shlex.split(f'echo "{query}"'),
    stdout=subprocess.PIPE,
)
sql_formatter = subprocess.Popen(
    shlex.split("sql-formatter"),
    stdin=echo.stdout,
    stdout=subprocess.PIPE,
)
sqlparse_query = sql_formatter.stdout.read().decode()

print(
    sqlparse.format(
        sqlparse_query,
        keyword_case="upper",
        identifier_case="lower",
        output_format="sql",
    ).strip()
)
