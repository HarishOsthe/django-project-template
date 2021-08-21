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
    /py/bin/pip install -r /requirements.txt && \
    adduser --disabled-password --no-create-home app

# app folder contains the django source code.
COPY ./app /app

# setting working directory
WORKDIR /app
EXPOSE 8000

# adds our virtual enviroment python to the PATH, so whenever we use python, it
# runs python from env. 
ENV PATH="/py/bin:$PATH"

# switching from root user to newly created user.
USER app