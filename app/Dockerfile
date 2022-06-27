# syntax=docker/dockerfile:1dpdocker 
FROM python:3.9

RUN apt-get update && apt-get install

USER root

WORKDIR /app

RUN pip install --upgrade pip

COPY requirements.txt requirements.txt
RUN pip install --no-cache -r requirements.txt

ENV PATH="/app/.local/bin:${PATH}"

ADD . .

ENTRYPOINT ["python", "sendMail.py"]
