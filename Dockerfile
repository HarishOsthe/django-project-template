FROM python:3.9-alpine3.13
LABEL maintainer="Harishosthe@gmail.com"

# print any output into the docker console without buffering it
ENV PYTHONUNBUFFERED 1

# contains all the dependencies for the project
COPY ./requirements.txt /requirements.txt

# creating a virtual enviroment for storing all the dependencies for the project. 
# and creating a user 'app'.
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app \
# creating folders that stores static files and media.
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol

# app folder contains the django source code.
COPY ./app /app

# scripts has the code for running your django app.
# COPY ./scripts /scripts
# RUN chmod -R +x /scripts

# setting working directory
WORKDIR /app
EXPOSE 8000

# adds our virtual enviroment python to the PATH, so whenever we use python, it
# runs python from env. 
ENV PATH="/scripts:/py/bin:$PATH"

# switching from root user to newly created user.
USER app

# CMD ["run.sh"]