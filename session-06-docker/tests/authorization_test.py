import os
import requests

API_ADDRESS = os.getenv("API_ADDRESS", "api")
API_PORT = os.getenv("API_PORT", "8000")
LOG_FILE = "/logs/api_test.log"

tests = [
    ("alice", "wonderland", "v1", 200),
    ("alice", "wonderland", "v2", 200),
    ("bob", "builder", "v1", 200),
    ("bob", "builder", "v2", 403),
]

results = []
all_success = True

for username, password, version, expected in tests:
    response = requests.get(
        f"http://{API_ADDRESS}:{API_PORT}/{version}/sentiment",
        params={
            "username": username,
            "password": password,
            "sentence": "life is beautiful",
        },
        timeout=10,
    )

    actual = response.status_code
    success = actual == expected

    if not success:
        all_success = False

    results.append(
        f"""
username        = {username}
model           = {version}
expected status = {expected}
actual status   = {actual}
result          = {"SUCCESS" if success else "FAILURE"}
"""
    )

output = f"""
================================
        AUTHORIZATION TEST
================================
{''.join(results)}
OVERALL: {"SUCCESS" if all_success else "FAILURE"}
"""

print(output)

if os.getenv("LOG") == "1":
    with open(LOG_FILE, "a") as file:
        file.write(output)

raise SystemExit(0 if all_success else 1)
