# Ehrmantraut
> "You know, Walter, sometimes it doesn't hurt to have someone watching your back."
>
> -- Michael "Mike" Ehrmantraut (Breaking Bad)

Experiment tracking for computational drug design.

## Install
```bash
pipenv install
```

## Config
Configuration is done by environment variables. Pipenv supports .env file logic, so you could create a .env file
containing the environment variables and their values. Apart from that please make sure the environment variables are
set in some way.

Following environment variables are present:
```bash
DATALAKE=<s3 bucket path>
AWS_ACCESS_KEY_ID=<IAM user access key id that can read/write to the datalake>
AWS_SECRET_ACCESS_KEY=<IAM user secret access key that can read/write to the datalake>
```

## Run
```bash
pipenv run start
```
