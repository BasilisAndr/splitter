FROM tiangolo/uwsgi-nginx-flask:python3.7 as build


RUN mkdir /dependencies
COPY ./requirements.txt /dependencies/requirements.txt
COPY ./setup.py /dependencies/setup.py
COPY ./files /dependencies/files


RUN pip3 install -r /dependencies/requirements.txt


FROM tiangolo/uwsgi-nginx-flask:python3.7 as production

RUN apt-get update && apt-get install -y wget
RUN wget https://apertium.projectjj.com/apt/install-nightly.sh -O - | bash
RUN apt-get -f install -y apertium-all-dev

COPY --from=build /dependencies /dependencies

COPY ./splitter_web /dependencies/splitter_web
RUN pip3 install /dependencies

COPY ./app /app
