FROM ubuntu:latest as build

LABEL maintainer="Sergey Sobko <ssobko@hse.ru>"

RUN mkdir /dependencies
COPY ./requirements.txt /dependencies/requirements.txt
COPY ./setup.py /dependencies/setup.py
COPY ./files /dependencies/files

RUN apt-get update && apt-get install -y python3-pip
RUN apt-get install -y default-libmysqlclient-dev

RUN pip3 install -r /dependencies/requirements.txt



FROM ubuntu:latest as production

RUN apt-get update && apt-get install -y python3-pip
RUN apt-get install -y python3.6
RUN alias python=python3
RUN echo "alias python=python3" >> ~/.bashrc


COPY --from=build /dependencies /dependencies



COPY ./splitter_web /dependencies/splitter_web
RUN pip3 install /dependencies

COPY ./app /app
