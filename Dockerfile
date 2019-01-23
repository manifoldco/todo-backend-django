# pull official base image
FROM python:2.7-alpine

# set work directory
WORKDIR /usr/src/app

# install dependencies
COPY ./requirements.txt ./
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add postgresql-dev

RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . /usr/src/app/

ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:8000", "todo_backend_django.wsgi", "--log-file", "-"]
