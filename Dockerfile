FROM python:3.9.16-slim-buster AS build

ENV PYTHONUNBUFFERED 1

RUN mkdir /code

WORKDIR /code

COPY requirements-dev.txt /code/

COPY requirements.txt /code/

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -r requirements-dev.txt

COPY . /code/

CMD [ "python", "./manage.py runserver 0.0.0.0:8000" ]