FROM apache/airflow:2.10.2-python3.9

USER root
RUN apt-get update \
    && apt-get install unzip -y

USER airflow
COPY requirements.txt .
RUN pip install -r requirements.txt