import os
import requests

API_ADDRESS = os.getenv("API_ADDRESS", "api")
API_PORT = os.getenv("API_PORT", "8000")
LOG_FILE = "/logs/api_test.log"

tests = [
    ("alice", "wonderland", 200),
    ("bob", "builder", 200),
    ("clementine", "mandarine", 403),
]

results = []
all_success = True

for username, password, expected in tests:
    response = requests.get(
        f"http://{API_ADDRESS}:{API_PORT}/permissions",
        params={
            "username": username,
            "password": password,
        },
        timeout=10,
    )

    actual = response.status_code
    success = actual == expected

    if not success:
        all_success = False

    results.append(
        f"""
username = {username}
expected status = {expected}
actual status   = {actual}
result          = {"SUCCESS" if success else "FAILURE"}
"""
    )

output = f"""
================================
       AUTHENTICATION TEST
================================
{''.join(results)}
OVERALL: {"SUCCESS" if all_success else "FAILURE"}
"""

print(output)

if os.getenv("LOG") == "1":
    with open(LOG_FILE, "a") as file:
        file.write(output)

raise SystemExit(0 if all_success else 1)
