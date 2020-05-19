FROM python:3.7
RUN pip install pipenv
WORKDIR /usr/src/app
ENV USER=tuco
RUN adduser --disabled-password --home "$(pwd)" --no-create-home "$USER"
COPY Pipfile Pipfile.lock ./
RUN pipenv lock --requirements > requirements.txt && pip install -r ./requirements.txt
USER $USER
CMD [ "pipenv", "run", "start" ]
