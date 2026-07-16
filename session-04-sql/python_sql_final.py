#!/usr/bin/env python3
"""
Runs the eight Pokémon SQL queries for the Liora SQL exam.

    python3 python_sql_final.py

    PG_CONTAINER   Docker container name (default: pg_container)
    DB_USER        PostgreSQL user       (default: daniel)
    DB_NAME        PostgreSQL database   (default: exam_sql_wrede)
"""

from __future__ import annotations

import os
import subprocess
import sys
from textwrap import dedent


CONTAINER = os.getenv("PG_CONTAINER", "pg_container")
DB_USER = os.getenv("DB_USER", "daniel")
DB_NAME = os.getenv("DB_NAME", "exam_sql_wrede")


QUERIES: list[tuple[str, str]] = [
    (
        "Query 1 - Number of Pokémon by type",
        """
        SELECT
            t.name_type AS type,
            COUNT(DISTINCT pt.pokedex_number) AS count
        FROM pokemontype AS pt
        JOIN types AS t
            ON pt.type_id = t.type_id
        GROUP BY t.name_type
        ORDER BY count DESC, type;
        """,
    ),
    (
        "Query 2 - Pokémon with base total greater than 600",
        """
        SELECT
            p.name,
            p.base_total
        FROM pokemon AS p
        WHERE p.base_total > 600
        ORDER BY p.base_total DESC, p.name;
        """,
    ),
    (
        "Query 3 - Average base total by type",
        """
        SELECT
            t.name_type AS type,
            ROUND(AVG(p.base_total), 2) AS average_base_total
        FROM pokemon AS p
        JOIN pokemontype AS pt
            ON p.pokedex_number = pt.pokedex_number
        JOIN types AS t
            ON pt.type_id = t.type_id
        GROUP BY t.name_type
        ORDER BY average_base_total ASC, type;
        """,
    ),
    (
        "Query 4 - Pokémon with the ability Overgrow",
        """
        SELECT
            p.name,
            p.base_total
        FROM pokemon AS p
        JOIN pokemonability AS pa
            ON p.pokedex_number = pa.pokedex_number
        JOIN abilities AS a
            ON pa.ability_id = a.ability_id
        WHERE a.name_ability = 'Overgrow'
        ORDER BY p.base_total DESC, p.name;
        """,
    ),
    (
        "Query 5 - Primary and secondary Pokémon types",
        """
        SELECT
            p.name,
            (ARRAY_AGG(t.name_type ORDER BY pt.ctid))[1] AS primary_type,
            (ARRAY_AGG(t.name_type ORDER BY pt.ctid))[2] AS secondary_type
        FROM pokemon AS p
        JOIN pokemontype AS pt
            ON p.pokedex_number = pt.pokedex_number
        JOIN types AS t
            ON pt.type_id = t.type_id
        GROUP BY p.pokedex_number, p.name
        ORDER BY p.name;
        """,
    ),
    (
        "Query 6 - Pokémon above their generation average",
        """
        SELECT
            p.name,
            p.generation,
            p.base_total AS total_stats
        FROM pokemon AS p
        JOIN (
            SELECT
                generation,
                AVG(base_total) AS avg_total
            FROM pokemon
            GROUP BY generation
        ) AS generation_average
            ON p.generation = generation_average.generation
        WHERE p.base_total > generation_average.avg_total
        ORDER BY p.generation, p.name;
        """,
    ),
    (
        "Query 7 - Fire-type Pokémon with attack greater than 100",
        """
        SELECT DISTINCT
            p.name,
            s.attack
        FROM pokemon AS p
        JOIN stats AS s
            ON p.pokedex_number = s.pokedex_number
        JOIN pokemontype AS pt
            ON p.pokedex_number = pt.pokedex_number
        JOIN types AS t
            ON pt.type_id = t.type_id
        WHERE t.name_type = 'fire'
          AND s.attack > 100
        ORDER BY s.attack DESC, p.name;
        """,
    ),
    (
        "Query 8 - Comparison with the generation average",
        """
        SELECT
            p.name,
            p.generation,
            p.base_total AS total_stats,
            CASE
                WHEN p.base_total > generation_average.avg_total
                    THEN 'Above the generation average'
                WHEN p.base_total < generation_average.avg_total
                    THEN 'Below the generation average'
                ELSE 'Equal to the generation average'
            END AS total_stats_comparison
        FROM pokemon AS p
        JOIN (
            SELECT
                generation,
                AVG(base_total) AS avg_total
            FROM pokemon
            GROUP BY generation
        ) AS generation_average
            ON p.generation = generation_average.generation
        ORDER BY p.generation, p.name;
        """,
    ),
]


def check_container() -> None:
    """Fail early when Docker or the PostgreSQL container is unavailable."""
    try:
        result = subprocess.run(
            ["docker", "inspect", "-f", "{{.State.Running}}", CONTAINER],
            text=True,
            capture_output=True,
            check=False,
        )
    except FileNotFoundError:
        sys.exit("Error: Docker is not available in this shell.")

    if result.returncode != 0:
        sys.exit(
            f"Error: Docker container '{CONTAINER}' was not found.\n"
            f"{result.stderr.strip()}"
        )

    if result.stdout.strip().lower() != "true":
        sys.exit(f"Error: Docker container '{CONTAINER}' is not running.")


def run_query(title: str, sql: str) -> None:
    """Execute one SQL query through psql inside the PostgreSQL container."""
    print("\n" + "=" * 88)
    print(title)
    print("=" * 88)

    command = [
        "docker",
        "exec",
        "-i",
        CONTAINER,
        "psql",
        "-X",
        "-v",
        "ON_ERROR_STOP=1",
        "-P",
        "pager=off",
        "-U",
        DB_USER,
        "-d",
        DB_NAME,
        "-c",
        dedent(sql).strip(),
    ]

    result = subprocess.run(command, text=True, check=False)

    if result.returncode != 0:
        raise RuntimeError(f"{title} failed with exit code {result.returncode}.")


def main() -> int:
    check_container()

    print(
        f"Running {len(QUERIES)} queries against database '{DB_NAME}' "
        f"in container '{CONTAINER}'."
    )

    try:
        for title, sql in QUERIES:
            run_query(title, sql)
    except RuntimeError as exc:
        print(f"\nError: {exc}", file=sys.stderr)
        return 1

    print("\nAll queries completed successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
