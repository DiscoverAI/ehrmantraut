# Ehrmantraut

[![Gitter](https://badges.gitter.im/discoverai/community.svg)](https://gitter.im/discoverai/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

> "You know, Walter, sometimes it doesn't hurt to have someone watching your back."
>
> -- Michael "Mike" Ehrmantraut (Breaking Bad)

Experiment tracking for computational drug design.

## Prerequisites
* Python >= 3.10, you can use for example [pyenv](https://github.com/pyenv/pyenv#installation) to manage that
* [Poetry](https://python-poetry.org/docs/#installation)

## Install
```bash
make install
```

## Config
Configuration is done by environment variables. Please make sure the environment variables are
set in some way.

Following environment variables are present:
```bash
DATALAKE=<s3 bucket path>
AWS_ACCESS_KEY_ID=<IAM user access key id that can read/write to the datalake>
AWS_SECRET_ACCESS_KEY=<IAM user secret access key that can read/write to the datalake>
```

## Run locally
```bash
make run
```
This will start a mlflow instance on http://localhost:5000
