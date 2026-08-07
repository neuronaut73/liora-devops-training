# Remarks and Technical Choices

## One reusable test image

A single Dockerfile is used for the three test containers.

The same image contains all three Python test scripts, while Docker Compose specifies a different command for each container.

This avoids unnecessary duplication while still respecting the requirement to execute Authentication, Authorization and Content tests in separate containers.

## Docker networking

All services belong to the same dedicated Docker network.

The test containers use the Docker Compose service name `api` to access the FastAPI container:

`http://api:8000`

Therefore no host IP address is hard-coded into the tests.

## API readiness

A health check on `/status` ensures that the API is available before the test containers are started.

## Shared logging

All test containers mount the same host directory at `/logs`.

When `LOG=1`, their results are appended to the shared `api_test.log`.

## CI/CD behaviour

Each Python test returns exit code `0` when successful and a non-zero exit code if a test fails.

This makes the containers suitable for use in an automated CI/CD pipeline.
