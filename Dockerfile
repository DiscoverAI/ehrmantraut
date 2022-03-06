FROM python:3.10-slim
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r ./requirements.txt

ENV PYTHONPATH=/usr/src/app
ENV USER="ehrmantraut"
RUN useradd -M -s /bin/bash "$USER" && chown -R "$USER":"$USER" /usr/src/app
USER $USER

CMD ["mlflow", "server", "--backend-store-uri", "./mlflow", "--default-artifact-root", "$DATALAKE", "--host", "0.0.0.0"]
