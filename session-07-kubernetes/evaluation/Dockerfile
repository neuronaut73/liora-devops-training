FROM ubuntu:22.04

COPY requirements.txt main.py ./

RUN apt update && \
    apt install python3-pip libmysqlclient-dev -y && \
    pip install -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:server", "--host", "0.0.0.0", "--port", "8000"]
