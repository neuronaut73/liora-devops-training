FROM python:3.12-slim

WORKDIR /tests

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY authentication_test.py .
COPY authorization_test.py .
COPY content_test.py .
