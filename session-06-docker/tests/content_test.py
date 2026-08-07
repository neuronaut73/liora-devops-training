import os
import requests

API_ADDRESS = os.getenv("API_ADDRESS", "api")
API_PORT = os.getenv("API_PORT", "8000")
LOG_FILE = "/logs/api_test.log"

tests = [
    ("v1", "life is beautiful", "positive"),
    ("v1", "that sucks", "negative"),
    ("v2", "life is beautiful", "positive"),
    ("v2", "that sucks", "negative"),
]

results = []
all_success = True

for version, sentence, expected_sentiment in tests:
    response = requests.get(
        f"http://{API_ADDRESS}:{API_PORT}/{version}/sentiment",
        params={
            "username": "alice",
            "password": "wonderland",
            "sentence": sentence,
        },
        timeout=10,
    )

    if response.status_code == 200:
        score = response.json()["score"]

        if expected_sentiment == "positive":
            success = score > 0
        else:
            success = score < 0
    else:
        score = "N/A"
        success = False

    if not success:
        all_success = False

    results.append(
        f"""
model              = {version}
sentence           = "{sentence}"
expected sentiment = {expected_sentiment}
score              = {score}
result             = {"SUCCESS" if success else "FAILURE"}
"""
    )

output = f"""
================================
           CONTENT TEST
================================
{''.join(results)}
OVERALL: {"SUCCESS" if all_success else "FAILURE"}
"""

print(output)

if os.getenv("LOG") == "1":
    with open(LOG_FILE, "a") as file:
        file.write(output)

raise SystemExit(0 if all_success else 1)
