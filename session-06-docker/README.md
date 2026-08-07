# Docker API Test Pipeline

## Overview

This project implements the Docker examination exercise for testing a sentiment-analysis FastAPI application.

The provided API image is:

`datascientest/fastapi:1.0.0`

Docker Compose is used to launch four containers:

1. `sentiment-api` - the FastAPI application
2. `authentication-test` - authentication tests
3. `authorization-test` - authorization tests
4. `content-test` - sentiment result tests

The three test containers communicate with the API through a dedicated Docker network.

---

## Project Structure

```text
.
├── README.md
├── remarks.md
├── api_test.log
├── docker-compose.yml
├── setup.sh
├── logs/
│   └── api_test.log
└── tests/
    ├── Dockerfile
    ├── requirements.txt
    ├── authentication_test.py
    ├── authorization_test.py
    └── content_test.py
```

---

## API Endpoints

The application exposes the following endpoints:

- `/status`
- `/permissions`
- `/v1/sentiment`
- `/v2/sentiment`

The API listens on port `8000`.

Inside the Docker network, the test containers access the API using:

`http://api:8000`

The Docker Compose service name `api` therefore acts as the internal DNS hostname.

---

## Tests

### Authentication

The following credentials are tested:

| Username | Password | Expected HTTP status |
| --- | --- | ---: |
| alice | wonderland | 200 |
| bob | builder | 200 |
| clementine | mandarine | 403 |

### Authorization

The following permissions are verified:

| User | API version | Expected HTTP status |
| --- | --- | ---: |
| alice | v1 | 200 |
| alice | v2 | 200 |
| bob | v1 | 200 |
| bob | v2 | 403 |

### Content

The account `alice / wonderland` is used.

Both API versions are tested with:

- `life is beautiful` -> expected positive score
- `that sucks` -> expected negative score

A positive result is validated with `score > 0`.

A negative result is validated with `score < 0`.

---

## Docker Test Image

A common Docker image is built from:

`tests/Dockerfile`

It contains all three Python test programs.

Docker Compose starts separate containers from this image and executes a different Python test script in each container.

This avoids duplicating Dockerfiles while preserving one independent container per test category.

---

## Docker Networking

All four services are connected to the same dedicated Docker network.

The test containers do not use `localhost` to access the API because `localhost` inside a container refers to that container itself.

Instead, they use the Docker Compose service name:

`api`

Therefore the API is reachable from the test containers at:

`http://api:8000`

---

## Logging

When the environment variable:

`LOG=1`

is configured, each test writes its results to:

`/logs/api_test.log`

The host directory `./logs` is mounted into each test container as `/logs`.

This allows the three independent test containers to append their results to the same log file.

The final test report is also copied to:

`api_test.log`

in the project root.

---

## Health Check

The API container includes a Docker health check using:

`/status`

The test containers depend on the API being healthy before they execute.

This prevents the tests from starting before FastAPI is ready to accept requests.

---

## CI/CD Behaviour

Each Python test returns:

- exit code `0` when all checks succeed
- a non-zero exit code when one or more checks fail

This makes the test containers suitable for use in an automated CI/CD pipeline.

The three test categories are independent:

- Authentication
- Authorization
- Content

A change to one test component therefore does not require changing the other test containers.

---

## Running the Complete Pipeline

Make the setup script executable:

```bash
chmod +x setup.sh
```

Then run:

```bash
./setup.sh
```

The script:

1. removes any previous Docker Compose environment
2. clears the previous test log
3. builds the Docker test image
4. starts the API and the three test containers
5. waits for all three tests to finish
6. checks their exit codes
7. prints the complete test report
8. copies the final log to `api_test.log`
9. stops the Docker Compose environment

If all tests pass, the script finishes with:

```text
ALL TESTS PASSED
```

---

## Manual Docker Compose Execution

The pipeline can also be started manually with:

```bash
docker compose up --build
```

The containers and network can be stopped and removed with:

```bash
docker compose down
```

---

## Test Results

The final `api_test.log` contains the results of all three test categories.

A successful execution contains:

```text
AUTHENTICATION TEST
OVERALL: SUCCESS

AUTHORIZATION TEST
OVERALL: SUCCESS

CONTENT TEST
OVERALL: SUCCESS
```

The current implementation successfully validates all required authentication, authorization and sentiment-content scenarios.
