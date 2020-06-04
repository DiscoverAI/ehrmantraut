FROM python:3.7
RUN pip install pipenv
WORKDIR /usr/src/app
ENV USER="ehrmantraut"
RUN adduser --disabled-password --home "$(pwd)" --no-create-home "$USER"
COPY Pipfile Pipfile.lock ./
RUN pipenv lock --requirements > requirements.txt && pip install -r ./requirements.txt
RUN chown -R "$USER":"$USER" /usr/src/app
USER $USER
CMD mlflow server --backend-store-uri ./mlflow --default-artifact-root s3://sars-cov-2-25309b4013524 --host 0.0.0.0
